// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/model.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension DemoModelExtension on DemoModel {
  DemoModel copyWith({
    String? user,
  }) {
    return DemoModel(
      user: user ?? this.user,
    );
  }

  DemoModel merge([DemoModel? other]) {
    if (other == null) return this;
    return copyWith(
      user: other.user,
    );
  }
}
