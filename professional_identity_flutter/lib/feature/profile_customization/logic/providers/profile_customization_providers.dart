import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

import '../models/profile_customization_theme.dart';
import '../repo/profile_customization_repository.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';

/// Provider for the singleton ProfileCustomizationRepository.
final profileCustomizationRepositoryProvider =
    Provider<ProfileCustomizationRepository>((ref) {
      return ProfileCustomizationRepository();
    });

/// AsyncNotifier managing active profile customization settings and save operations.
final profileCustomizationNotifierProvider =
    AsyncNotifierProvider<ProfileCustomizationNotifier, ProfileCustomization>(
      () {
        return ProfileCustomizationNotifier();
      },
    );

class ProfileCustomizationNotifier extends AsyncNotifier<ProfileCustomization> {
  @override
  FutureOr<ProfileCustomization> build() async {
    final repo = ref.read(profileCustomizationRepositoryProvider);
    final existing = await repo.getCustomization();
    return existing ?? ProfileCustomizationTheme.defaultCustomization;
  }

  void setThemePreset(String presetId) {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    final preset = ProfileCustomizationTheme.presets.firstWhere(
      (p) => p.id == presetId,
      orElse: () => ProfileCustomizationTheme.presets.first,
    );

    state = AsyncValue.data(
      current.copyWith(
        themePreset: preset.id,
        primaryColor: preset.defaultColor,
        backgroundStyle: preset.backgroundStyle,
        cardStyle: preset.cardStyle,
        borderRadius: preset.borderRadius,
        typographyStyle: preset.typographyStyle,
      ),
    );
  }

  void setPrimaryColor(String? color) {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    state = AsyncValue.data(current.copyWith(primaryColor: color));
  }

  void setBackgroundStyle(String style) {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    state = AsyncValue.data(current.copyWith(backgroundStyle: style));
  }

  void setCardStyle(String style) {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    state = AsyncValue.data(current.copyWith(cardStyle: style));
  }

  void setBorderRadius(String radius) {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    state = AsyncValue.data(current.copyWith(borderRadius: radius));
  }

  void setTypographyStyle(String typography) {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    state = AsyncValue.data(current.copyWith(typographyStyle: typography));
  }

  Future<void> saveCustomization() async {
    final current =
        state.valueOrNull ?? ProfileCustomizationTheme.defaultCustomization;
    final repo = ref.read(profileCustomizationRepositoryProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updated = await repo.updateCustomization(
        themePreset: current.themePreset,
        primaryColor: current.primaryColor,
        backgroundStyle: current.backgroundStyle,
        cardStyle: current.cardStyle,
        borderRadius: current.borderRadius,
        typographyStyle: current.typographyStyle,
      );
      ref.invalidate(publicProfileFamilyProvider);
      return updated;
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileCustomizationRepositoryProvider);
      final existing = await repo.getCustomization();
      return existing ?? ProfileCustomizationTheme.defaultCustomization;
    });
  }
}
