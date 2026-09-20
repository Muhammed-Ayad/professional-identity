import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'client.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/route_resolver.dart';
import 'core/utils/url_strategy_helper.dart'
    if (dart.library.js_interop) 'core/utils/url_strategy_helper_web.dart';
import 'feature/auth/logic/providers/auth_providers.dart';
import 'feature/auth/view/screens/auth_screen.dart';
import 'feature/dashboard/view/screens/dashboard_screen.dart';
import 'feature/public_profile/view/screens/public_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();
  await initializeClient();
  runApp(
    const ProviderScope(
      child: ProfessionalIdentityApp(),
    ),
  );
}

class ProfessionalIdentityApp extends ConsumerWidget {
  final String? initialRoute;

  const ProfessionalIdentityApp({super.key, this.initialRoute});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startRoute = resolveInitialRoute(initialRoute);

    return MaterialApp(
      title: 'Professional Identity',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: startRoute,
      onGenerateInitialRoutes: (initialRouteName) {
        final target = resolveInitialRoute(
          initialRouteName != '/' ? initialRouteName : startRoute,
        );
        if (target.startsWith('/u/')) {
          final handle = target.substring('/u/'.length).trim();
          return [
            MaterialPageRoute<void>(
              settings: RouteSettings(name: target),
              builder: (_) => PublicProfileScreen(handle: handle),
            ),
          ];
        }
        return [
          MaterialPageRoute<void>(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const AuthGate(),
          ),
        ];
      },
      onGenerateRoute: (settings) {
        final name = settings.name;
        if (name != null && name.startsWith('/u/')) {
          final handle = name.substring('/u/'.length).trim();
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => PublicProfileScreen(handle: handle),
          );
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const AuthGate(),
        );
      },
    );
  }
}

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Auth error: $error'),
        ),
      ),
      data: (isAuthenticated) {
        if (isAuthenticated) {
          return const DashboardScreen();
        }
        return const AuthScreen();
      },
    );
  }
}
