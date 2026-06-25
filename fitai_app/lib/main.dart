import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

void main() {
  // ProviderScope permet à Riverpod de fonctionner dans toute l'app
  runApp(const ProviderScope(child: FitAiApp()));
}

class FitAiApp extends StatelessWidget {
  const FitAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitAI TryOn',
      debugShowCheckedModeBanner: false, // Enlève le petit bandeau "DEBUG"
      theme: AppTheme.lightTheme, // On applique notre thème ici !
      
      // Pour l'instant, un simple écran d'accueil temporaire
      home: Scaffold(
        appBar: AppBar(title: const Text('FitAI')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bienvenue sur FitAI', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Bouton Thémé'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}