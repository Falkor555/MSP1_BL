import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "Une erreur inattendue est survenue.";

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = "Le serveur met trop de temps à répondre. Vérifiez votre connexion.";
        break;
      case DioExceptionType.connectionError:
        errorMessage = "Impossible de se connecter au serveur. Vérifiez votre accès internet.";
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 400) {
          errorMessage = "Requête invalide ou données incorrectes.";
        } else if (statusCode == 403) {
          errorMessage = "Vous n'avez pas l'autorisation d'effectuer cette action.";
        } else if (statusCode == 404) {
          errorMessage = "Ressource introuvable.";
        } else if (statusCode == 429) {
          errorMessage = "Trop de requêtes. Veuillez patienter un instant.";
        } else if (statusCode != null && statusCode >= 500) {
          errorMessage = "Erreur interne du serveur. Réessayez plus tard.";
        }
        break;
      default:
        break;
    }

    // On remplace le message technique par notre message formaté
    final modifiedError = err.copyWith(message: errorMessage);
    super.onError(modifiedError, handler);
  }
}