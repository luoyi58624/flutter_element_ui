import 'dart:io';
import 'dart:typed_data';

import 'package:element_dart/element_dart.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'global_font.dart';

/// 加载字体 - 客户端环境
Future<ByteData?> generalLoadNetworkFont(
  String fontUrl, {
  FontModel? fontModel,
  String? localKey,
}) async {
  assert(fontUrl.startsWith('http'), '字体文件地址必须是网络地址');
  // 本地缓存的字体路径，以字族名为文件夹
  late final String localPath;
  try {
    localPath =
        '${(await getApplicationSupportDirectory()).path}/$localKey.ttf';
  } catch (error) {
    e(error, '获取字体缓存路径错误');
    return null;
  }

  ByteData? byteData = _loadLocalFont(localPath);
  if (byteData != null) return byteData;

  http.Response? res;
  try {
    res = await http.get(Uri.parse(fontUrl));
  } catch (error) {
    e(error, '请求字体失败，请检查网络连接或检查是否添加网络权限');
    return null;
  }

  bool result = _saveLocalFont(localPath, res.bodyBytes);
  if (!result) return null;

  return ByteData.view(res.bodyBytes.buffer);
}

/// 加载本地字体
ByteData? _loadLocalFont(String localPath) {
  try {
    final file = File(localPath);
    if (file.existsSync()) {
      List<int> contents = file.readAsBytesSync();
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
bool _saveLocalFont(String localPath, List<int> byteData) {
  try {
    File file = File(localPath);
    if (!file.existsSync()) file.createSync(recursive: true);
    file.writeAsBytesSync(byteData);
    return true;
  } catch (error) {
    e(error, '保存本地缓存字体错误');
    return false;
  }
}

// class _GoogleFonts {
//   _GoogleFonts._();
//
//   static String baseUrl(String fileHash) =>
//       'https://fonts.gstatic.com/s/a/$fileHash.ttf';
//
//   static final Map<int, String> notoSansSc = {
//     FontWeight.w100.value: baseUrl(
//         'f1b8c2a287d23095abd470376c60519c9ff650ae8744b82bf76434ac5438982a'),
//     FontWeight.w200.value: baseUrl(
//         'cba9bb657b61103aeb3cd0f360e8d3958c66febf59fbf58a4762f61e52015d36'),
//     FontWeight.w300.value: baseUrl(
//         '4cdbb86a1d6eca92c7bcaa0c759593bc2600a153600532584a8016c24eaca56c'),
//     FontWeight.w400.value: baseUrl(
//         'eacedb2999b6cd30457f3820f277842f0dfbb28152a246fca8161779a8945425'),
//     FontWeight.w500.value: baseUrl(
//         '5383032c8e54fc5fa09773ce16483f64d9cdb7d1f8e87073a556051eb60f8529'),
//     FontWeight.w600.value: baseUrl(
//         '85c00dac0627c2c0184c24669735fad5adbb4f150bcb320c05620d46ed086381'),
//     FontWeight.w700.value: baseUrl(
//         'a7a29b6d611205bb39b9a1a5c2be5a48416fbcbcfd7e6de98976e73ecb48720b'),
//     FontWeight.w800.value: baseUrl(
//         '038de57b1dc5f6428317a8b0fc11984789c25f49a9c24d47d33d2c03e3491d28'),
//     FontWeight.w900.value: baseUrl(
//         '501582a5e956ab1f4d9f9b2d683cf1646463eea291b21f928419da5e0c5a26eb'),
//   };
// }
