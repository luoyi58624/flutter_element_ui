part of 'index.dart';

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
    this.borderColor = const Color(0xffDCDFE6),
  });

  const _ElThemeData.dark({
    this.primary = Colors.white,
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xff2b2b2b),
    this.borderColor = const Color(0xffa3a3a3),
  });
}
