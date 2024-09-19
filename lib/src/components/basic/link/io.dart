import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:url_launcher/link.dart';

import 'common.dart';

String? getPreviewLink(String href) {
  if (DartUtil.isHttp(href)) return href;
  return null;
}

void toLink(String href, LinkTarget target) {
  if (DartUtil.isHttp(href)) {
    launchUrl(Uri.parse(href));
  } else {
    pushRouteNameToFramework(null, href);
  }
}
