import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElModel {
  /// 生成通用的操作数据模型方法：json序列化、copyWith对象克隆等...
  ///
  /// 注意：生成的代码是根据默认的构造函数参数决定的，构造参数必须是命名构造，
  /// 同时字段参数必须通过 this 或 super 指定，不能存在自命名参数，否则生成的代码会出现错误。
  const ElModel({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = false,
    this.merge = false,
    this.generateEquals = false,
    this.generateHashCode = false,
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
    this.generateEquals = true,
    this.generateHashCode = true,
    this.generateToString = true,
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 生成 formJson、toJson、equals、hashCode 方法
  const ElModel.json({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = false,
    this.merge = false,
    this.generateEquals = true,
    this.generateHashCode = true,
    this.generateToString = false,
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 生成 copyWith、merge、equals、hashCode 方法
  const ElModel.copy({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = true,
    this.merge = true,
    this.generateEquals = true,
    this.generateHashCode = true,
    this.generateToString = false,
    this.fromJsonDiff = false,
    this.toJsonUnderline = false,
  });

  /// 生成 formJson 方法
  /// ```dart
  /// @override
  /// TestModel fromJson(Map<String, dynamic>? json) => _fromJson(json);
  /// ```
  final bool formJson;

  /// 生成 toJson 方法
  /// ```dart
  /// @override
  /// Map<String, dynamic> toJson() => _toJson();
  /// ```
  ///
  /// 提示：序列化类需要继承 [ElSerializeModel] 序列号模型接口，所以不能直接生成 toJson 而是生成 _toJson
  final bool toJson;

  /// 生成 copyWith 方法
  final bool copyWith;

  /// 生成 merge 方法，如果该属性为true，则[copyWith]强制为true
  final bool merge;

  /// 生成 equals 方法
  /// ```dart
  /// @override
  /// bool operator ==(Object other) => _equals(other);
  /// ```
  ///
  /// 注意：不会将 List、Map 等类型的字段进行比较
  final bool generateEquals;

  /// 生成 hashCode 方法
  /// ```dart
  /// @override
  /// int get hashCode => _hashCode;
  /// ```
  final bool generateHashCode;

  /// 生成 toString 方法
  /// ```dart
  /// @override
  /// String toString() => _toString();
  /// ```
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
class ElField {
  /// 模型字段注解
  const ElField({
    this.jsonKey,
    this.defaultValue,
  });

  /// 序列化、反序列化时指定映射的 json key
  final String? jsonKey;

  /// 指定默认值，当反序列化时如果 json 没有目标参数、或者目标类型转换失败时将使用此默认值
  final dynamic defaultValue;
}
