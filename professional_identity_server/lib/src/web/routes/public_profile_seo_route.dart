import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';

/// Route serving server-rendered HTML with Open Graph, Twitter Cards,
/// and canonical metadata for public profile discovery when requested by
/// search engine crawlers, social share bots, or web browsers.
///
/// PRIVACY & SECURITY GUARANTEES:
/// - Only handles public profiles (`isPublic == true`).
/// - Private profiles return 404 Not Found without leaking existence.
/// - Never includes user IDs, email addresses, phone numbers, or internal database IDs.
/// - Encodes and escapes all text to prevent XSS.
class PublicProfileSeoRoute extends Route {
  /// Known crawler / social-share bot user-agent substrings (lowercase).
  static const crawlerUserAgents = [
    'bot',
    'crawler',
    'spider',
    'googlebot',
    'bingbot',
    'slurp',
    'duckduckbot',
    'baiduspider',
    'yandexbot',
    'sogou',
    'exabot',
    'facebot',
    'facebookexternalhit',
    'ia_archiver',
    'twitterbot',
    'linkedinbot',
    'embedly',
    'quora link preview',
    'showyoubot',
    'outbrain',
    'pinterest/0.',
    'developers.google.com/+/web/snippet',
    'slackbot',
    'vkshare',
    'w3c_validator',
    'redditbot',
    'applebot',
    'whatsapp',
    'flipboard',
    'tumblr',
    'bitlybot',
    'skypeuripreview',
    'nuzzel',
    'discordbot',
    'google page speed',
    'qwantify',
    'pinterestbot',
    'bitrix link preview',
    'xing-content-tab-receiver',
    'telegrambot',
  ];

  /// Returns `true` if [userAgent] (already lowercased) matches a known
  /// crawler or social-share bot.
  static bool isCrawlerUserAgent(String userAgent) =>
      crawlerUserAgents.any((bot) => userAgent.contains(bot));

