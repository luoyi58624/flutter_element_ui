// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/user.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

const UserModel $userModel = UserModel();

UserModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $userModel;
  return UserModel(
    username: $ElJsonUtil.$string(json, 'username'),
    age: $ElJsonUtil.$int(json, 'age'),
    child: $ElJsonUtil.$model<UserModel?>(json, 'child', $userModel),
    children: $ElJsonUtil.$list<UserModel>(json, 'children'),
    animalMap: $ElJsonUtil.$map<AnimalModel>(json, 'animalMap'),
    mapField: $ElJsonUtil.$map<dynamic>(json, 'mapField'),
  );
}

extension UserModelExtension on UserModel {
  Map<String, dynamic> _toJson() {
    return {
      'username': username,
      'age': age,
      'child': child?.toJson(),
      'children': children,
      'animalMap': animalMap,
      'mapField': mapField,
    };
  }

  UserModel copyWith({
    String? username,
    int? age,
    UserModel? child,
    List<UserModel>? children,
    Map<String, AnimalModel>? animalMap,
    Map<dynamic, dynamic>? mapField,
  }) {
    return UserModel(
      username: username ?? this.username,
      age: age ?? this.age,
      child: this.child?.merge(child),
      children: children ?? this.children,
      animalMap: animalMap ?? this.animalMap,
      mapField: mapField ?? this.mapField,
    );
  }

  UserModel merge([UserModel? other]) {
    if (other == null) return this;
    return copyWith(
      username: other.username,
      age: other.age,
      child: child?.merge(other.child),
      children: other.children,
      animalMap: other.animalMap,
      mapField: other.mapField,
    );
  }

  bool _equals(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          age == other.age &&
          child == other.child &&
          $ElJsonUtil.eqList(children, other.children) &&
          $ElJsonUtil.eqMap(animalMap, other.animalMap) &&
          $ElJsonUtil.eqMap(mapField, other.mapField);

  int get _hashCode =>
      username.hashCode ^
      age.hashCode ^
      child.hashCode ^
      children.hashCode ^
      animalMap.hashCode ^
      mapField.hashCode;

  String _toString() {
    return 'UserModel{\n  username: $username,\n  age: $age,\n  child: $child,\n  children: $children,\n  animalMap: $animalMap,\n  mapField: $mapField\n}';
  }
}
