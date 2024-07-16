import 'package:flutter/foundation.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

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
  if (isCanvasKit && canvaskit) return true;
  if (PlatformUtil.isAndroid && androidWeb) return true;
  if (PlatformUtil.isIOS && iosWeb) return true;
  if (PlatformUtil.isMacOS && macosWeb) return true;
  if (PlatformUtil.isWindows && windowsWeb) return true;
  if (PlatformUtil.isLinux && linuxWeb) return true;
  return false;
}
