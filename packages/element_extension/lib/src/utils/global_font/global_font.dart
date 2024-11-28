import 'package:element_dart/element_dart.dart';
import 'package:element_extension/element_extension.dart';
import 'package:flutter/cupertino.dart';

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_obs/flutter_obs.dart';

import 'font_web.dart' if (dart.library.io) 'font_io.dart';

part 'model.dart';

part 'preset.dart';

/// [fontFamily]本地存储键
const String _localKey = 'font_family';

/// [_initialElFontModel]本地存储键，如果用户在[init]中更改了[ElFontModel]，则重新加载新的字体
const String _initialLocalKey = 'initial_font_family';

final HashSet<String> _loadFonts = HashSet();

/// Flutter字体工具类
class GlobalFontUtil {
  GlobalFontUtil._();

  /// 初始化的字体
  static FontModel _initialFont = GlobalFontPreset.systemFont;

  /// 当前加载的全局字体模型，这是一个响应式变量，使用 [ObsBuilder]、[ValueListenableBuilder] 包裹会自动重建小部件
  static final Obs<FontModel> _currentFontModel =
      Obs(GlobalFontPreset.systemFont);

  /// 当前选择的全局字体，null 表示系统字体
  static String? get fontFamily => _currentFontModel.value.fontFamily == ''
      ? null
      : _currentFontModel.value.fontFamily;

  /// 初始化全局默认字体
  static Future<void> initFont(FontModel fontModel) async {
    var localStr = sp.getString(_localKey);

    // 第一次加载
    if (localStr == null) return await _initFont(fontModel);

    // 获取本地初始化的字体，如果本地初始化的字体和传递的fontModel不一致，说明用户更改了fontModel，
    // 那么我们需要重新加载用户传递的fontModel
    var initialLocalStr = sp.getString(_initialLocalKey);

    if (initialLocalStr == null) {
      _initialFont = fontModel;
      sp.setString(_initialLocalKey, jsonEncode(_initialFont.toJson()));
    } else {
      _initialFont = FontModel.fromJson(
          (jsonDecode(initialLocalStr) as Map).cast<String, dynamic>());
      if (_initialFont.fontFamily != fontModel.fontFamily) {
        _initialFont = fontModel;
        sp.setString(_initialLocalKey, jsonEncode(_initialFont.toJson()));
        return await _initFont(fontModel);
      }
    }

    try {
      FontModel localFontModel = FontModel.fromJson(
          (jsonDecode(localStr) as Map).cast<String, dynamic>());
      await loadFont(localFontModel);
    } catch (error) {
      e(error, '本地缓存字体加载异常');
      await _initFont(fontModel);
    }
  }

  static Future<void> _initFont(FontModel fontModel) async {
    bool success = await loadFont(fontModel);
    if (success) {
      sp.setString(_initialLocalKey, jsonEncode(fontModel.toJson()));
    }
  }

  /// 动态加载全局字体，如果加载成功则返回true
  ///
  /// 注意：此函数不会更新你的页面，你应当使用状态管理保存当前选中的字体，
  /// 每次加载完字体后通过[FontUtil.fontFamily]变量更新你的状态
  static Future<bool> loadFont([FontModel? fontModel]) async {
    fontModel ??= GlobalFontPreset.systemFont;
    // 如果加载的fontUrl、fontWeights都为空，则那么跳过网络解析
    if (fontModel.fontUrl == null &&
        (fontModel.fontWeights == null || fontModel.fontWeights!.isEmpty)) {
      _currentFontModel.value = fontModel;
      sp.setString(_localKey, jsonEncode(fontModel.toJson()));
      _loadFonts.add(fontModel.fontFamily);
      return true;
    } else {
      List<String> fontFamilyList = [];
      List<ByteData> fontByteDataList = [];
      if (fontModel.fontUrl != null) {
        // 如果当前字体已加载，那么跳过网络解析
        if (!_loadFonts.contains(fontModel.fontFamily)) {
          var result = await generalLoadNetworkFont(fontModel.fontUrl!);
          // 加载网络字体失败，返回false结束运行
          if (result == null) return false;
          fontFamilyList.add(fontModel.fontFamily);
          fontByteDataList.add(result);
        }
      } else {
        List<int> needLoadFonts = [];
        for (int key in fontModel.fontWeights!.keys) {
          if (!_loadFonts.contains('${fontModel.fontFamily}_$key')) {
            needLoadFonts.add(key);
          }
        }
        var result =
            await Future.wait(needLoadFonts.map((key) => generalLoadNetworkFont(
                  fontModel!.fontWeights![key]!,
                  fontModel: fontModel,
                  localKey: '${fontModel.fontFamily}_$key',
                )));
        if (result.contains(null)) return false;
        fontFamilyList.addAll(
            needLoadFonts.map((key) => '${fontModel!.fontFamily}_$key'));
        fontByteDataList.addAll(result.cast<ByteData>());
      }
      // 注入字体失败，返回false结束运行
      if (!(await _loadFont(fontModel.fontFamily, fontByteDataList))) {
        return false;
      }
      _currentFontModel.value = fontModel;
      sp.setString(_localKey, jsonEncode(fontModel.toJson()));
      _loadFonts.addAll(fontFamilyList);
      return true;
    }
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
