import 'package:flutter_element_ui/src/global.dart';
import 'package:web/web.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'link.dart';

final hash = urlStrategy is PathUrlStrategy ? '' : '/#';

String? getFullHref(String? href) {
  if (href == null) return null;
  if (DartUtil.isHttp(href)) return href;
  return window.location.origin + hash + href;
}

void toHref(String href, ElLinkTarget target) {
  if (target == ElLinkTarget.blank) {
    window.open(href, '_blank');
  } else if (target == ElLinkTarget.self) {
    window.location.href = href;
  } else if (target == ElLinkTarget.parent) {
    window.open(href, '_parent');
  } else if (target == ElLinkTarget.top) {
    window.open(href, '_top');
  }
}
