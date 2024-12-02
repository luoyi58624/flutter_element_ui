part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '导航菜单默认样式')
class ElNavMenuThemeData {
  static const theme = ElNavMenuThemeData(activeTextColor: Color(0xff409eff));
  static const darkTheme =
      ElNavMenuThemeData(activeTextColor: Color(0xff6ee7b7));

  const ElNavMenuThemeData({
    required this.activeTextColor,
  });

  /// 菜单激活文字颜色
  final Color activeTextColor;
}
