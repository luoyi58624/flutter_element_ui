// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/size.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension SizeModelExtension on SizeModel {
  SizeModel copyWith({
    double? width,
    double? height,
  }) {
    return SizeModel(
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  SizeModel merge([SizeModel? other]) {
    if (other == null) return this;
    return copyWith(
      width: other.width,
      height: other.height,
    );
  }
}
