// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/scroll.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElScrollConfigurationDataExtension on ElScrollConfigurationData {
  ElScrollConfigurationData copyWith({
    bool? disabledRipper,
    Color? ripperColor,
  }) {
    return ElScrollConfigurationData(
      disabledRipper: disabledRipper ?? this.disabledRipper,
      ripperColor: ripperColor ?? this.ripperColor,
    );
  }

  ElScrollConfigurationData merge([ElScrollConfigurationData? other]) {
    if (other == null) return this;
    return copyWith(
      disabledRipper: other.disabledRipper,
      ripperColor: other.ripperColor,
    );
  }
}
