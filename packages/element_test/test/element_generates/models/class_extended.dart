import 'package:element_annotation/element_annotation.dart';

part '../generates/models/class_extended.g.dart';

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
@ElModel.copy(generateHashCode: false, generateEquals: false)
class ChildModel extends ParentModel {
  final String childName;

  const ChildModel({
    required this.childName,
    super.parentName,
    super.rootName,
  });
}

// @ElModel.copy(generateHashCode: false, generateEquals: false)
// class ChildModel2 extends ParentModel {
//   final String childName;
//
//   const ChildModel2({
//     required this.childName,
//   });
// }
