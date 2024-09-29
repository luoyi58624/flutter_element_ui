// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/size.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

SizeModel _fromJson(Map<String, dynamic> json) => SizeModel(
      width: json['width'] as double,
      height: json['height'] as double?,
    );

extension SizeModelExtension on SizeModel {
  Map<String, dynamic> _toJson() {
    return {
      'width': width,
      'height': height,
    };
  }

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

  String _toString() {
    return 'SizeModel{width: $width,height: $height}';
  }
}
