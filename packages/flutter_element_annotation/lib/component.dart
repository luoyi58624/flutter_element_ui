import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElComponent {
  /// 为 Element UI 组件生成一些通用代码
  const ElComponent({
    this.generateMergeStyleFun = false,
    this.generateLocalThemeWidget = false,
    this.generateImportantThemeWidget = false,
  });

  const ElComponent.all({
    this.generateMergeStyleFun = true,
    this.generateLocalThemeWidget = true,
    this.generateImportantThemeWidget = true,
  });

  /// 生成合并最终主题样式函数
  final bool generateMergeStyleFun;

  /// 生成组件局部主题样式代码
  final bool generateLocalThemeWidget;

  /// 生成覆盖后代组件主题样式代码
  final bool generateImportantThemeWidget;
}
