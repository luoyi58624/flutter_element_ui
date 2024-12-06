// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/clone_model.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

/// 生成的全局默认实体类对象
final CloneModel3 $cloneModel3 = CloneModel3(
  name: '',
  age: 0,
);

/// 生成 fromJson 方法，将 Map 对象转成实体类
CloneModel3 _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $cloneModel3;
  return CloneModel3(
    name: $ElJsonUtil.$string(json, 'name') ?? '',
    age: $ElJsonUtil.$int(json, 'age') ?? 0,
  );
}

extension CloneModel3Extension on CloneModel3 {
  /// 生成 toJson 方法，将实体类转成 Map 对象
  Map<String, dynamic> _toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  /// 接收一组可选参数，返回新的对象
  CloneModel3 copyWith({
    String? name,
    int? age,
  }) {
    return CloneModel3(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  CloneModel3 merge([CloneModel3? other]) {
    if (other == null) return this;
    return copyWith(
      name: other.name,
      age: other.age,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is CloneModel3 &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age;

  /// 生成 hashCode 方法
  int get _hashCode => name.hashCode ^ age.hashCode;

  /// 生成 toString 方法
  String _toString() {
    return 'CloneModel3{\n  name: $name,\n  age: $age\n}';
  }
}
