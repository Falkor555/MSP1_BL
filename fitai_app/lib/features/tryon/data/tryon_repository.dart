import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../auth/data/auth_repository.dart'; // Pour récupérer le apiClientProvider
import '../domain/models/tryon_model.dart';

final tryOnRepositoryProvider = Provider((ref) => TryOnRepository(
  apiClient: ref.read(apiClientProvider),
));

class TryOnRepository {
  final ApiClient apiClient;

  TryOnRepository({required this.apiClient});

  // Création d'un essayage (Envoi des images)
  Future<TryOnModel> createTryOn(File personImage, File garmentImage, String description) async {
    // 1. Préparation de l'enveloppe multipart
    final formData = FormData.fromMap({
      'description': description,
      // Les clés 'person_image' et 'garment_image' doivent correspondre exactement aux noms attendus par ton API Django
      'person_image': await MultipartFile.fromFile(personImage.path),
      'garment_image': await MultipartFile.fromFile(garmentImage.path),
    });

    // 2. Envoi au serveur
    final response = await apiClient.dio.post(
      ApiConstants.tryon,
      data: formData,
    );

    // 3. Transformation de la réponse JSON en objet Dart
    return TryOnModel.fromJson(response.data);
  }

  // Récupération de l'historique
  Future<List<TryOnModel>> getTryOns() async {
    final response = await apiClient.dio.get(ApiConstants.tryon);
    
    // Transforme la liste JSON en liste d'objets TryOnModel
    return (response.data as List).map((json) => TryOnModel.fromJson(json)).toList();
  }
}