import uuid
import os
from django.db import models
from django.conf import settings

def get_file_path_with_uuid(instance, filename):
    """
    Génère un nom de fichier sécurisé basé sur un UUID pour éviter 
    les conflits de noms et les failles de type path traversal.
    """
    ext = filename.split('.')[-1]
    filename = f"{uuid.uuid4()}.{ext}"
    
    # Range les images dans un sous-dossier par type de requête ou ID utilisateur
    return os.path.join(f"tryon_images/user_{instance.user.id}", filename)

class TryOnRequest(models.Model):
    class Status(models.TextChoices):
        PENDING = 'PENDING', 'En attente'
        PROCESSING = 'PROCESSING', 'En cours de traitement'
        COMPLETED = 'COMPLETED', 'Terminé'
        FAILED = 'FAILED', 'Échoué'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='tryon_requests')
    
    person_image = models.ImageField(upload_to=get_file_path_with_uuid)
    garment_image = models.ImageField(upload_to=get_file_path_with_uuid)
    garment_description = models.TextField(blank=True, null=True)
    
    # Le résultat sera vide au moment de la création
    result_image = models.ImageField(upload_to=get_file_path_with_uuid, blank=True, null=True)
    
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PENDING)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Request {self.id} - {self.user.username} ({self.status})"
    