part of flutter_element_ui;

class _ElPlatformUtil {
  _ElPlatformUtil._();

  static bool get isWeb => GeneralPlatform.isWeb;

  static bool get isMacOS => GeneralPlatform.isMacOS;

  static bool get isWindows => GeneralPlatform.isWindows;

  static bool get isLinux => GeneralPlatform.isLinux;

  static bool get isAndroid => GeneralPlatform.isAndroid;

  static bool get isIOS => GeneralPlatform.isIOS;

  static bool get isFuchsia => GeneralPlatform.isFuchsia;

  static bool get isMobile => _ElPlatformUtil.isIOS || _ElPlatformUtil.isAndroid;

  static bool get isDesktop => _ElPlatformUtil.isMacOS || _ElPlatformUtil.isWindows || _ElPlatformUtil.isLinux;
}
