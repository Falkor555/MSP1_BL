from rest_framework import serializers
from .models import TryOnRequest

class TryOnRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = TryOnRequest
        fields = [
            'id', 
            'user', 
            'person_image', 
            'garment_image', 
            'garment_description', 
            'result_image', 
            'status', 
            'created_at'
        ]
        read_only_fields = ['id', 'user', 'result_image', 'status', 'created_at']