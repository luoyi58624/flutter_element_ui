import 'package:flutter/material.dart';

import '../../global.dart';

part '../../generates/themes/layout/aside.g.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '侧边栏默认样式')
class ElAsideThemeData {
  static const theme = ElAsideThemeData(color: Color(0xffffffff));
  static const darkTheme = ElAsideThemeData(color: Color(0xff374151));
  const ElAsideThemeData({
    required this.color,
    this.width = 240,
  });

  /// 侧边栏背景颜色
  final Color color;

  /// 侧边栏宽度
  final double width;
}
