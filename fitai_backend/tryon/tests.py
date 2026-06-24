from django.test import TestCase
from django.core.exceptions import ValidationError
from django.core.files.uploadedfile import SimpleUploadedFile
from .validators import validate_image_file

from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from unittest.mock import patch

import tempfile
import os
from django.core.files.uploadedfile import SimpleUploadedFile

class ImageValidatorTests(TestCase):
    def setUp(self):
        # Simulation des signatures binaires (Magic Bytes) réelles
        self.valid_png_bytes = b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR' + b'\x00' * 50
        self.pdf_bytes = b'%PDF-1.4\n%\xd0\xd4\xc5\xd8\n' + b'\x00' * 50

    def test_valid_image(self):
        """Cas 1 : Fichier image parfaitement valide."""
        file = SimpleUploadedFile("test.png", self.valid_png_bytes, content_type="image/png")
        try:
            validate_image_file(file)
        except ValidationError:
            self.fail("validate_image_file() a rejeté une image valide.")

    def test_file_too_large(self):
        """Cas 2 : Fichier dépassant la limite de poids (10 Mo)."""
        class MockLargeFile:
            size = 11 * 1024 * 1024  # Simulation de 11 Mo
            def tell(self): return 0
            def seek(self, pos): pass
            def read(self, size): return b'\x89PNG\r\n\x1a\n' # Faux bytes justes pour passer la lecture

        with self.assertRaisesMessage(ValidationError, "trop lourde"):
            validate_image_file(MockLargeFile())

    def test_invalid_mime_type(self):
        """Cas 3 : Fichier avec un mauvais type MIME réel (ex: un PDF)."""
        file = SimpleUploadedFile("document.pdf", self.pdf_bytes, content_type="application/pdf")
        
        with self.assertRaisesMessage(ValidationError, "Type de fichier invalide détecté"):
            validate_image_file(file)

    def test_spoofed_extension(self):
        """Cas 4 : Extension falsifiée (ex: Un PDF renommé en .jpg pour tromper le serveur)."""
        # On passe du contenu binaire PDF, mais on lui donne le nom et le content_type d'un JPEG
        file = SimpleUploadedFile("fake_image.jpg", self.pdf_bytes, content_type="image/jpeg")
        
        with self.assertRaisesMessage(ValidationError, "Type de fichier invalide détecté"):
            validate_image_file(file)

    def test_empty_file(self):
        """Cas 5 : Fichier totalement vide."""
        file = SimpleUploadedFile("empty.jpg", b"", content_type="image/jpeg")
        
        with self.assertRaisesMessage(ValidationError, "Le fichier est vide"):
            validate_image_file(file)

User = get_user_model()

class TryOnRateLimitingTests(APITestCase):
    def setUp(self):
        from PIL import Image
        import io
        
        self.user = User.objects.create_user(username="testuser", password="password123")
        self.client.force_authenticate(user=self.user)
        self.url = reverse('tryon-list-create')
        
        # --- NOUVEAU : Génération d'une VRAIE image PNG de 1x1 pixel pour les tests
        img = Image.new('RGB', (1, 1), color='black')
        img_io = io.BytesIO()
        img.save(img_io, format='PNG')
        self.valid_img_bytes = img_io.getvalue()
        # --- Fin du nouveau code

    @patch('tryon.services.TryOnService.generate_tryon')
    def test_rate_limiting_after_ten_requests(self, mock_generate):
        """Vérifie qu'après 10 requêtes réussies, la 11ème renvoie un code HTTP 429."""
        
        temp_result = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
        temp_result.write(self.valid_img_bytes)  # <--- CORRIGÉ ICI
        temp_result.close()
        
        mock_generate.return_value = temp_result.name
        
        try:
            for i in range(10):
                
                person_img = SimpleUploadedFile(f"person_{i}.png", self.valid_img_bytes, content_type="image/png")
                garment_img = SimpleUploadedFile(f"garment_{i}.png", self.valid_img_bytes, content_type="image/png")
                
                payload = {
                    'garment_description': 'T-shirt de test',
                    'person_image': person_img,
                    'garment_image': garment_img
                }
                
                response = self.client.post(self.url, payload, format='multipart')
                self.assertEqual(
                    response.status_code, 
                    status.HTTP_201_CREATED, 
                    f"Échec à la requête {i+1}. Erreur: {response.data}"
                )

            # 11ème requête
            
            person_img = SimpleUploadedFile("person_11.png", self.valid_img_bytes, content_type="image/png")
            garment_img = SimpleUploadedFile("garment_11.png", self.valid_img_bytes, content_type="image/png")
            
            final_response = self.client.post(self.url, {
                'garment_description': 'T-shirt de test',
                'person_image': person_img,
                'garment_image': garment_img
            }, format='multipart')
            
            self.assertEqual(final_response.status_code, status.HTTP_429_TOO_MANY_REQUESTS)
            
        finally:
            os.unlink(temp_result.name)

