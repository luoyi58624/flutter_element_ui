import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElModel {
  /// 生成通用的操作数据模型方法：json序列化、copyWith对象克隆等...
  const ElModel({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = false,
    this.merge = false,
    this.generateToString = false,
  });

  /// 默认开启所有功能
  const ElModel.all({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = true,
    this.merge = true,
    this.generateToString = true,
  });

  /// 默认生成 json 序列化方法
  const ElModel.json({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = false,
    this.merge = false,
    this.generateToString = false,
  });

  /// 默认生成 copyWith、merge 方法
  const ElModel.copy({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = true,
    this.merge = true,
    this.generateToString = false,
  });

  /// 生成 formJson 方法（暂未实现）
  final bool formJson;

  /// 生成 toJson 方法（暂未实现）
  final bool toJson;

  /// 生成 copyWith 方法
  final bool copyWith;

  /// 生成 merge 方法，此方法的作用是接收一个对象，与当前对象的属性进行合并，
  /// 该属性依赖于[copyWith]，如果该属性为true，则[copyWith]强制为true
  final bool merge;

  /// 生成 toString 方法
  final bool generateToString;
}

/// 模型字段元数据，控制每个字段的生成逻辑
@Target({TargetKind.field})
class ElModelField {
  const ElModelField({
    this.ignore = const ElModel(),
  });

  /// 生成的代码是否忽略此字段，接收[ElModel]作为对象，你可以精细控制每个生成函数是否要忽略此字段。
  /// 例如：如果你需要在所有生成的函数中都忽略此字段，请传递[ElModel.all]
  final ElModel ignore;
}
