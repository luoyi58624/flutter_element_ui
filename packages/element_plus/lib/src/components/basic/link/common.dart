import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

const MethodCodec _codec = JSONMethodCodec();

Future<ByteData> pushRouteNameToFramework(Object? _, String routeName) {
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
