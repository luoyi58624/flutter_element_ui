// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/user.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

/// 生成的全局默认实体类对象，此对象只用于代码生成器，不推荐用户引用它
const UserModel $$userModel = UserModel();

/// 生成 fromJson 方法，将 Map 对象转成实体类
UserModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $$userModel;
  return UserModel(
    username: $$ElJsonUtil.$string(json, 'username'),
    age: $$ElJsonUtil.$int(json, 'age'),
    child: $$ElJsonUtil.$model<UserModel?>(json, 'child', $$userModel),
    children: $$ElJsonUtil.$list<UserModel>(json, 'children'),
    animalMap: $$ElJsonUtil.$map<AnimalModel>(json, 'animalMap'),
    mapField: $$ElJsonUtil.$map<dynamic>(json, 'mapField'),
    childName: $$ElJsonUtil.$string(json, 'childName'),
  );
}

extension UserModelExtension on UserModel {
  /// 生成 toJson 方法，将实体类转成 Map 对象
  Map<String, dynamic> _toJson() {
    return {
      'username': username,
      'age': age,
      'child': child?.toJson(),
      'children': children,
      'animalMap': animalMap,
      'mapField': mapField,
      'childName': childName,
    };
  }

  /// 接收一组可选参数，返回新的对象
  UserModel copyWith({
    String? username,
    int? age,
    UserModel? child,
    List<UserModel>? children,
    Map<String, AnimalModel>? animalMap,
    Map<dynamic, dynamic>? mapField,
    String? childName,
  }) {
    return UserModel(
      username: username ?? this.username,
      age: age ?? this.age,
      child: this.child?.merge(child),
      children: children ?? this.children,
      animalMap: animalMap ?? this.animalMap,
      mapField: mapField ?? this.mapField,
      childName: childName ?? this.childName,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  UserModel merge([UserModel? other]) {
    if (other == null) return this;
    return copyWith(
      username: other.username,
      age: other.age,
      child: other.child,
      children: other.children,
      animalMap: other.animalMap,
      mapField: other.mapField,
      childName: other.childName,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          age == other.age &&
          child == other.child &&
          $$ElJsonUtil.eqList(children, other.children) &&
          $$ElJsonUtil.eqMap(animalMap, other.animalMap) &&
          $$ElJsonUtil.eqMap(mapField, other.mapField) &&
          childName == other.childName;

  /// 生成 hashCode 方法
  int get _hashCode =>
      username.hashCode ^
      age.hashCode ^
      child.hashCode ^
      children.hashCode ^
      animalMap.hashCode ^
      mapField.hashCode ^
      childName.hashCode;

  /// 生成 toString 方法
  String _toString() {
    return 'UserModel{\n  username: $username,\n  age: $age,\n  child: $child,\n  children: $children,\n  animalMap: $animalMap,\n  mapField: $mapField,\n  childName: $childName\n}';
  }
}
