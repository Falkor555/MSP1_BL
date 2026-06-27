import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/tryon_repository.dart';
import '../../domain/models/tryon_model.dart';

// 1. La classe qui contient toutes les données de l'écran d'essayage
class TryOnState {
  final XFile? personImage;
  final XFile? garmentImage;
  final String description;
  final String? resultImageUrl;
  final String? errorMessage;

  TryOnState({
    this.personImage,
    this.garmentImage,
    this.description = '',
    this.resultImageUrl,
    this.errorMessage,
  });

  TryOnState copyWith({
    XFile? personImage,
    XFile? garmentImage,
    String? description,
    String? resultImageUrl,
    String? errorMessage,
  }) {
    return TryOnState(
      personImage: personImage ?? this.personImage,
      garmentImage: garmentImage ?? this.garmentImage,
      description: description ?? this.description,
      resultImageUrl: resultImageUrl ?? this.resultImageUrl,
      errorMessage: errorMessage,
    );
  }
}

// 2. Le Notifier qui pilote ces données et l'historique
class TryOnNotifier extends AsyncNotifier<TryOnState> {
  late TryOnRepository _repository;
  List<TryOnModel> history = []; // Stockage local de l'historique

  @override
  FutureOr<TryOnState> build() {
    _repository = ref.watch(tryOnRepositoryProvider);
    return TryOnState();
  }

  // --- Gestion de l'historique ---
  Future<void> fetchHistory() async {
    state = const AsyncLoading();
    try {
      history = await _repository.getTryOns();
      state = AsyncData(TryOnState()); // On réinitialise l'état de l'écran après chargement
    } catch (e) {
      state = AsyncData(TryOnState(errorMessage: "Erreur lors du chargement de l'historique"));
    }
  }

  // Pour sélectionner un élément dans l'historique et naviguer vers le résultat
  void selectResult(TryOnModel item) {
    state = AsyncData(TryOnState(resultImageUrl: item.resultImageUrl));
  }

  // --- Méthodes d'essayage ---
  void setPersonImage(XFile file) => state = AsyncData(state.value!.copyWith(personImage: file, errorMessage: null));
  void setGarmentImage(XFile file) => state = AsyncData(state.value!.copyWith(garmentImage: file, errorMessage: null));
  void setDescription(String text) => state = AsyncData(state.value!.copyWith(description: text));

  Future<void> submitTryOn() async {
    final currentState = state.value;
    if (currentState == null || currentState.personImage == null || currentState.garmentImage == null) {
      state = AsyncData(currentState!.copyWith(errorMessage: "Veuillez sélectionner les deux images."));
      return;
    }

    state = const AsyncLoading();
    try {
      final result = await _repository.createTryOn(
        currentState.personImage!,
        currentState.garmentImage!,
        currentState.description,
      );
      state = AsyncData(currentState.copyWith(resultImageUrl: result.resultImageUrl, errorMessage: null));
    } catch (e) {
      String errorMsg;
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final serverError = e.response?.data?['error'] as String?;
        errorMsg = serverError ?? "Erreur serveur (HTTP $statusCode).";
      } else {
        errorMsg = "Erreur inattendue : ${e.runtimeType}";
      }
      state = AsyncData(currentState.copyWith(errorMessage: errorMsg));
    }
  }
  
  void reset() => state = AsyncData(TryOnState());
}

final tryOnProvider = AsyncNotifierProvider<TryOnNotifier, TryOnState>(TryOnNotifier.new);