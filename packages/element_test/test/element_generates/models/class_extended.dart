import 'package:element_annotation/element_annotation.dart';

part '../generates/models/class_extended.g.dart';

// ========================================================================
// 测试继承实体类的代码生成
// ========================================================================

@ElModel.copy(generateHashCode: false, generateEquals: false)
class RootModel {
  final String? rootName;

  const RootModel({this.rootName});
}

@ElModel.copy(generateHashCode: false, generateEquals: false)
class ParentModel extends RootModel {
  final String? parentName;

  const ParentModel({this.parentName, super.rootName});
}

@ElDebug()
@ElModel.copy()
class ChildModel extends ParentModel {
  final String childName;

  /// 如果指定父级字段，那么生成的代码将会携带父级字段
  ChildModel({
    required this.childName,
    super.parentName,
    super.rootName,
  });

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@ElModel.copy()
class ChildModel2 extends ParentModel {
  final String? childName;

  /// 如果不指定父级字段，那么生成的代码也不会包含父级字段
  const ChildModel2({
    this.childName,
  });
}
