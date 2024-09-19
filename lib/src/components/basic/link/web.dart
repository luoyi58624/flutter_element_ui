import 'package:flutter_element_ui/src/global.dart';
import 'package:url_launcher/link.dart';
import 'package:web/web.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'common.dart';

final _hash = urlStrategy is PathUrlStrategy ? '' : '#';
String? _baseHref;

void initBaseHref() {
  final target = document.getElementsByTagName('base').item(0);
  if (target != null) {
    _baseHref = target.getAttribute('href');
    if (_baseHref != null && _baseHref!.endsWith('/')) {
      _baseHref = _baseHref!.substring(0, _baseHref!.length - 1);
    }
  }
}

String? getPreviewLink(String href) {
  if (_baseHref == null) initBaseHref();
  if (DartUtil.isHttp(href)) return href;
  if (_baseHref == null) return null;
  if (_hash != '') {
    return '${window.location.origin}${_baseHref!}/$_hash$href';
  } else {
    return '${window.location.origin}$_baseHref$href';
  }
}

void toLink(String href, LinkTarget target) {
  if (DartUtil.isHttp(href)) {
    if (target == LinkTarget.blank) {
      window.open(href, '_blank');
    } else {
      window.location.href = href;
    }
  } else {
    pushRouteNameToFramework(null, href);
  }
}
