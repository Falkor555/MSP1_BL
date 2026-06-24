import filetype
from django.core.exceptions import ValidationError

def validate_image_file(file):
    """
    Valide un fichier image uploadé : non vide, max 10Mo, et format MIME réel vérifié.
    """
    if not file or file.size == 0:
        raise ValidationError("Le fichier est vide.")

    max_size_mb = 10
    if file.size > max_size_mb * 1024 * 1024:
        raise ValidationError(f"L'image est trop lourde (maximum {max_size_mb} Mo).")

    initial_pos = file.tell()
    file.seek(0)
    file_header = file.read(2048)
    file.seek(initial_pos)

    # Utilisation de filetype au lieu de magic
    kind = filetype.guess(file_header)
    mime_type = kind.mime if kind else 'application/octet-stream'
    
    allowed_mimes = ['image/jpeg', 'image/png', 'image/webp']

    if mime_type not in allowed_mimes:
        raise ValidationError(
            f"Type de fichier invalide détecté ({mime_type}). Seuls les formats JPEG, PNG et WebP sont autorisés."
        )