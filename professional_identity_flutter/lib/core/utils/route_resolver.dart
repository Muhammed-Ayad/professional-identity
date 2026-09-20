/// Resolves the intended initial route from the current application environment.
///
/// Supports:
/// - Explicit parameter override: `/u/:handle`
/// - Web URL hash fragment: `/#/u/:handle` or `/#u/:handle`
/// - Web URL pathname: `/u/:handle`
/// - Default root route: `'/'`
String resolveInitialRoute([String? routeOverride]) {
  if (routeOverride != null &&
      routeOverride.trim().isNotEmpty &&
      routeOverride != '/') {
    final override = routeOverride.trim();
    if (override.startsWith('/u/')) {
      return override;
    }
  }

  try {
    final uri = Uri.base;

    // 1. Check hash fragment (common in web redirects or hash URL strategy)
    if (uri.fragment.isNotEmpty) {
      var frag = uri.fragment.trim();
      if (!frag.startsWith('/')) {
        frag = '/$frag';
      }
      if (frag.startsWith('/u/')) {
        return frag;
      }
    }

    // 2. Check path (standard path routing in web browser address bar)
    if (uri.path.startsWith('/u/')) {
      return uri.path.trim();
    }
  } catch (_) {
    // Graceful fallback for non-web environments
  }

  return (routeOverride != null && routeOverride.isNotEmpty)
      ? routeOverride
      : '/';
}
