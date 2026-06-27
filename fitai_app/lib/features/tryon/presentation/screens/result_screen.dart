import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';

import '../../../auth/data/auth_repository.dart';
import '../providers/tryon_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool _isDownloading = false;
  String? _currentImageUrl;
  Future<Uint8List>? _imageBytesFuture;

  // Récupère l'image via le Dio authentifié (Bearer token injecté automatiquement)
  Future<Uint8List> _fetchImage(String url) async {
    final dio = ref.read(apiClientProvider).dio;
    final response = await dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    return Uint8List.fromList(response.data!);
  }

  Future<void> _downloadImage(String url) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sur le Web, faites un clic droit sur l'image pour l'enregistrer.")),
      );
      return;
    }

    setState(() => _isDownloading = true);
    try {
      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) await Gal.requestAccess(toAlbum: true);

      final tempDir = await getTemporaryDirectory();
      final savePath = '${tempDir.path}/fitai_result.png';

      // Téléchargement avec auth via le même client Dio (File n'est pas appelé sur web)
      final dio = ref.read(apiClientProvider).dio;
      await dio.download(url, savePath);
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

  void _shareImage(String url) {
    SharePlus.instance.share(ShareParams(text: "Regarde mon nouvel essayage virtuel sur FitAI ! $url"));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tryOnProvider).value;
    final imageUrl = state?.resultImageUrl;

    // Lance le fetch une seule fois par URL (guard contre les rebuilds)
    if (imageUrl != null && imageUrl != _currentImageUrl) {
      _currentImageUrl = imageUrl;
      _imageBytesFuture = _fetchImage(imageUrl);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat'),
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
                  // Image chargée avec auth
                  FutureBuilder<Uint8List>(
                    future: _imageBytesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 400,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return const SizedBox(
                          height: 400,
                          child: Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Bouton Télécharger
                  ElevatedButton.icon(
                    onPressed: _isDownloading ? null : () => _downloadImage(imageUrl),
                    icon: _isDownloading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.download),
                    label: const Text("Télécharger l'image"),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                  const SizedBox(height: 16),

                  // Bouton Partager
                  OutlinedButton.icon(
                    onPressed: () => _shareImage(imageUrl),
                    icon: const Icon(Icons.share),
                    label: const Text("Partager"),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                  const SizedBox(height: 32),

                  // Bouton Nouvel essayage
                  TextButton.icon(
                    onPressed: () {
                      ref.read(tryOnProvider.notifier).reset();
                      context.go('/home');
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
