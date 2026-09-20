import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../../client.dart';
import '../repo/auth_repository.dart';

final clientProvider = Provider<Client>((ref) => client);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(clientProvider));
});

/// Reactive stream provider emitting whether the user is currently authenticated.
final authStateProvider = StreamProvider<bool>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  final controller = StreamController<bool>();

  void listener() {
    if (!controller.isClosed) {
      controller.add(repo.isAuthenticated);
    }
  }

  // Emit initial state
  controller.add(repo.isAuthenticated);
  repo.authInfoListenable.addListener(listener);

  ref.onDispose(() {
    repo.authInfoListenable.removeListener(listener);
    controller.close();
  });

  return controller.stream;
});
