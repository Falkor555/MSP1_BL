from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    # On force l'email à être unique pour pouvoir l'utiliser comme identifiant de connexion plus tard si besoin
    email = models.EmailField(unique=True)

    def __str__(self):
        return self.username