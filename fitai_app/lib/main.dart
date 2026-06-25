import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: FitAiApp()));
}

// FitAiApp devient un ConsumerWidget pour pouvoir lire les "Providers" de Riverpod
class FitAiApp extends ConsumerWidget {
  const FitAiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On récupère notre instance de GoRouter
    final router = ref.watch(routerProvider);

    // On utilise MaterialApp.router pour déléguer la navigation à go_router
    return MaterialApp.router(
      title: 'FitAI TryOn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router, // Injection de la configuration du routeur
    );
  }
}