import 'package:flutter/material.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:meta/meta_meta.dart';
import '../extensions/color.dart';

@Target({TargetKind.field})
class ElDateTimeSerialize implements ElSerialize<DateTime> {
  /// 日期序列化
  const ElDateTimeSerialize();

  @override
  String? serialize(DateTime? obj) => obj?.millisecondsSinceEpoch.toString();

  @override
  DateTime? deserialize(String? str) =>
      str == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(str));
}

@Target({TargetKind.field})
class ElColorSerialize implements ElSerialize<Color> {
  /// 颜色序列化
  const ElColorSerialize();

  @override
  String? serialize(Color? obj) => obj?.toHex();

  @override
  Color? deserialize(String? str) => str?.toColor();
}

@Target({TargetKind.field})
class ElMaterialColorSerialize implements ElSerialize<MaterialColor> {
  /// Material 颜色序列化
  const ElMaterialColorSerialize();

  @override
  String? serialize(MaterialColor? obj) => obj?.toHex();

  @override
  MaterialColor? deserialize(String? str) => str?.toColor().toMaterialColor();
}