class TryOnAPISecurityTests(APITestCase):
    def setUp(self):
        from PIL import Image
        import io
        
        # Création de deux utilisateurs distincts
        self.user1 = User.objects.create_user(
            username="user1", 
            email="user1@example.com", 
            password="password123"
        )
        self.user2 = User.objects.create_user(
            username="user2", 
            email="user2@example.com", 
            password="password123"
        )
        # ---------------------------------------------------
        
        self.list_url = reverse('tryon-list-create')
        
        img = Image.new('RGB', (1, 1), color='black')
        img_io = io.BytesIO()
        img.save(img_io, format='PNG')
        self.valid_img_bytes = img_io.getvalue()
        
        # Image factice valide
        img = Image.new('RGB', (1, 1), color='black')
        img_io = io.BytesIO()
        img.save(img_io, format='PNG')
        self.valid_img_bytes = img_io.getvalue()

    def test_post_without_token_returns_401(self):
        """Cas : POST /api/tryon/ sans token -> 401 attendu"""
        response = self.client.post(self.list_url, {})
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    @patch('tryon.services.TryOnService.generate_tryon')
    def test_post_with_valid_images_returns_201(self, mock_generate):
        """Cas : POST /api/tryon/ avec images valides -> 201 attendu"""
        import tempfile
        import os
        from django.core.files.uploadedfile import SimpleUploadedFile
        
        self.client.force_authenticate(user=self.user1)
        
        temp_result = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
        temp_result.write(self.valid_img_bytes)
        temp_result.close()
        mock_generate.return_value = temp_result.name
        
        try:
            person_img = SimpleUploadedFile("person.png", self.valid_img_bytes, content_type="image/png")
            garment_img = SimpleUploadedFile("garment.png", self.valid_img_bytes, content_type="image/png")
            
            response = self.client.post(self.list_url, {
                'garment_description': 'Un t-shirt',
                'person_image': person_img,
                'garment_image': garment_img
            }, format='multipart')
            
            self.assertEqual(response.status_code, status.HTTP_201_CREATED)
            # Vérification que le statut est bien passé à COMPLETED
            self.assertEqual(response.data['status'], 'COMPLETED')
        finally:
            os.unlink(temp_result.name)

    def test_get_list_isolation_between_users(self):
        """Cas : GET /api/tryon/ : un user ne voit pas les données d'un autre user"""
        from tryon.models import TryOnRequest
        from django.core.files.uploadedfile import SimpleUploadedFile
        
        # Création directe en BDD d'une requête pour user1
        dummy_img = SimpleUploadedFile("dummy.png", self.valid_img_bytes, content_type="image/png")
        req1 = TryOnRequest.objects.create(
            user=self.user1,
            person_image=dummy_img,
            garment_image=dummy_img,
            garment_description="Requête de user 1"
        )
        
        # L'utilisateur 2 se connecte et interroge la liste
        self.client.force_authenticate(user=self.user2)
        response = self.client.get(self.list_url)
        
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        # La liste doit être vide pour user2
        self.assertEqual(len(response.data['results']) if 'results' in response.data else len(response.data), 0)
        
        # L'utilisateur 1 se connecte, il doit voir sa requête
        self.client.force_authenticate(user=self.user1)
        response_user1 = self.client.get(self.list_url)
        data = response_user1.data['results'] if 'results' in response_user1.data else response_user1.data
        self.assertEqual(len(data), 1)
        self.assertEqual(data[0]['garment_description'], "Requête de user 1")