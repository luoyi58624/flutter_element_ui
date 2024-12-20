import 'dart:convert';

import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta_meta.dart';

class ElSerializePreset {
  /// 构建常用的序列化预设对象，此对象通常用于本地持久化存储，你可以继承此类覆写 [apply] 方法扩展更多自定义序列化预设函数：
  /// ```dart
  /// class MySerializePreset extends ElSerializePreset {
  ///   @override
  ///   ElSerialize? apply<T>([ElSerialize? serialize]) {
  ///     final result = super.apply(serialize);
  ///     if (result != null) return result;
  ///     final type = T.toString();
  ///     if (type == 'CustomModel') return const CustomModelSerialize();
  ///     return null;
  ///   }
  /// }
  /// ```
  const ElSerializePreset();

  /// 加载序列化对象，如果没有传递指定的序列化对象，那么将通过泛型类型加载内置的序列化对象
  ElSerialize? apply<T>([ElSerialize? serialize]) {
    if (serialize != null) return serialize;
    final type = T.toString();
    if (type == 'dynamic' || type == 'null') return null;
    if (DartUtil.isBaseTypeString(type)) return null;
    if (type == 'Size') return const ElSizeSerialize();
    if (type == 'Offset') return const ElOffsetSerialize();
    if (type == 'Color') return const ElColorSerialize();
    if (type == 'MaterialColor') return const ElMaterialElColorSerialize();
    if (type == 'DateTime') return const ElDateTimeSerialize();
    return null;
  }
}

// @Target 表示可以将此类当做注解，对于实现 ElSerialize 接口的类请将其限制在 field 字段上
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
class ElMaterialElColorSerialize implements ElSerialize<MaterialColor> {
  /// Material 颜色序列化
  const ElMaterialElColorSerialize();

  @override
  String? serialize(MaterialColor? obj) => obj?.toHex();

  @override
  MaterialColor? deserialize(String? str) => str?.toColor().toMaterialColor();
}

@Target({TargetKind.field})
class ElSizeSerialize implements ElSerialize<Size> {
  /// Size 对象序列化
  const ElSizeSerialize();

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
class ElOffsetSerialize implements ElSerialize<Offset> {
  /// Offset 对象序列化
  const ElOffsetSerialize();

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
