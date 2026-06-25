import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/tryon_repository.dart';

// 1. La classe qui contient toutes les données de l'écran d'essayage
class TryOnState {
  final File? personImage;
  final File? garmentImage;
  final String description;
  final String? resultImageUrl;
  final String? errorMessage; // Permet de stocker une erreur sans casser l'état global

  TryOnState({
    this.personImage,
    this.garmentImage,
    this.description = '',
    this.resultImageUrl,
    this.errorMessage,
  });

  // Le copyWith est indispensable pour modifier un seul champ à la fois
  TryOnState copyWith({
    File? personImage,
    File? garmentImage,
    String? description,
    String? resultImageUrl,
    String? errorMessage,
  }) {
    return TryOnState(
      personImage: personImage ?? this.personImage,
      garmentImage: garmentImage ?? this.garmentImage,
      description: description ?? this.description,
      resultImageUrl: resultImageUrl ?? this.resultImageUrl,
      errorMessage: errorMessage, // Si non spécifié, on l'efface
    );
  }
}

// 2. Le Notifier qui pilote ces données
class TryOnNotifier extends AsyncNotifier<TryOnState> {
  late TryOnRepository _repository;

  @override
  FutureOr<TryOnState> build() {
    _repository = ref.watch(tryOnRepositoryProvider);
    return TryOnState(); // État initial vide au chargement de l'écran
  }

  // Méthodes pour mettre à jour l'interface au fur et à mesure que l'utilisateur agit
  void setPersonImage(File file) {
    state = AsyncData(state.value!.copyWith(personImage: file, errorMessage: null));
  }

  void setGarmentImage(File file) {
    state = AsyncData(state.value!.copyWith(garmentImage: file, errorMessage: null));
  }

  void setDescription(String text) {
    state = AsyncData(state.value!.copyWith(description: text));
  }

  // L'appel final vers le backend
  Future<void> submitTryOn() async {
    final currentState = state.value;
    
    // Vérification locale avant d'envoyer
    if (currentState == null || currentState.personImage == null || currentState.garmentImage == null) {
      state = AsyncData(currentState!.copyWith(errorMessage: "Veuillez sélectionner les deux images."));
      return;
    }

    // Passage en mode chargement (l'UI affichera le spinner)
    state = const AsyncLoading();

    try {
      final result = await _repository.createTryOn(
        currentState.personImage!,
        currentState.garmentImage!,
        currentState.description,
      );
      
      // Succès : On remet l'état précédent en y ajoutant l'URL de l'image générée
      state = AsyncData(currentState.copyWith(resultImageUrl: result.resultImageUrl, errorMessage: null));
      
    } catch (e) {
      // Échec : On extrait l'erreur et on remet les images pour que l'utilisateur puisse réessayer
      String errorMsg = "Une erreur est survenue lors de l'essayage.";
      if (e is DioException) {
        errorMsg = e.message ?? errorMsg;
      }
      state = AsyncData(currentState.copyWith(errorMessage: errorMsg));
    }
  }
  
  // Permet de réinitialiser complètement l'écran pour un nouvel essayage
  void reset() {
    state = AsyncData(TryOnState());
  }
}

// 3. Le Provider que l'interface va écouter
final tryOnProvider = AsyncNotifierProvider<TryOnNotifier, TryOnState>(TryOnNotifier.new);