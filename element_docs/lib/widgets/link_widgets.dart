import 'package:element_plus/element_plus.dart';
import 'package:flutter/services.dart';

class LinkWidgets {
  LinkWidgets._();

  static const flutterHook = ElLink(
    href: 'https://pub.dev/packages/flutter_hooks',
    cursor: SystemMouseCursors.click,
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'flutter_hooks',
  );

  static const listener = ElLink(
    href: 'https://api.flutter.dev/flutter/widgets/Listener-class.html',
    cursor: SystemMouseCursors.click,
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'Listener',
  );

  static const gestureDetector = ElLink(
    href: 'https://api.flutter.dev/flutter/widgets/GestureDetector-class.html',
    cursor: SystemMouseCursors.click,
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'GestureDetector',
  );
}
