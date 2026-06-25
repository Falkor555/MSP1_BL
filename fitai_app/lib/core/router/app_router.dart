import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/api_constants.dart';
// Importe tes écrans ici (ajuste les chemins si besoin)
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/tryon/tryon_screen.dart';
import '../../features/tryon/history_screen.dart';
import '../../features/tryon/result_screen.dart';

// Provider pour injecter facilement le stockage sécurisé
final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

// Provider principal du routeur
final routerProvider = Provider<GoRouter>((ref) {
  final storage = ref.watch(secureStorageProvider);

  return GoRouter(
    initialLocation: '/home',
    // Le "Guard" de redirection : s'exécute avant chaque changement de route
    redirect: (context, state) async {
      // 1. Vérification de la présence du token JWT
      final token = await storage.read(key: ApiConstants.accessTokenKey);
      final isLoggedIn = token != null;

      // 2. Où l'utilisateur essaie-t-il d'aller ?
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';

      // 3. Logique de protection
      // S'il n'est pas connecté et qu'il essaie d'aller ailleurs que sur Login/Register -> Dehors
      if (!isLoggedIn && !isGoingToLogin && !isGoingToRegister) {
        return '/login';
      }

      // S'il est DÉJÀ connecté et qu'il essaie de retourner sur Login/Register -> Redirection vers Home
      if (isLoggedIn && (isGoingToLogin || isGoingToRegister)) {
        return '/home';
      }

      // Si tout est OK, on le laisse passer (return null)
      return null;
    },
    
    // Définition de toutes les routes de l'application
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/tryon', builder: (context, state) => const TryOnScreen()),
      GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
      GoRoute(path: '/result', builder: (context, state) => const ResultScreen()),
    ],
  );
});