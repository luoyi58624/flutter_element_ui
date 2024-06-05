library flutter_element_annotation;

import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElModel {
  /// 标识数据类模型，默认开启所有功能
  const ElModel({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = true,
    this.merge = true,
    this.createToString = true,
  });

  /// 默认关闭所有功能
  const ElModel.none({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = false,
    this.merge = false,
    this.createToString = false,
  });

  /// 默认只开启 json_serializable
  const ElModel.json({
    this.formJson = true,
    this.toJson = true,
    this.copyWith = false,
    this.merge = false,
    this.createToString = false,
  });

  /// 默认只开启 copyWith、merge
  const ElModel.copy({
    this.formJson = false,
    this.toJson = false,
    this.copyWith = true,
    this.merge = true,
    this.createToString = false,
  });

  /// 生成 formJson 方法
  final bool formJson;

  /// 生成 toJson 方法
  final bool toJson;

  /// 生成 copyWith 方法
  final bool copyWith;

  /// 生成 merge 方法，如果该属性为true，则[copyWith]强制为true
  final bool merge;

  /// 生成 toString 方法
  final bool createToString;
}
