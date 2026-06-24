from rest_framework.throttling import UserRateThrottle

class TryOnRateThrottle(UserRateThrottle):
    """
    Limitation spécifique pour la création de requêtes d'essayage virtuel.
    Le taux exact est configuré via le paramètre 'tryon_creation' dans les settings.
    """
    scope = 'tryon_creation'