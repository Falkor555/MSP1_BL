from rest_framework import serializers
from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password')
        extra_kwargs = {
            'password': {'write_only': True}  # Le mot de passe ne sera jamais renvoyé par l'API
        }

    def create(self, validated_data):
        # Utilisation obligatoire de create_user pour hacher correctement le mot de passe en base
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )
        return user