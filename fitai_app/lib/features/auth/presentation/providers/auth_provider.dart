import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';

class AuthNotifier extends AsyncNotifier<void> {
  late AuthRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.watch(authRepositoryProvider);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading(); 
    state = await AsyncValue.guard(() => _repository.login(username, password));
    
    if (state.hasError) {
      // Relance l'erreur pour que le widget puisse afficher la SnackBar
      throw _extractErrorMessage(state.error); 
    }
  }

  Future<void> register(String email, String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.register(email, username, password));
    
    if (state.hasError) {
      throw _extractErrorMessage(state.error);
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.logout());
  }

  // Petit utilitaire pour extraire proprement le message d'erreur de Dio (ErrorInterceptor)
  String _extractErrorMessage(Object? error) {
    if (error is DioException) {
      // Tente d'extraire le message retourné par le backend Django, sinon fallback sur le message de l'intercepteur
      final data = error.response?.data;
      if (data != null && data is Map<String, dynamic> && data.containsKey('detail')) {
        return data['detail'];
      }
      return error.message ?? "Erreur inattendue.";
    }
    return error.toString();
  }
}

// Le Provider que les vues vont écouter
final authProvider = AsyncNotifierProvider<AuthNotifier, void>(AuthNotifier.new);