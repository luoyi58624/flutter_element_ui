import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';

part '../generates/models/animal.g.dart';

@ElModel.all()
class AnimalModel implements ElSerializeModel {
  final String? name;
  final String? type;

  const AnimalModel({
    this.name,
    this.type,
  });

  AnimalModel.name({
    this.name,
    this.type,
  });

  @override
  AnimalModel fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
