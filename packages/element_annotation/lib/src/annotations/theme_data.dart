import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class $ElThemeModel {
  const $ElThemeModel({
    this.generateInheritedWidget = true,
    this.desc = '',
  });

  /// 生成主题注入小部件
  final bool generateInheritedWidget;

  /// 生成代码注释
  final String desc;
}

@Target({TargetKind.classType})
class $ElGlobalThemeModel {
  /// 全局主题数据代码生成器，实现的效果请查看 element_plus/themes/theme.dart
  const $ElGlobalThemeModel();
}
