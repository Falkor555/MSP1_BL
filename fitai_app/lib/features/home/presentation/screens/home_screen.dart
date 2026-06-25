import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../../../tryon/presentation/screens/tryon_screen.dart';
import '../../../tryon/history_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Index de l'onglet actif (0 = Essayer, 1 = Historique)
  int _currentIndex = 0;

  // Liste des écrans à afficher
  final List<Widget> _screens = const [
    TryOnScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Écoute de notre provider de profil pour récupérer le nom
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        // Affichage dynamique selon l'état de la requête réseau
        title: profileAsync.when(
          data: (username) => Text('Bonjour, $username', style: const TextStyle(fontSize: 20)),
          loading: () => const Text('Chargement...'),
          error: (_, _) => const Text('FitAI'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
          )
        ],
      ),
      // IndexedStack conserve l'état des écrans enfants
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Essayer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
        ],
      ),
    );
  }
}