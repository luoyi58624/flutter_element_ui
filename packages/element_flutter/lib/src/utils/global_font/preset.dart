part of 'global_font.dart';

/// assets资产包提供的预设字体
class GlobalFontPreset {
  GlobalFontPreset._();

  /// 系统字体
  static const systemFont = FontModel(fontFamily: '');

  /// 项目初始化的字体
  static get initialFont => GlobalFontUtil._initialFont;

  /// 谷歌中文字体
  static const notoSansSC = FontModel(fontFamily: 'NotoSansSC');
}
