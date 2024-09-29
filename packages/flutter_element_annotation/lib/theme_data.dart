import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElThemeDataModel {
  const ElThemeDataModel({
    this.generateInheritedWidget = true,
  });

  /// 生成主题注入小部件
  final bool generateInheritedWidget;
}
