import os
from django.core.files import File
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status

from .models import TryOnRequest
from .serializers import TryOnRequestSerializer
from .services import TryOnService, TryOnAPIException

from django.http import FileResponse, HttpResponseForbidden, Http404
from rest_framework.views import APIView
from django.conf import settings

class TryOnListCreateView(generics.ListCreateAPIView):
    serializer_class = TryOnRequestSerializer
    permission_classes = [IsAuthenticated]
    parser_classes = [MultiPartParser, FormParser]

    def get_queryset(self):
        # Restriction stricte : l'utilisateur ne voit que ses propres demandes
        return TryOnRequest.objects.filter(user=self.request.user).order_by('-created_at')

    def create(self, request, *path, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_validate_by_drf = serializer.is_valid(raise_exception=True)
        
        # 1. Enregistrement initial en BDD avec le statut PENDING
        instance = serializer.save(user=self.request.user, status=TryOnRequest.Status.PROCESSING)
        
        try:
            # 2. Appel au service IA HuggingFace (synchrone, prend ~30s)
            generated_file_path = TryOnService.generate_tryon(
                person_image_path=instance.person_image.path,
                garment_image_path=instance.garment_image.path,
                garment_description=instance.garment_description or ""
            )
            
            # 3. Récupération et sauvegarde du fichier d'image généré dans le champ result_image
            with open(generated_file_path, 'rb') as f:
                instance.result_image.save(
                    os.path.basename(generated_file_path), 
                    File(f), 
                    save=False
                )
            
            instance.status = TryOnRequest.Status.COMPLETED
            
        except TryOnAPIException as exc:
            # En cas de timeout ou crash de l'API externe, on capture proprement l'état
            instance.status = TryOnRequest.Status.FAILED
            instance.save()
            return Response(
                {"error": str(exc), "request_id": instance.id}, 
                status=status.HTTP_502_BAD_GATEWAY
            )
        except Exception as exc:
            instance.status = TryOnRequest.Status.FAILED
            instance.save()
            return Response(
                {"error": "Une erreur interne est survenue lors de la génération.", "details": str(exc)}, 
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
            
        instance.save()
        # Re-sérialisation de l'instance mise à jour avec le résultat final
        return Response(TryOnRequestSerializer(instance).data, status=status.HTTP_201_CREATED)


class TryOnDetailView(generics.RetrieveAPIView):
    serializer_class = TryOnRequestSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'id'

    def get_queryset(self):
        # Protection d'accès : empêche la lecture d'un UUID appartenant à un tiers (renvoie 404)
        return TryOnRequest.objects.filter(user=self.request.user)
    
class ProtectedMediaView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, path):
        # Sécurité structurelle : on vérifie que le dossier utilisateur ciblé correspond à l'ID de la session active
        expected_folder = f"tryon_images/user_{request.user.id}/"
        
        if not path.startswith(expected_folder):
            return HttpResponseForbidden("Accès refusé : vous n'avez pas l'autorisation de consulter ce fichier.")
        
        full_file_path = os.path.join(settings.MEDIA_ROOT, path)
        
        if os.path.exists(full_file_path):
            # Le fichier existe et appartient à l'appelant, on le sert sous forme de flux binaire
            return FileResponse(open(full_file_path, 'rb'))
            
        raise Http404("Le fichier demandé n'existe pas.")