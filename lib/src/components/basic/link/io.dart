import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:url_launcher/link.dart';

String getFullHref(String href) {
  return href;
}

void toLink(String href, LinkTarget target) {
  if (DartUtil.isHttp(href)) {
    launchUrl(Uri.parse(href));
  } else {
    _pushRouteNameToFramework(null, href);
  }
}

const MethodCodec _codec = JSONMethodCodec();

Future<ByteData> _pushRouteNameToFramework(Object? _, String routeName) {
  final Completer<ByteData> completer = Completer<ByteData>();
  SystemNavigator.routeInformationUpdated(uri: Uri.parse(routeName));
  ui.channelBuffers.push(
    'flutter/navigation',
    _codec.encodeMethodCall(
      MethodCall('pushRouteInformation', <dynamic, dynamic>{
        'location': routeName,
        'state': null,
      }),
    ),
    completer.complete,
  );
  return completer.future;
}
