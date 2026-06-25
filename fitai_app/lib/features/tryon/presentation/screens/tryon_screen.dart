import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/tryon_provider.dart';
import '../widgets/image_picker_card.dart';

class TryOnScreen extends ConsumerStatefulWidget {
  const TryOnScreen({super.key});

  @override
  ConsumerState<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends ConsumerState<TryOnScreen> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lecture de l'état global du Provider (chargement, erreurs, images actuelles)
    final tryOnStateAsync = ref.watch(tryOnProvider);
    final tryOnState = tryOnStateAsync.value;
    final isLoading = tryOnStateAsync.isLoading;

    // Écouteur pour les "effets de bord" (Navigation & SnackBars)
    ref.listen<AsyncValue<TryOnState>>(tryOnProvider, (previous, next) {
      if (!next.isLoading && next.value != null) {
        final stateData = next.value!;

        // 1. Gestion des erreurs API
        if (stateData.errorMessage != null && 
           (previous?.value?.errorMessage != stateData.errorMessage)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(stateData.errorMessage!),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }

        // 2. Gestion du succès (On a récupéré une URL de résultat)
        if (stateData.resultImageUrl != null && previous?.value?.resultImageUrl == null) {
          context.push('/result');
        }
      }
    });

    // Le bouton est activé uniquement si les deux images sont là et qu'on ne charge pas
    final isButtonEnabled = tryOnState?.personImage != null && 
                            tryOnState?.garmentImage != null && 
                            !isLoading;

    // AbsorbPointer bloque toutes les interactions (clics, scroll) sur l'écran pendant le chargement
    return AbsorbPointer(
      absorbing: isLoading,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Photo de la personne
            ImagePickerCard(
              title: 'Votre photo',
              imageFile: tryOnState?.personImage,
              onImageSelected: (file) {
                ref.read(tryOnProvider.notifier).setPersonImage(file);
              },
            ),
            const SizedBox(height: 24),

            // 2. Photo du vêtement
            ImagePickerCard(
              title: 'Photo du vêtement',
              imageFile: tryOnState?.garmentImage,
              onImageSelected: (file) {
                ref.read(tryOnProvider.notifier).setGarmentImage(file);
              },
            ),
            const SizedBox(height: 24),

            // 3. Description (Indication pour l'IA)
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description du vêtement (optionnel)',
                hintText: 'Ex: t-shirt rouge à manches courtes...',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                ref.read(tryOnProvider.notifier).setDescription(text);
              },
            ),
            const SizedBox(height: 32),

            // 4. Bouton de génération ou Indicateur de chargement
            if (isLoading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Génération en cours (30-60s)...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        // On replie le clavier proprement avant d'envoyer
                        FocusScope.of(context).unfocus();
                        ref.read(tryOnProvider.notifier).submitTryOn();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Générer',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}