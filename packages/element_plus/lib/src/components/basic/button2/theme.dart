import 'package:element_plus/src/global.dart';

part '../../../generates/components/basic/button2/theme.g.dart';

@ElModel.copy()
class ElButton2ThemeData {
  ElButton2ThemeData({this.type, this.bgColor});

  /// 主题类型，默认 primary
  final String? type;

  /// 自定义颜色按钮，它会覆盖 [type] 属性
  final Color? bgColor;
}

@ElModel.copy()
class ElTextButtonThemeData extends ElButton2ThemeData {
  ElTextButtonThemeData({
    super.type,
    this.bg,
  });

  final bool? bg;
}
