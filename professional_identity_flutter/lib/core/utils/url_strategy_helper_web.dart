import 'package:flutter_web_plugins/url_strategy.dart';

/// Web implementation configuring clean URL path strategy (removing the # hash).
void configureUrlStrategy() {
  usePathUrlStrategy();
}
