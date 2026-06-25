class ApiConstants {
  // Changer cette adresse en fonction de comment l'app est lancée
  // 127.0.0.1 (Web), 10.0.2.2 (Émulateur Android) ou l'IP du PC (vrai téléphone)
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // --- Endpoints ---
  
  // Utilisateurs (Auth)
  static const String login = '$baseUrl/auth/token/';        // SimpleJWT login
  static const String register = '$baseUrl/auth/register/';  // Inscription
  static const String profile = '$baseUrl/auth/profile/';    // Profil utilisateur (à venir côté back)

  // TryOn
  static const String tryon = '$baseUrl/tryon/';             // Création et listing des essayages

  // --- Auth Tokens ---
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String tokenRefresh = '$baseUrl/auth/token/refresh/'; // Rafraîchissement du token
}