import 'dart:io';

/// 是否允许加载自定义字体，不允许的平台使用系统字体
bool getAllowLoadCustomFont({
  bool canvaskit = true,
  bool android = false,
  bool androidWeb = false,
  bool ios = false,
  bool iosWeb = false,
  bool macos = false,
  bool macosWeb = false,
  bool windows = true,
  bool windowsWeb = true,
  bool linux = true,
  bool linuxWeb = true,
}) {
  if (Platform.isAndroid && android) return true;
  if (Platform.isIOS && ios) return true;
  if (Platform.isMacOS && macos) return true;
  if (Platform.isWindows && windows) return true;
  if (Platform.isLinux && linux) return true;
  return false;
}
