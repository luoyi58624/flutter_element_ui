// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/animal.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

/// 生成的全局默认实体类对象，此对象只用于代码生成器，不推荐用户引用它
const AnimalModel $$animalModel = AnimalModel();

/// 生成 fromJson 方法，将 Map 对象转成实体类
AnimalModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $$animalModel;
  return AnimalModel(
    name: $$ElJsonUtil.$string(json, 'name'),
    type: $$ElJsonUtil.$string(json, 'type'),
  );
}

extension AnimalModelExtension on AnimalModel {
  /// 生成 toJson 方法，将实体类转成 Map 对象
  Map<String, dynamic> _toJson() {
    return {
      'name': name,
      'type': type,
    };
  }

  /// 接收一组可选参数，返回新的对象
  AnimalModel copyWith({
    String? name,
    String? type,
  }) {
    return AnimalModel(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  AnimalModel merge([AnimalModel? other]) {
    if (other == null) return this;
    return copyWith(
      name: other.name,
      type: other.type,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is AnimalModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  /// 生成 hashCode 方法
  int get _hashCode => name.hashCode ^ type.hashCode;

  /// 生成 toString 方法
  String _toString() {
    return 'AnimalModel{\n  name: $name,\n  type: $type\n}';
  }
}
