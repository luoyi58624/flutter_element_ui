import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/others/code_preview.g.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '代码预览默认样式')
class ElCodePreviewThemeData {
  static const theme = ElCodePreviewThemeData();
  static const darkTheme = ElCodePreviewThemeData();

  const ElCodePreviewThemeData({
    this.fontFamily,
    this.color = const Color(0xFFD19A66),
    this.bgColor = const Color.fromRGBO(49, 49, 49, 1.0),
    this.enableSection = true,
  });

  /// 字体名称
  final String? fontFamily;

  /// 默认文本颜色
  final Color color;

  /// 默认背景颜色
  final Color bgColor;

  /// 是否开启文本选择
  final bool enableSection;
}
