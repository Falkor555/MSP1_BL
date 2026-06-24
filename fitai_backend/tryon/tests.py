from django.test import TestCase
from django.core.exceptions import ValidationError
from django.core.files.uploadedfile import SimpleUploadedFile
from .validators import validate_image_file

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