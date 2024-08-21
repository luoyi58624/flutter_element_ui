import 'package:luoyi_dart_base/luoyi_dart_base.dart';

String? getFullHref(String? href) {
  if (href == null) return null;
  if (DartUtil.isHttp(href)) return href;
  return null;
}
