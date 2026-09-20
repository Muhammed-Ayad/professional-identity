import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import '../routes/public_profile_seo_route.dart';

/// Middleware that intercepts `/u/<handle>` GET requests and serves
/// server-rendered SEO HTML with Open Graph / Twitter Card metadata
/// for public profiles.
///
/// This must run as middleware (not a standalone route) because the
/// `FlutterRoute` catch-all at `/` would otherwise intercept these
/// paths via its SPA fallback before the SEO route is reached.
///
/// Behavior:
/// - Public profile found → serves SEO HTML (with redirect for browsers).
/// - Profile not found or not public → falls through to `FlutterRoute`.
Handler seoMiddleware(Handler next) {
  return (Request request) async {
    if (request.method != Method.get) {
      return next(request);
    }

    // Match /u/<handle> (whether mounted at '/' or '/u')
    final segments = request.url.pathSegments;
    String rawHandle;
    if (segments.length == 2 && segments[0] == 'u') {
      rawHandle = segments[1].trim();
    } else if (segments.length == 1 && request.url.path.startsWith('/u/')) {
      rawHandle = segments[0].trim();
    } else {
      return next(request);
    }
    if (rawHandle.isEmpty) {
      return next(request);
    }

    final normalizedHandle = rawHandle.toLowerCase();

    // Query the database for a public profile
    final session = await request.session;
    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalizedHandle) & t.isPublic.equals(true),
    );

    // Profile not found or not public → let the SPA handle it
    if (profile == null || !profile.isPublic) {
      return next(request);
    }

    // Build and serve the SEO HTML using the existing static helper
    final requestHost =
        request.headers.host?.toString() ?? 'app.professionalidentity.dev';
    final scheme = request.url.scheme.isNotEmpty ? request.url.scheme : 'https';

    final userAgent = (request.headers.userAgent ?? '').toLowerCase();
    final isCrawler = PublicProfileSeoRoute.isCrawlerUserAgent(userAgent);

    final html = PublicProfileSeoRoute.buildSeoHtml(
      profile,
      host: requestHost,
      scheme: scheme,
      isCrawler: isCrawler,
    );

    return Response.ok(
      body: Body.fromString(html, mimeType: MimeType.html),
    );
  };
}
