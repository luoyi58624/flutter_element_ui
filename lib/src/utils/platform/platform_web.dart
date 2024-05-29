// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as html;

html.Navigator _navigator = html.window.navigator;

// ignore: avoid_classes_with_only_static_members
class GeneralPlatform {
  static final bool isMacOS = _navigator.appVersion.contains('Mac OS') && !isIOS;

  static final bool isWindows = _navigator.appVersion.contains('Win');

  static final bool isLinux =
      (_navigator.appVersion.contains('Linux') || _navigator.appVersion.contains('x11')) && !isAndroid;

  // @check https://developer.chrome.com/multidevice/user-agent
  static final bool isAndroid = _navigator.appVersion.contains('Android ');

  // maxTouchPoints is needed to separate iPad iOS13 vs new MacOS
  static final bool isIOS = RegExp(r'/iPad|iPhone|iPod/').hasMatch(_navigator.platform) ||
      (_navigator.platform == 'MacIntel' && _navigator.maxTouchPoints > 1);

  static const bool isFuchsia = false;

  static final bool isDesktop = isMacOS || isWindows || isLinux;

  static final bool isApple = isMacOS || isIOS;

  static final bool isMobileWeb = isIOS || isAndroid || isFuchsia;

  static final bool isDesktopWeb = isMacOS || isWindows || isLinux;

  static const bool isMobileClient = false;

  static const bool isDesktopClient = false;
}
