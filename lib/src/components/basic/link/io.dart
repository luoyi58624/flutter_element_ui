import 'package:flutter_element_extension/flutter_element_extension.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common.dart';

String? getPreviewLink(String href) {
  if (ElUtil.isHttp(href)) return href;
  return null;
}

void toLink(String href, LinkTarget target) {
  if (ElUtil.isHttp(href)) {
    launchUrl(Uri.parse(href));
  } else {
    pushRouteNameToFramework(null, href);
  }
}
