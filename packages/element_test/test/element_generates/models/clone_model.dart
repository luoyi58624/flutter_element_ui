import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';

part '../generates/models/clone_model.g.dart';

/// 原生对象，如果直接通过 = 符号赋值另一个对象，那么修改另一个对象会同步修改原有对象
class CloneModel {
  String name;
  int age;

  CloneModel({required this.name, required this.age});
}

/// 实现克隆接口
class CloneModel2 implements Cloneable<CloneModel2> {
  String name;
  int age;

  CloneModel2({required this.name, required this.age});

  @override
  CloneModel2 clone() => CloneModel2(name: name, age: age);
}

/// 实现克隆接口，并覆写 equals、hashCode 方法
@ElModel.all()
class CloneModel3 implements Cloneable<CloneModel3> {
  String name;
  int age;

  CloneModel3({required this.name, required this.age});

  @override
  CloneModel3 clone() => CloneModel3(name: name, age: age);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
