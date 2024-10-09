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
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 默认开启所有功能
  const ElModel.all({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = true,
    this.merge = true,
    this.generateToString = true,
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 默认生成 json 序列化方法
  const ElModel.json({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = false,
    this.merge = false,
    this.generateToString = false,
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 默认生成 copyWith、merge 方法
  const ElModel.copy({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = true,
    this.merge = true,
    this.generateToString = false,
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 生成 formJson 方法
  final bool formJson;

  /// 生成 toJson 方法
  final bool toJson;

  /// 生成 copyWith 方法
  final bool copyWith;

  /// 生成 merge 方法，此方法的作用是接收一个对象，与当前对象的属性进行合并，
  /// 该属性依赖于[copyWith]，如果该属性为true，则[copyWith]强制为true
  final bool merge;

  /// 生成 toString 方法
  final bool generateToString;

  /// 是否对生成的 fromJson 进行命名区分，
  /// 如果为 false，则直接生成 _fromJson 函数，
  /// 如果为 true，则会在后尾添加类名做区分。
  ///
  /// 如果你的一个文件有多个模型对象，那么请将此属性设置为 true，防止命名冲突
  final bool fromJsonDiff;

  /// 将对象转成 json 时，是否将驼峰命名的字段转成下划线，此属性默认为 false
  final bool toJsonUnderline;
}

@Target({TargetKind.field})
class ElModelField {
  /// 模型字段元数据，控制每个字段的生成逻辑
  const ElModelField({
    this.ignore = const ElModel(),
    this.jsonKey,
    this.defaultValue,
  });

  /// 生成的代码是否忽略此字段，接收 [ElModel] 作为对象，你可以控制
  /// formJson、toJson、copyWith、merge、generateToString 等参数，其他参数无效，
  /// 被设置为 true 的参数在生成目标代码时将忽略该字段。
  final ElModel ignore;

  /// 序列化、反序列化时指定映射的 json key
  final String? jsonKey;

  /// 当反序列化时如果 json 没有目标参数，指定对象的默认值。
  ///
  /// 注意：设置的默认值请确保和类型相匹配，int 就是 int，double 就是 double，
  /// 任何一个微小的差异都将引起类型转换异常。
  final dynamic defaultValue;
}
