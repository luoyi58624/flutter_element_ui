import 'package:element_plus/element_plus.dart';
import 'package:flutter/services.dart';

class LinkWidgets {
  LinkWidgets._();

  static const flutterHook = ElLink(
    href: 'https://pub.dev/packages/flutter_hooks',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'flutter_hooks',
  );

  static const listener = ElLink(
    href: 'https://api.flutter.dev/flutter/widgets/Listener-class.html',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'Listener',
  );

  static const gestureDetector = ElLink(
    href: 'https://api.flutter.dev/flutter/widgets/GestureDetector-class.html',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'GestureDetector',
  );

  static const themeData = ElLink(
    href: 'https://api.flutter.dev/flutter/material/ThemeData-class.html',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'ThemeData',
  );

  static const cupertinoThemeData = ElLink(
    href:
        'https://api.flutter.dev/flutter/cupertino/CupertinoThemeData-class.html',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'CupertinoThemeData',
  );

  static const buttonTheme = ElLink(
    href: 'https://api.flutter.dev/flutter/material/ButtonTheme-class.html',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'ButtonTheme',
  );

  static const sliderTheme = ElLink(
    href: 'https://api.flutter.dev/flutter/material/SliderTheme-class.html',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'SliderTheme',
  );
}
