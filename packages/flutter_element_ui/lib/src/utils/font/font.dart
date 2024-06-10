import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../device.dart';
import '../platform/platform.dart';
import 'font_web.dart' if (dart.library.io) 'font_io.dart';
import 'model.dart';

/// 字体工具类
class ElFont {
  ElFont._();

  /// 系统字体
  static const ElFontModel systemFont = ElFontModel(fontFamily: '');

  /// 初始化的字体
  static ElFontModel get initialFont => ElFont._initialElFontModel;

  /// 加载谷歌中文字体，包含100-900字重
  static ElFontModel notoSansSc([List<FontWeight>? fontWeights]) {
    return ElFontModel(
      fontFamily: 'NotoSansSC',
      fontWeights: _GoogleFonts.notoSansSc.filterFromKeys((fontWeights ?? []).map((e) => e.value).toList()),
    );
  }

  /// 谷歌斜体中文字体
  static ElFontModel longCang() => ElFontModel(
        fontFamily: 'LongCang',
        fontUrl: _GoogleFonts.baseUrl('f626a05f45d156332017025fc68902a92f57f51ac57bb4a79097ee7bb1a97352'),
      );

  static late ElFontModel _initialElFontModel;

  /// [_initialElFontModel]本地存储键，如果用户在[init]中更改了[ElFontModel]，则重新加载新的字体
  static const String _initialLocalKey = 'initial_font_family';

  /// [fontFamily]本地存储键
  static const String localKey = 'font_family';

  /// 当前加载的全局字体模型
  static ElFontModel _currentElFontModel = systemFont;

  static final HashSet<String> _loadFonts = HashSet();

  /// 已加载的字体
  static HashSet<String> get loadFonts => _loadFonts;

  /// 当前选择的全局字体，null 表示系统字体，当调用[loadFont]函数加载新字体成功时，此变量将会指向新字体的fontFamily
  static String? get fontFamily => _currentElFontModel.fontFamily == '' ? null : _currentElFontModel.fontFamily;

  /// 基础字重字体
  static FontWeight get normal => fontFamily == null ? (_normal ?? FontWeight.normal) : FontWeight.normal;

  /// 中等字重字体
  static FontWeight get medium => fontFamily == null ? (_medium ?? FontWeight.w500) : FontWeight.w500;

  /// 粗体字重字体
  static FontWeight get bold => fontFamily == null ? (_bold ?? FontWeight.bold) : FontWeight.bold;

  /// 初始化字体，但会根据不同平台加载字体，如果你需要将某个字体直接应用所有平台，请使用[initFont]
  /// * web canvaskit - fontModel
  ///
  /// * android - 系统字体
  /// * android web html - 系统字体
  ///
  /// * ios - 系统字体
  /// * ios web html - 系统字体
  ///
  /// * windows - fontModel
  /// * windows web html - fontModel
  ///
  /// * macos - 系统字体
  /// * macos web html - 系统字体
  ///
  /// * linux - fontModel
  /// * linux web html - fontModel
  static Future<void> init({
    ElFontModel? fontModel,
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
  }) async {
    bool allowLoadCustomFont = getAllowLoadCustomFont(
      canvaskit: canvaskit,
      android: android,
      androidWeb: androidWeb,
      ios: ios,
      iosWeb: iosWeb,
      macos: macos,
      macosWeb: macosWeb,
      windows: windows,
      windowsWeb: windowsWeb,
      linux: linux,
      linuxWeb: linuxWeb,
    );
    if (allowLoadCustomFont) {
      fontModel != null && fontModel.fontFamily != '' ? await initFont(fontModel) : await initFont(notoSansSc([FontWeight.w500]));
    } else {
      await initFont(systemFont);
    }
  }

