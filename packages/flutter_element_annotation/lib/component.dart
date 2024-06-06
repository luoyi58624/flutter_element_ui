import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElComponent {
  /// 为 Element UI 组件生成一些通用代码
  const ElComponent({
    this.theme = false,
    this.importantTheme = false,
  });

  const ElComponent.all({
    this.theme = true,
    this.importantTheme = true,
  });

  /// 生成组件局部主题样式代码
  final bool theme;

  /// 生成覆盖后代组件主题样式代码
  final bool importantTheme;
}
