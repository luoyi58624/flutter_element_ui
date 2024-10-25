import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/navigation/tab.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '标签容器子标签默认样式')
class ElTabThemeData {
  static const theme = ElTabThemeData();
  static const darkTheme = ElTabThemeData();

  const ElTabThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸
  final double size;
}
