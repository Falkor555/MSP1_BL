import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';
import '../../../../core/constants/api_constants.dart';

// Un FutureProvider est parfait pour une requête unique (ex: récupérer un profil)
final profileProvider = FutureProvider<String>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  
  try {
    final response = await apiClient.dio.get(ApiConstants.profile);
    // On suppose que ton backend renvoie un JSON avec un champ 'username'
    return response.data['username'] ?? 'Utilisateur';
  } catch (e) {
    // En cas d'erreur (ex: endpoint pas encore codé côté backend), on renvoie une valeur par défaut
    return 'Utilisateur';
  }
});