import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/router/app_router.dart';

// Injection de dépendances via Riverpod
final apiClientProvider = Provider((ref) => ApiClient(storage: ref.read(secureStorageProvider)));

final authRepositoryProvider = Provider((ref) => AuthRepository(
  apiClient: ref.read(apiClientProvider),
  storage: ref.read(secureStorageProvider),
));

class AuthRepository {
  final ApiClient apiClient;
  final FlutterSecureStorage storage;

  AuthRepository({required this.apiClient, required this.storage});

  Future<void> login(String username, String password) async {
    final response = await apiClient.dio.post(
      ApiConstants.login,
      // On envoie "username" à Django au lieu de "email"
      data: {'username': username, 'password': password},
    );
    
    // Stockage des tokens en cas de succès (status 200)
    await storage.write(key: ApiConstants.accessTokenKey, value: response.data['access']);
    await storage.write(key: ApiConstants.refreshTokenKey, value: response.data['refresh']);
  }

  Future<void> register(String email, String username, String password) async {
    // Appel à l'API. On ne stocke pas de token ici, l'utilisateur devra se connecter après l'inscription.
    await apiClient.dio.post(
      ApiConstants.register,
      data: {'email': email, 'username': username, 'password': password},
    );
  }

  Future<void> logout() async {
    // Effacement de toute trace locale de l'utilisateur
    await storage.deleteAll();
  }
}