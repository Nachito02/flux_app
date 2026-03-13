

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flux_pos/features/auth/presentation/screens/register_screen.dart';
import 'package:flux_pos/features/auth/presentation/screens/screens.dart';
import 'package:flux_pos/features/products/presentation/screens/scanner_screen.dart';
import 'package:flux_pos/features/products/presentation/screens/screens.dart';
import 'app_router_notifier.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),  

      ///* Product Routes
      GoRoute(
        path: '/scanner',
        builder: (context, state) => const ScannerScreen(),
      ),

      ///* Product Routes
      // GoRoute(
      //   path: '/product/:id',
      //   builder: (context, state) => ProductScreen(
      //     productId: state.params['id'] ?? 'no-id',
      //   ),
      // ),
    ],
    redirect: (context, state) { 
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/home';
        }
      }

      return null;
    },
  );
});
