import 'package:flutter_element_ui/src/global.dart';

import 'link.dart';

String? getFullHref(String? href) {
  return href;
}

void toHref(String href, ElLinkTarget target) {
  launchUrl(Uri.parse(href));
}
