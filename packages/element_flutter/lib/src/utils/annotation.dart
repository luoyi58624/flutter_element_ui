import 'package:element_dart/element_dart.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta_meta.dart';
import '../extensions/color.dart';

// @Target 表示可以将此类当做注解，对于实现 Serialize 接口的类请将其限制在 field 字段上
@Target({TargetKind.field})
class ElDateTimeSerialize implements Serialize<DateTime> {
  /// 日期序列化
  const ElDateTimeSerialize();

  @override
  String? serialize(DateTime? data) => data?.millisecondsSinceEpoch.toString();

  @override
  DateTime? deserialize(String? str) =>
      str == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(str));
}

@Target({TargetKind.field})
class ElColorSerialize implements Serialize<Color> {
  /// 颜色序列化
  const ElColorSerialize();

  @override
  String? serialize(Color? data) => data?.toHex();

  @override
  Color? deserialize(String? str) => str?.toColor();
}

@Target({TargetKind.field})
class ElMaterialColorSerialize implements Serialize<MaterialColor> {
  /// Material 颜色序列化
  const ElMaterialColorSerialize();

  @override
  String? serialize(MaterialColor? data) => data?.toHex();

  @override
  MaterialColor? deserialize(String? str) => str?.toColor().toMaterialColor();
}
