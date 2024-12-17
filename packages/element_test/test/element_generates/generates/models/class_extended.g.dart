// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/class_extended.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension RootModelExtension on RootModel {
  /// 接收一组可选参数，返回新的对象
  RootModel copyWith({
    String? rootName,
  }) {
    return RootModel(
      rootName: rootName ?? this.rootName,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  RootModel merge([RootModel? other]) {
    if (other == null) return this;
    return copyWith(
      rootName: other.rootName,
    );
  }
}

extension ParentModelExtension on ParentModel {
  /// 接收一组可选参数，返回新的对象
  ParentModel copyWith({
    String? parentName,
    String? rootName,
  }) {
    return ParentModel(
      parentName: parentName ?? this.parentName,
      rootName: rootName ?? this.rootName,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ParentModel merge([ParentModel? other]) {
    if (other == null) return this;
    return copyWith(
      parentName: other.parentName,
      rootName: other.rootName,
    );
  }
}

extension ChildModelExtension on ChildModel {
  /// 接收一组可选参数，返回新的对象
  ChildModel copyWith({
    String? childName,
    String? parentName,
    String? rootName,
  }) {
    return ChildModel(
      childName: childName ?? this.childName,
      parentName: parentName ?? this.parentName,
      rootName: rootName ?? this.rootName,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ChildModel merge([ChildModel? other]) {
    if (other == null) return this;
    return copyWith(
      childName: other.childName,
      parentName: other.parentName,
      rootName: other.rootName,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ChildModel &&
          runtimeType == other.runtimeType &&
          childName == other.childName &&
          parentName == other.parentName &&
          rootName == other.rootName;

  /// 生成 hashCode 方法
  int get _hashCode =>
      childName.hashCode ^ parentName.hashCode ^ rootName.hashCode;
}

extension ChildModel2Extension on ChildModel2 {
  /// 接收一组可选参数，返回新的对象
  ChildModel2 copyWith({
    String? childName,
  }) {
    return ChildModel2(
      childName: childName ?? this.childName,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ChildModel2 merge([ChildModel2? other]) {
    if (other == null) return this;
    return copyWith(
      childName: other.childName,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ChildModel2 &&
          runtimeType == other.runtimeType &&
          childName == other.childName;

  /// 生成 hashCode 方法
  int get _hashCode => childName.hashCode;
}