  /// 初始化全局默认字体
  static Future<void> initFont(ElFontModel fontModel) async {
    await initStorage();
    var localStr = localStorage.getItem(localKey);

    // 第一次加载
    if (localStr == null) return await _initFont(fontModel);

    // 获取本地初始化的字体，如果本地初始化的字体和传递的fontModel不一致，说明用户更改了fontModel，
    // 那么我们需要重新加载用户传递的fontModel
    var initialLocalStr = localStorage.getItem(_initialLocalKey);

    if (initialLocalStr == null) {
      _initialElFontModel = fontModel;
      localStorage.setItem(_initialLocalKey, jsonEncode(_initialElFontModel.toJson()));
    } else {
      _initialElFontModel = ElFontModel.fromJson((jsonDecode(initialLocalStr) as Map).cast<String, dynamic>());
      if (_initialElFontModel.fontFamily != fontModel.fontFamily) {
        _initialElFontModel = fontModel;
        localStorage.setItem(_initialLocalKey, jsonEncode(_initialElFontModel.toJson()));
        return await _initFont(fontModel);
      }
    }

    try {
      ElFontModel localElFontModel = ElFontModel.fromJson((jsonDecode(localStr) as Map).cast<String, dynamic>());
      await loadFont(localElFontModel);
    } catch (error) {
      e(error, '本地缓存字体加载异常');
      await _initFont(fontModel);
    }
  }

  static Future<void> _initFont(ElFontModel fontModel) async {
    bool success = await loadFont(fontModel);
    if (success) localStorage.setItem(_initialLocalKey, jsonEncode(fontModel.toJson()));
  }

  /// 字体族列表，当我们的[fontFamily]为空时，flutter会根据此列表依次匹配字体
  static List<String>? get fontFamilyFallback {
    // 在 mac 上若不指定苹方字体，那么中文字重将失效
    if (ElPlatform.isMacOS || ElPlatform.isIOS) {
      return ['.AppleSystemUIFont', 'PingFang SC'];
    } else if (ElPlatform.isWindows) {
      return ['Microsoft YaHei', '微软雅黑'];
    } else {
      return null;
    }
  }

  /// 动态加载全局字体，如果加载成功则返回true
  ///
  /// 注意：此函数不会更新你的页面，你应当使用状态管理保存当前选中的字体，
  /// 每次加载完字体后通过[ElFont.fontFamily]变量更新你的状态
  static Future<bool> loadFont([ElFontModel? fontModel]) async {
    fontModel ??= systemFont;
    // 如果加载的fontUrl、fontWeights都为空，则那么跳过网络解析
    if (fontModel.fontUrl == null && (fontModel.fontWeights == null || fontModel.fontWeights!.isEmpty)) {
      _currentElFontModel = fontModel;
      localStorage.setItem(localKey, jsonEncode(fontModel.toJson()));
      _loadFonts.add(fontModel.fontFamily);
      return true;
    } else {
      List<String> fontFamilyList = [];
      List<ByteData> fontByteDataList = [];
      if (fontModel.fontUrl != null) {
        // 如果当前字体已加载，那么跳过网络解析
        if (!loadFonts.contains(fontModel.fontFamily)) {
          var result = await generalLoadNetworkFont(fontModel.fontUrl!);
          // 加载网络字体失败，返回false结束运行
          if (result == null) return false;
          fontFamilyList.add(fontModel.fontFamily);
          fontByteDataList.add(result);
        }
      } else {
        List<int> needLoadFonts = [];
        for (int key in fontModel.fontWeights!.keys) {
          if (!loadFonts.contains('${fontModel.fontFamily}_$key')) needLoadFonts.add(key);
        }
        var result = await Future.wait(needLoadFonts.map((key) => generalLoadNetworkFont(
              fontModel!.fontWeights![key]!,
              fontModel: fontModel,
              localKey: '${fontModel.fontFamily}_$key',
            )));
        if (result.contains(null)) return false;
        fontFamilyList.addAll(needLoadFonts.map((key) => '${fontModel!.fontFamily}_$key'));
        fontByteDataList.addAll(result.cast<ByteData>());
      }
      // 注入字体失败，返回false结束运行
      if (!(await _loadFont(fontModel.fontFamily, fontByteDataList))) return false;
      _currentElFontModel = fontModel;
      localStorage.setItem(localKey, jsonEncode(fontModel.toJson()));
      _loadFonts.addAll(fontFamilyList);
      return true;
    }
  }

