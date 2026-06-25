import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthInterceptor(this.dio, this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. On lit le token d'accès
    final accessToken = await storage.read(key: ApiConstants.accessTokenKey);
    
    // 2. Si on a un token et qu'on ne fait pas une requête de login/register, on l'injecte
    if (accessToken != null && !options.path.contains('login') && !options.path.contains('register')) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 3. Gestion de l'expiration du token (Erreur 401)
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.read(key: ApiConstants.refreshTokenKey);
      
      if (refreshToken != null) {
        try {
          // On utilise une NOUVELLE instance de Dio pour éviter une boucle infinie avec cet intercepteur
          final refreshDio = Dio();
          final response = await refreshDio.post(
            ApiConstants.tokenRefresh,
            data: {'refresh': refreshToken},
          );

          // Sauvegarde du nouveau token
          final newAccessToken = response.data['access'];
          await storage.write(key: ApiConstants.accessTokenKey, value: newAccessToken);

          // 4. On relance la requête initiale qui avait échoué avec le nouveau token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';
          
          final cloneReq = await dio.fetch(options);
          return handler.resolve(cloneReq);
          
        } catch (e) {
          // Si le refresh échoue (ex: refresh token expiré lui aussi), on purge le stockage
          await storage.deleteAll();
          // Ici, tu pourras déclencher une redirection vers l'écran de login via Riverpod ou GoRouter
        }
      }
    }
    return handler.next(err);
  }
}