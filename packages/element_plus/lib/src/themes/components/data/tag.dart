import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/data/tag.g.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '标签默认样式')
class ElTagThemeData {
  static const theme = ElTagThemeData();
  static const darkTheme = ElTagThemeData();

  const ElTagThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸
  final double size;
}
