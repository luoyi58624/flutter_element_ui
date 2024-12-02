import 'package:web/web.dart' as web;

String _userAgent = web.window.navigator.userAgent;

class GeneralPlatform {
  static final bool isMacOS = _userAgent.contains('Mac OS') && !isIOS;

  static final bool isWindows = _userAgent.contains('Win');

  static final bool isLinux =
      (_userAgent.contains('Linux') || _userAgent.contains('x11')) &&
          !isAndroid;

  static final bool isAndroid = _userAgent.contains('Android');

  static final bool isIOS =
      RegExp(r'(iPad|iPhone|iPod)').hasMatch(_userAgent);

  static const bool isFuchsia = false;

  static final bool isDesktop = isMacOS || isWindows || isLinux;

  static final bool isApple = isMacOS || isIOS;

  static final bool isMobileWeb = isIOS || isAndroid || isFuchsia;

  static final bool isDesktopWeb = isMacOS || isWindows || isLinux;

  static const bool isMobileClient = false;

  static const bool isDesktopClient = false;
}
