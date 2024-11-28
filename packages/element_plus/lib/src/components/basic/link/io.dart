import 'package:element_extension/element_extension.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common.dart';

String? getPreviewLink(String href) {
  if (FlutterUtil.isHttp(href)) return href;
  return null;
}

void toLink(String href, LinkTarget target) {
  if (FlutterUtil.isHttp(href)) {
    launchUrl(Uri.parse(href));
  } else {
    pushRouteNameToFramework(null, href);
  }
}
