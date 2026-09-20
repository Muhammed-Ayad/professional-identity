import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../../logic/providers/auth_providers.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(clientProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / Branding Header
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.15,
                            ),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fingerprint_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Professional Identity',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your verified single-link professional profile, portfolio, and identity for the developer ecosystem.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.65,
                      ),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Auth Card
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withValues(alpha: 0.7),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _CustomSignInWidget(
                            client: client,
                            onAuthenticated: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully authenticated!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            onError: (error, screen) {
                              String message;
                              final errStr = error.toString();
                              if (screen == EmailFlowScreen.startRegistration ||
                                  errStr.contains('already registered') ||
                                  errStr.contains(
                                    'Invalid verification code',
                                  )) {
                                message =
                                    'This email address is already registered. Please sign in or use Forgot Password.';
                              } else {
                                message = errStr;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor: theme.colorScheme.error,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomSignInWidget extends StatefulWidget {
  final dynamic client;
  final VoidCallback onAuthenticated;
  final void Function(Object error, EmailFlowScreen screen) onError;

  const _CustomSignInWidget({
    required this.client,
    required this.onAuthenticated,
    required this.onError,
  });

  @override
  State<_CustomSignInWidget> createState() => _CustomSignInWidgetState();
}

class _CustomSignInWidgetState extends State<_CustomSignInWidget> {
  late final EmailAuthController _emailController;
  EmailFlowScreen? _previousScreen;

  @override
  void initState() {
    super.initState();
    _emailController = EmailAuthController(
      client: widget.client,
      startScreen: EmailFlowScreen.login,
      onAuthenticated: widget.onAuthenticated,
      onError: (error) {
        widget.onError(error, _emailController.currentScreen);
      },
    );
    _previousScreen = _emailController.currentScreen;
    _emailController.addListener(_onScreenChanged);
  }

  void _onScreenChanged() {
    final current = _emailController.currentScreen;
    if (_previousScreen != current) {
      if (current == EmailFlowScreen.requestPasswordReset ||
          current == EmailFlowScreen.startRegistration ||
          current == EmailFlowScreen.login) {
        _emailController.verificationCodeController.clear();
      }
      _previousScreen = current;
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_onScreenChanged);
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignInWidget(
      client: widget.client,
      onAuthenticated: widget.onAuthenticated,
      onError: (error) {
        widget.onError(error, _emailController.currentScreen);
      },
      emailSignInWidget: EmailSignInWidget(
        controller: _emailController,
      ),
    );
  }
}
