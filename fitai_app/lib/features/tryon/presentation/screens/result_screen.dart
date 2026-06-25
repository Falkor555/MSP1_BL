import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';

import '../providers/tryon_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool _isDownloading = false;

  // --- Logique de sauvegarde dans la galerie ---
  Future<void> _downloadImage(String url) async {
    // La galerie native n'existe pas sur le Web
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sur le Web, faites un clic droit sur l'image pour l'enregistrer.")),
      );
      return;
    }

    setState(() => _isDownloading = true);
    
    try {
      // 1. Vérification des permissions
      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) {
        await Gal.requestAccess(toAlbum: true);
      }

      // 2. Téléchargement temporaire via Dio
      final tempDir = await getTemporaryDirectory();
      final savePath = '${tempDir.path}/fitai_result.jpg';
      await Dio().download(url, savePath);

      // 3. Sauvegarde officielle dans la galerie
      await Gal.putImage(savePath);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image sauvegardée dans la galerie !"), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de sauvegarde : $e"), backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  // --- Logique de partage ---
  void _shareImage(String url) {
    // Partage simple du lien. L'OS s'occupe d'ouvrir les apps natives.
    Share.share("Regarde mon nouvel essayage virtuel sur FitAI ! $url");
  }

  @override
  Widget build(BuildContext context) {
    // On récupère l'état pour avoir l'URL générée
    final state = ref.watch(tryOnProvider).value;
    final imageUrl = state?.resultImageUrl;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat'),
        // Sécurité : on force le retour à l'accueil pour éviter un retour instable
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: imageUrl == null
          ? const Center(child: Text("Aucun résultat à afficher."))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. L'Image avec Spinner intégré
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const SizedBox(
                        height: 400,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(
                        height: 400,
                        child: Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 2. Bouton Télécharger
                  ElevatedButton.icon(
                    onPressed: _isDownloading ? null : () => _downloadImage(imageUrl),
                    icon: _isDownloading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.download),
                    label: const Text("Télécharger l'image"),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                  const SizedBox(height: 16),

                  // 3. Bouton Partager
                  OutlinedButton.icon(
                    onPressed: () => _shareImage(imageUrl),
                    icon: const Icon(Icons.share),
                    label: const Text("Partager"),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                  const SizedBox(height: 32),

                  // 4. Bouton Nouvel essayage (Reset State)
                  TextButton.icon(
                    onPressed: () {
                      ref.read(tryOnProvider.notifier).reset();
                      context.go('/home'); // Retourne sur l'écran d'accueil
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Faire un nouvel essayage"),
                    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ],
              ),
            ),
    );
  }
}