import time
import os
from gradio_client import Client, handle_file

def test_virtual_tryon():
    print("⏳ Initialisation du client Gradio...")
    
    # Remplacer par n'importe quel modèle d'essayage virtuel sur HuggingFace Spaces
    # Exemple populaire : "Nymbo/Virtual-Try-On" ou un Space privé/dédié
    SPACE_ID = "yisol/IDM-VTON"
    
    # Récupération du token depuis les variables d'environnement si nécessaire
    hf_token = os.getenv("HUGGINGFACE_TOKEN", "")

    try:
        # Initialisation du client
        client = Client(SPACE_ID, token=hf_token if hf_token else None)
        
        # Chemins vers deux images de test locales (à créer dans le dossier pour le test)
        person_img_path = "test_person.jpg"
        garment_img_path = "test_garment.jpg"
        description = "Débardeur de sport Homme Grenat NYC"

        # Vérification de l'existence des images de test
        if not os.path.exists(person_img_path) or not os.path.exists(garment_img_path):
            print("❌ Erreur : Créez 'test_person.jpg' et 'test_garment.jpg' à la racine pour tester.")
            return

        print("🚀 Envoi de la requête à HuggingFace (cela peut prendre 30 à 60 secondes)...")
        start_time = time.time()

        # Construction du dictionnaire requis pour le composant Imageeditor
        person_image_dict = {
            "background": handle_file(person_img_path),
            "layers": [],
            "composite": None
        }

        # Appel de l'API Gradio avec les 7 paramètres exacts
        result = client.predict(
            person_image_dict,              # 1. Le dictionnaire Imageeditor (contenant la personne)
            handle_file(garment_img_path),  # 2. Image du vêtement
            description,                    # 3. Description du vêtement
            True,                           # 4. is_checked
            False,                          # 5. is_checked_crop
            30,                             # 6. denoise_steps
            42,                             # 7. seed
            api_name="/tryon"
        )

        end_time = time.time()
        execution_time = end_time - start_time
        
        # L'image finale générée est le premier élément du tuple de retour
        final_image = result[0]

        print("✅ Requête réussie !")
        print(f"⏱️ Temps de réponse de l'API : {execution_time:.2f} secondes")
        print(f"📂 Résultat sauvegardé par Gradio ici : {final_image}")

    except Exception as e:
        print(f"❌ Une erreur est survenue lors de l'appel API : {e}")

if __name__ == "__main__":
    test_virtual_tryon()