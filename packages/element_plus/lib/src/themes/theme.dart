import 'package:element_plus/element_plus.dart';

import '../global.dart';

part '../generates/themes/theme.g.dart';

@ElGlobalThemeModel()
class _ElThemeData {
  /// 主要颜色
  final Color primary;

  /// 成功颜色
  final Color success;

  /// 普通颜色
  final Color info;

  /// 警告颜色
  final Color warning;

  /// 错误颜色
  final Color error;

  /// 全局背景色
  final Color bgColor;

  /// 常规文本颜色
  final Color regularTextColor;

  /// 次要文本颜色
  final Color secondaryTextColor;

  /// 占位文本颜色
  final Color placeholderTextColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框颜色与背景色进行混合形成的颜色
  Color get borderLightColor => borderColor.mix(bgColor, 50);

  const _ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xfffafafa),
    this.regularTextColor = const Color(0xff606266),
    this.secondaryTextColor = const Color(0xff909399),
    this.placeholderTextColor = const Color(0xffA8ABB2),
    this.borderColor = const Color(0xffDCDFE6),
  });

  const _ElThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xff2b2b2b),
    this.regularTextColor = const Color(0xffCFD3DC),
    this.secondaryTextColor = const Color(0xffA3A6AD),
    this.placeholderTextColor = const Color(0xff8D9095),
    this.borderColor = const Color(0xffa3a3a3),
  });
}
