import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'link.dart';

String? getFullHref(String? href) {
  return href;
}

void toHref(String href, ElLinkTarget target) {
  launchUrl(Uri.parse(href));
}
