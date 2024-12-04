import 'package:flutter/material.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:meta/meta_meta.dart';
import '../extensions/color.dart';

// @Target 表示：在代码生成中，如果将其用于注解，那么只能放在字段上
@Target({TargetKind.field})
class ElDateTimeSerialize implements ElSerialize<DateTime> {
  /// 日期序列化
  const ElDateTimeSerialize();

  @override
  String? serialize(DateTime? data) => data?.millisecondsSinceEpoch.toString();

  @override
  DateTime? deserialize(String? str) =>
      str == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(str));
}

@Target({TargetKind.field})
class ElColorSerialize implements ElSerialize<Color> {
  /// 颜色序列化
  const ElColorSerialize();

  @override
  String? serialize(Color? data) => data?.toHex();

  @override
  Color? deserialize(String? str) => str?.toColor();
}

@Target({TargetKind.field})
class ElMaterialColorSerialize implements ElSerialize<MaterialColor> {
  /// Material 颜色序列化
  const ElMaterialColorSerialize();

  @override
  String? serialize(MaterialColor? data) => data?.toHex();

  @override
  MaterialColor? deserialize(String? str) => str?.toColor().toMaterialColor();
}
