import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part '../../generates/themes/services/modal.g.dart';

@ElModel.copy()
@ElThemeModel(generateThemeWidget: false, desc: '模态框默认样式')
class ElModalThemeData {
  static const theme = ElModalThemeData(
    color: Color(0xffffffff),
    elevation: 2,
  );
  static const darkTheme = ElModalThemeData(
    color: Color(0xff3f3f46),
    elevation: 4,
  );

  const ElModalThemeData({
    required this.color,
    required this.elevation,
  });

  /// 模态框背景颜色
  final Color color;

  /// 模态框海拔层级
  final double elevation;
}
