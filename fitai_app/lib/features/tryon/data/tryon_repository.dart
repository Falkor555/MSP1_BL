import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/models/tryon_model.dart';

final tryOnRepositoryProvider = Provider((ref) => TryOnRepository(
  apiClient: ref.read(apiClientProvider),
));

class TryOnRepository {
  final ApiClient apiClient;

  TryOnRepository({required this.apiClient});

  // Création d'un essayage (Envoi des images)
  Future<TryOnModel> createTryOn(XFile personImage, XFile garmentImage, String description) async {
    final formData = FormData.fromMap({
      'garment_description': description,
      'person_image': MultipartFile.fromBytes(
        await personImage.readAsBytes(),
        filename: personImage.name,
      ),
      'garment_image': MultipartFile.fromBytes(
        await garmentImage.readAsBytes(),
        filename: garmentImage.name,
      ),
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