import logging
import time
from gradio_client import Client, handle_file
from django.conf import settings

# Initialisation du logger spécifique à ce service
logger = logging.getLogger('tryon.services')

class TryOnAPIException(Exception):
    """Exception personnalisée pour capturer les coupures, timeouts ou indisponibilités de HuggingFace."""
    pass

class TryOnService:
    SPACE_ID = "yisol/IDM-VTON"  # Modèle open-source de référence

    @classmethod
    def generate_tryon(cls, person_image_path: str, garment_image_path: str, garment_description: str) -> str:
        """
        Prend les chemins locaux des images, appelle l'API HuggingFace de manière sécurisée,
        loggue les performances et retourne le chemin temporaire de l'image générée.
        """
        logger.info(f"Début de la génération TryOn pour le Space {cls.SPACE_ID}")
        
        # Récupération du token HuggingFace configuré dans le .env / settings
        hf_token = getattr(settings, 'HUGGINGFACE_TOKEN', None)
        
        start_time = time.time()
        
        try:
            client = Client(
                cls.SPACE_ID,
                token=hf_token if hf_token else None,
                httpx_kwargs={"timeout": 300},  # 5 min — IDM-VTON peut prendre 60-90s en cold start
            )
            
            logger.info("Envoi des fichiers et de la description à l'API Gradio (IDM-VTON)...")
            
            # Encapsulation de l'image de la personne dans le dictionnaire requis
            person_image_dict = {
                "background": handle_file(person_image_path),
                "layers": [],
                "composite": None
            }
            
            # Appel effectif à l'API avec les 7 paramètres positionnels adaptés
            result = client.predict(
                person_image_dict,                 # 1. Le dictionnaire contenant l'image de la personne
                handle_file(garment_image_path),   # 2. Image du vêtement
                garment_description,               # 3. Description du vêtement
                True,                              # 4. is_checked
                False,                             # 5. is_checked_crop
                30,                                # 6. denoise_steps
                42,                                # 7. seed
                api_name="/tryon"                  # Nom exact de l'endpoint
            )
            
            duration = time.time() - start_time
            
            # Le modèle renvoie un tuple, on extrait la première image (output final)
            final_image_path = result[0]
            
            logger.info(f"✅ Génération réussie en {duration:.2f} secondes. Fichier temporaire obtenu : {final_image_path}")
            
            return final_image_path
            
        except Exception as exc:
            duration = time.time() - start_time
            logger.error(f"❌ Échec de l'appel à l'API HuggingFace après {duration:.2f}s. Erreur : {str(exc)}")
            raise TryOnAPIException(f"Le service d'essayage virtuel est indisponible ou a expiré : {str(exc)}")