  PublicProfileSeoRoute() : super(methods: {Method.get});

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final rawHandle = request.pathParameters.raw[#handle];
    if (rawHandle == null || rawHandle.trim().isEmpty) {
      return Response.notFound();
    }

    final normalizedHandle = rawHandle.trim().toLowerCase();

    // Query profile from database: enforce isPublic == true
    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalizedHandle) & t.isPublic.equals(true),
    );

    if (profile == null || !profile.isPublic) {
      return Response.notFound();
    }

    // Determine host and protocol for canonical URL
    final requestHost =
        request.headers.host?.toString() ??
        'professional-identity.serverpod.space';
    final scheme = request.url.scheme.isNotEmpty ? request.url.scheme : 'https';

    final userAgent = (request.headers.userAgent ?? '').toLowerCase();
    final isCrawler = isCrawlerUserAgent(userAgent);

    final html = buildSeoHtml(
      profile,
      host: requestHost,
      scheme: scheme,
      isCrawler: isCrawler,
    );

    return Response.ok(
      body: Body.fromString(html, mimeType: MimeType.html),
    );
  }

  /// Builds the full HTML document with Open Graph, Twitter Cards, canonical link,
  /// and JSON/HTML escaping for the given [profile].
  static String buildSeoHtml(
    Profile profile, {
    String host = 'professional-identity.serverpod.space',
    String scheme = 'https',
    bool isCrawler = true,
  }) {
    final canonicalUrl = '$scheme://$host/u/${profile.handle}';

    // Construct metadata
    final title = '${profile.fullName} | Professional Identity';
    final description =
        (profile.headline != null && profile.headline!.trim().isNotEmpty)
        ? profile.headline!.trim()
        : ((profile.bio != null && profile.bio!.trim().isNotEmpty)
              ? profile.bio!.trim()
              : 'Verified digital professional identity and portfolio for ${profile.fullName}.');

    final safeTitle = _escapeHtml(title);
    final safeDesc = _escapeHtml(description);
    final safeCanonicalUrl = _escapeHtml(canonicalUrl);
    final safeName = _escapeHtml(profile.fullName);
    final avatarUrl = profile.avatarUrl;
    final safeAvatarUrl = (avatarUrl != null && avatarUrl.isNotEmpty)
        ? _escapeHtml(avatarUrl)
        : null;

    final html = StringBuffer();
    html.writeln('<!DOCTYPE html>');
    html.writeln('<html lang="en">');
    html.writeln('<head>');
    html.writeln('  <meta charset="UTF-8">');
    html.writeln(
      '  <meta name="viewport" content="width=device-width, initial-scale=1.0">',
    );
    html.writeln('  <title>$safeTitle</title>');
    html.writeln('  <meta name="description" content="$safeDesc">');
    html.writeln('  <link rel="canonical" href="$safeCanonicalUrl">');
    html.writeln('  <!-- Open Graph / Facebook -->');
    html.writeln('  <meta property="og:type" content="profile">');
    html.writeln('  <meta property="og:title" content="$safeTitle">');
    html.writeln('  <meta property="og:description" content="$safeDesc">');
    html.writeln('  <meta property="og:url" content="$safeCanonicalUrl">');
    html.writeln(
      '  <meta property="profile:username" content="${_escapeHtml(profile.handle)}">',
    );
    if (safeAvatarUrl != null) {
      html.writeln('  <meta property="og:image" content="$safeAvatarUrl">');
    }
    html.writeln('  <!-- Twitter / X -->');
    html.writeln('  <meta name="twitter:card" content="summary">');
    html.writeln('  <meta name="twitter:title" content="$safeTitle">');
    html.writeln('  <meta name="twitter:description" content="$safeDesc">');
    if (safeAvatarUrl != null) {
      html.writeln('  <meta name="twitter:image" content="$safeAvatarUrl">');
    }
    html.writeln('  <meta name="robots" content="index, follow">');

    // If human browser, add client-side redirection to Flutter app
    if (!isCrawler) {
      html.writeln(
        '  <meta http-equiv="refresh" content="0; url=/#/u/${_escapeHtml(profile.handle)}">',
      );
      html.writeln('  <script>');
      html.writeln(
        '    window.location.replace("/#/u/" + encodeURIComponent("${_escapeJs(profile.handle)}"));',
      );
      html.writeln('  </script>');
    }

    html.writeln('  <style>');
    html.writeln(
      '    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #F8FAFC; color: #0F172A; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px; box-sizing: border-box; }',
    );
    html.writeln(
      '    .card { background: white; border-radius: 16px; border: 1px solid #E2E8F0; padding: 32px; max-width: 480px; width: 100%; box-shadow: 0 4px 12px rgba(0,0,0,0.05); text-align: center; }',
    );
    html.writeln(
      '    .avatar { width: 72px; height: 72px; border-radius: 50%; background: #2563EB; color: white; display: inline-flex; align-items: center; justify-content: center; font-size: 28px; font-weight: bold; margin-bottom: 16px; }',
    );
    html.writeln(
      '    h1 { margin: 0 0 8px; font-size: 22px; font-weight: 700; }',
    );
    html.writeln(
      '    p.headline { margin: 0 0 16px; font-size: 15px; color: #475569; }',
    );
    html.writeln(
      '    p.desc { margin: 0 0 24px; font-size: 13px; color: #64748B; line-height: 1.5; }',
    );
    html.writeln(
      '    .cta { display: inline-block; background: #2563EB; color: white; padding: 10px 24px; border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 600; }',
    );
    html.writeln('  </style>');
    html.writeln('</head>');
    html.writeln('<body>');
    html.writeln('  <div class="card">');
    final initial = profile.fullName.isNotEmpty
        ? profile.fullName[0].toUpperCase()
        : '?';
    html.writeln('    <div class="avatar">${_escapeHtml(initial)}</div>');
    html.writeln('    <h1>$safeName</h1>');
    if (profile.headline != null && profile.headline!.isNotEmpty) {
      html.writeln(
        '    <p class="headline">${_escapeHtml(profile.headline!)}</p>',
      );
    }
    html.writeln('    <p class="desc">$safeDesc</p>');
    html.writeln(
      '    <a class="cta" href="/#/u/${_escapeHtml(profile.handle)}">View Full Professional Profile</a>',
    );
    html.writeln('  </div>');
    html.writeln('</body>');
    html.writeln('</html>');

    return html.toString();
  }

  static String _escapeHtml(String text) {
    return const HtmlEscape(
      HtmlEscapeMode.attribute,
    ).convert(text).replaceAll("'", '&#39;');
  }

  static String _escapeJs(String text) {
    return text
        .replaceAll(r'\', r'\\')
        .replaceAll("'", r"\'")
        .replaceAll('"', r'\"');
  }
}
