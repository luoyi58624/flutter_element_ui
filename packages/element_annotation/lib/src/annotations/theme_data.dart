import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElThemeModel {
  /// 将此类变为 Element UI 主题配置类，当运行代码生成器时，它会生成局部主题注入小部件
  const ElThemeModel({
    this.generateThemeWidget = true,
    this.generateAnimatedThemeWidget = false,
    this.desc = '',
    this.ignoreGlobalTheme = false,
  });

  /// 生成主题小部件，默认 true
  final bool generateThemeWidget;

  /// 生成动画主题小部件，因为大部分组件不需要提供动画，所以默认 false，
  /// 如果 [generateThemeWidget] 为 false，那么此选项会失效
  final bool generateAnimatedThemeWidget;

  /// 生成代码注释
  final String desc;

  /// 是否忽略全局主题配置，若为 true，[ElGlobalThemeModel] 会忽略此类
  final bool ignoreGlobalTheme;
}

@Target({TargetKind.classType})
class ElGlobalThemeModel {
  /// 全局主题数据代码生成器，它会收集所有添加了 [ElThemeModel] 注解的主题配置类，
  /// 生成一个管理所有主题的全局配置类。
  ///
  /// 注意：使用该注解的 class 必须是私有的
  const ElGlobalThemeModel();
}
