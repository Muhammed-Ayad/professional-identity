import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../profile/logic/providers/profile_providers.dart';
import '../../logic/providers/profile_customization_providers.dart';
import '../widgets/customization_controls_section.dart';
import '../widgets/customization_preview.dart';

class ProfileCustomizationScreen extends HookConsumerWidget {
  const ProfileCustomizationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final customizationAsync = ref.watch(profileCustomizationNotifierProvider);
    final profileAsync = ref.watch(userProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Appearance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset to Saved',
            onPressed: () => ref
                .read(profileCustomizationNotifierProvider.notifier)
                .refresh(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: customizationAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: theme.colorScheme.error,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load customization',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    err.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(profileCustomizationNotifierProvider.notifier)
                        .refresh(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
          data: (customization) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;

                if (isWide) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column: Customization Controls
                            Expanded(
                              flex: 3,
                              child: CustomizationControlsSection(
                                ref: ref,
                                customization: customization,
                              ),
                            ),
                            const SizedBox(width: 32),
                            // Right Column: Live Preview
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_rounded,
                                        size: 20,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Live Profile Preview',
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Real-time rendering of your public profile with current customizations.',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  CustomizationPreview(
                                    profile: profileAsync.valueOrNull,
                                    customization: customization,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // Mobile Single Column Stacked Layout
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomizationControlsSection(
                            ref: ref,
                            customization: customization,
                          ),
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_rounded,
                                size: 20,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Live Profile Preview',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Real-time preview of your public identity.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          CustomizationPreview(
                            profile: profileAsync.valueOrNull,
                            customization: customization,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
