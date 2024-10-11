// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/animal.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

const AnimalModel $animalModel = AnimalModel();

AnimalModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $animalModel;
  return AnimalModel(
    name: $ElJsonUtil.$string(json, 'name'),
    type: $ElJsonUtil.$string(json, 'type'),
  );
}

extension AnimalModelExtension on AnimalModel {
  Map<String, dynamic> _toJson() {
    return {
      'name': name,
      'type': type,
    };
  }

  AnimalModel copyWith({
    String? name,
    String? type,
  }) {
    return AnimalModel(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  AnimalModel merge([AnimalModel? other]) {
    if (other == null) return this;
    return copyWith(
      name: other.name,
      type: other.type,
    );
  }

  bool _equals(Object other) =>
      identical(this, other) ||
      other is AnimalModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  int get _hashCode => name.hashCode ^ type.hashCode;

  String _toString() {
    return 'AnimalModel{\n  name: $name,\n  type: $type\n}';
  }
}
