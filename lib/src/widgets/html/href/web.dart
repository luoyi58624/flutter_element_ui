import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:web/web.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

final hash = urlStrategy is PathUrlStrategy ? '' : '/#';

String? getFullHref(String? href) {
  if (href == null) return null;
  if (DartUtil.isHttp(href)) return href;
  return window.location.origin + hash + href;
}
