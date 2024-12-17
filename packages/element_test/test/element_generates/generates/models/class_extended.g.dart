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
    );
  }
}
