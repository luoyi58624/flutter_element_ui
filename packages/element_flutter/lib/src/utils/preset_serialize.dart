import 'dart:convert';

import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta_meta.dart';
import '../extensions/color.dart';

// @Target 表示可以将此类当做注解，对于实现 ElSerialize 接口的类请将其限制在 field 字段上
@Target({TargetKind.field})
class DateTimeSerialize implements ElSerialize<DateTime> {
  /// 日期序列化
  const DateTimeSerialize();

  @override
  String? serialize(DateTime? obj) => obj?.millisecondsSinceEpoch.toString();

  @override
  DateTime? deserialize(String? str) =>
      str == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(str));
}

@Target({TargetKind.field})
class ColorSerialize implements ElSerialize<Color> {
  /// 颜色序列化
  const ColorSerialize();

  @override
  String? serialize(Color? obj) => obj?.toHex();

  @override
  Color? deserialize(String? str) => str?.toColor();
}

@Target({TargetKind.field})
class MaterialColorSerialize implements ElSerialize<MaterialColor> {
  /// Material 颜色序列化
  const MaterialColorSerialize();

  @override
  String? serialize(MaterialColor? obj) => obj?.toHex();

  @override
  MaterialColor? deserialize(String? str) => str?.toColor().toMaterialColor();
}

@Target({TargetKind.field})
class SizeSerialize implements ElSerialize<Size> {
  /// Size 对象序列化
  const SizeSerialize();

  @override
  String? serialize(Size? obj) => jsonEncode({
        'width': obj?.width,
        'height': obj?.height,
      });

  @override
  Size? deserialize(String? str) {
    if (str == null) return null;
    final map = jsonDecode(str);
    if (map is Map) {
      return Size(
        DartUtil.safeDouble(map['width']),
        DartUtil.safeDouble(map['height']),
      );
    } else {
      return null;
    }
  }
}

@Target({TargetKind.field})
class OffsetSerialize implements ElSerialize<Offset> {
  /// Offset 对象序列化
  const OffsetSerialize();

  @override
  String? serialize(Offset? obj) => jsonEncode({
        'dx': obj?.dx,
        'dy': obj?.dy,
      });

  @override
  Offset? deserialize(String? str) {
    if (str == null) return null;
    final map = jsonDecode(str);
    if (map is Map) {
      return Offset(
        DartUtil.safeDouble(map['dx']),
        DartUtil.safeDouble(map['dy']),
      );
    } else {
      return null;
    }
  }
}
