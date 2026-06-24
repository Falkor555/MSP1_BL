# 1. Utiliser une image Python officielle légère
FROM python:3.12-slim

# 2. Configurer les variables d'environnement de base pour Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Définir le dossier de travail dans le conteneur
WORKDIR /app

# 4. Installer les dépendances système nécessaires
# IMPORTANT : python-magic (présent dans tes requirements) a besoin de la bibliothèque libmagic pour fonctionner sur Linux
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

# 5. Copier et installer les dépendances Python
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copier le reste du code du projet Django dans le conteneur
COPY fitai_backend /app/

# 7. Exposer le port par défaut de Django
EXPOSE 8000

# 8. Commande de démarrage par défaut (serveur de développement)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]