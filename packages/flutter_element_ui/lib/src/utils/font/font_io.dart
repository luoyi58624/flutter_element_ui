import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:path_provider/path_provider.dart';

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
  if (Platform.isAndroid && android) return true;
  if (Platform.isIOS && ios) return true;
  if (Platform.isMacOS && macos) return true;
  if (Platform.isWindows && windows) return true;
  if (Platform.isLinux && linux) return true;
  return false;
}

/// 加载字体 - 客户端环境
Future<ByteData?> generalLoadNetworkFont(
  String fontUrl, {
  ElFontModel? fontModel,
  String? localKey,
}) async {
  assert(fontUrl.startsWith('http'), '字体文件地址必须是网络地址');

  // 本地缓存的字体路径，以字族名为文件夹
  late final String localPath;
  try {
    localPath = '${(await getApplicationSupportDirectory()).path}/$localKey.ttf';
  } catch (error) {
    e(error, '获取字体缓存路径错误');
    return null;
  }

  ByteData? byteData = await _loadLocalFont(localPath);
  if (byteData != null) return byteData;

  http.Response? res;
  try {
    res = await http.get(Uri.parse(fontUrl));
  } catch (error) {
    e(error, '请求字体失败，请检查网络连接或检查是否添加网络权限');
    return null;
  }

  bool result = await _saveLocalFont(localPath, res.bodyBytes);
  if (!result) return null;

  return ByteData.view(res.bodyBytes.buffer);
}

/// 加载本地字体
Future<ByteData?> _loadLocalFont(String localPath) async {
  try {
    final file = File(localPath);
    if (file.existsSync()) {
      List<int> contents = await file.readAsBytes();
      if (contents.isNotEmpty) {
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (error) {
    e(error, '加载本地缓存字体错误');
    return null;
  }
  return null;
}

/// 保存字体到本地
Future<bool> _saveLocalFont(String localPath, List<int> byteData) async {
  try {
    File file = File(localPath);
    if (!file.existsSync()) file.createSync(recursive: true);
    await file.writeAsBytes(byteData);
    return true;
  } catch (error) {
    e(error, '保存本地缓存字体错误');
    return false;
  }
}
