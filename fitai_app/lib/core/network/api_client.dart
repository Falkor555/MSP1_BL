import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';

class ApiClient {
  late final Dio dio;
  final FlutterSecureStorage storage;

  ApiClient({required this.storage}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30), // L'IA peut prendre jusqu'à 30s
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Ajout de nos intercepteurs dans l'ordre de traitement
    dio.interceptors.addAll([
      AuthInterceptor(dio, storage),
      ErrorInterceptor(),
      
      // Très pratique pour le débogage : affiche les requêtes/réponses dans le terminal
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    ]);
  }
}