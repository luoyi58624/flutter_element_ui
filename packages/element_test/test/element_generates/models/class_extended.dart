import 'package:element_annotation/element_annotation.dart';

part '../generates/models/class_extended.g.dart';

@ElModel.copy(generateHashCode: false, generateEquals: false)
class RootModel {
  @ElField(ignore: ElModel(merge: true))
  final String? rootName;

  const RootModel({this.rootName});
}

@ElModel.copy(generateHashCode: false, generateEquals: false)
class ParentModel extends RootModel {
  @ElField(ignore: ElModel(copyWith: true))
  final String? parentName;

  const ParentModel({this.parentName, super.rootName});
}

@ElDebug()
@ElModel.copy(generateHashCode: false, generateEquals: false)
class ChildModel extends ParentModel {
  @ElField(ignore: ElModel(copyWith: true))
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
