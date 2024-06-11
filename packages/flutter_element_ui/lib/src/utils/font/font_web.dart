import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'model.dart';

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

/// 加载字体 - web环境
Future<ByteData?> generalLoadNetworkFont(
  String fontUrl, {
  ElFontModel? fontModel,
  String? localKey,
}) async {
  assert(fontUrl.startsWith('http'), '字体文件地址必须是网络地址');
  try {
    var res = await http.get(Uri.parse(fontUrl));
    return ByteData.view(res.bodyBytes.buffer);
  } catch (error) {
    e(error, '请求字体失败');
    return null;
  }
}