  /// 当使用系统字体时，优化某些设备的[FontWeight]，例如：
  /// * 小米 - normal: w500
  /// * 华为 - bold: w600
  ///
  /// 此函数是可选的，它只作用于[ElFont.normal]、[ElFont.medium]、[ElFont.bold]等变量
  static Future<void> initSystemFontWeight({
    FontWeight? normal,
    FontWeight? medium,
    FontWeight? bold,
  }) async {
    if (kIsWeb) return;
    await ElDevice.init();
    __normal = normal;
    __medium = medium;
    __bold = bold;
    if (ElPlatform.isAndroid) {
      // 小米手机400字重太细了，将normal设置为500
      if (ElDevice.isXiaomi) {
        _setFontWeight(FontWeight.w500, FontWeight.w500, FontWeight.bold);
      }
      // 华为手机700字重太重了，将bold设置为600
      else if (ElDevice.isHUAWEI) {
        _setFontWeight(FontWeight.w400, FontWeight.w500, FontWeight.w600);
      }
    }
    // Windows平台不包含w500字重，中等字重调整为400
    else if (ElPlatform.isWindows) {
      _setFontWeight(FontWeight.normal, FontWeight.normal, FontWeight.bold);
    }
  }

  /// 如果是系统字体，使用的 normal 字重，如果执行了[initSystemFontWeight]，该值会在部分设备上使用[FontWeight.w500]字重
  static FontWeight? _normal;

  /// 如果是系统字体，使用的 w500 字重，如果执行了[initSystemFontWeight]，该值会在部分设备上使用[FontWeight.w400]字重
  static FontWeight? _medium;

  /// 如果是系统字体，使用的 bold 字重，如果执行了[initSystemFontWeight]，会在部分设备上使用[FontWeight.w600]字重
  static FontWeight? _bold;

  static FontWeight? __normal;
  static FontWeight? __medium;
  static FontWeight? __bold;

  static void _setFontWeight(FontWeight normalFont, FontWeight mediumFont, FontWeight boldFont) {
    _normal = __normal ?? normalFont;
    _medium = __medium ?? mediumFont;
    _bold = __bold ?? boldFont;
  }
}

/// 加载字体
Future<bool> _loadFont(String fontFamily, List<ByteData> byteDataList) async {
  if (byteDataList.isEmpty) return true;
  try {
    final fontLoader = FontLoader(fontFamily);
    for (var byteData in byteDataList) {
      fontLoader.addFont(Future.value(byteData));
    }
    await fontLoader.load();
    return true;
  } catch (error) {
    e(error, 'FontLoader加载字体失败');
    return false;
  }
}

class _GoogleFonts {
  _GoogleFonts._();

  static String baseUrl(String fileHash) => 'https://fonts.gstatic.com/s/a/$fileHash.ttf';

  static final Map<int, String> notoSansSc = {
    FontWeight.w100.value: baseUrl('f1b8c2a287d23095abd470376c60519c9ff650ae8744b82bf76434ac5438982a'),
    FontWeight.w200.value: baseUrl('cba9bb657b61103aeb3cd0f360e8d3958c66febf59fbf58a4762f61e52015d36'),
    FontWeight.w300.value: baseUrl('4cdbb86a1d6eca92c7bcaa0c759593bc2600a153600532584a8016c24eaca56c'),
    FontWeight.w400.value: baseUrl('eacedb2999b6cd30457f3820f277842f0dfbb28152a246fca8161779a8945425'),
    FontWeight.w500.value: baseUrl('5383032c8e54fc5fa09773ce16483f64d9cdb7d1f8e87073a556051eb60f8529'),
    FontWeight.w600.value: baseUrl('85c00dac0627c2c0184c24669735fad5adbb4f150bcb320c05620d46ed086381'),
    FontWeight.w700.value: baseUrl('a7a29b6d611205bb39b9a1a5c2be5a48416fbcbcfd7e6de98976e73ecb48720b'),
    FontWeight.w800.value: baseUrl('038de57b1dc5f6428317a8b0fc11984789c25f49a9c24d47d33d2c03e3491d28'),
    FontWeight.w900.value: baseUrl('501582a5e956ab1f4d9f9b2d683cf1646463eea291b21f928419da5e0c5a26eb'),
  };
}
