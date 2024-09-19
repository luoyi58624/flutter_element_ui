import 'package:flutter_element_ui/src/global.dart';
import 'package:url_launcher/link.dart';
import 'package:web/web.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

final hash = urlStrategy is PathUrlStrategy ? '' : '/#';

String getFullHref(String href) {
  if (DartUtil.isHttp(href)) return href;
  return window.location.origin + hash + href;
}

void toLink(String href, LinkTarget target) {
  if (target == LinkTarget.blank) {
    window.open(href, '_blank');
  } else {
    window.location.href = href;
  }
}
