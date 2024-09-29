// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/size.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

SizeModel _fromJsonSizeModel(Map<String, dynamic> json) => SizeModel(
      width: json['width'] as double,
      maxWidth: json['maxWidth'] as double,
      height: json['height'] as double?,
    );

extension SizeModelExtension on SizeModel {
  Map<String, dynamic> _toJson() {
    return {
      'width': width,
      'maxWidth': maxWidth,
      'height': height,
    };
  }

  SizeModel copyWith({
    double? width,
    double? maxWidth,
    double? height,
  }) {
    return SizeModel(
      width: width ?? this.width,
      maxWidth: maxWidth ?? this.maxWidth,
      height: height ?? this.height,
    );
  }

  SizeModel merge([SizeModel? other]) {
    if (other == null) return this;
    return copyWith(
      width: other.width,
      maxWidth: other.maxWidth,
      height: other.height,
    );
  }

  String _toString() {
    return 'SizeModel{width: $width,maxWidth: $maxWidth,height: $height}';
  }
}

LabelModel _fromJsonLabelModel(Map<String, dynamic> json) => LabelModel(
      label: json['label'] as String,
      value: json['value'] as String,
    );

extension LabelModelExtension on LabelModel {
  Map<String, dynamic> _toJson() {
    return {
      'label': label,
      'value': value,
    };
  }

  LabelModel copyWith({
    String? label,
    String? value,
  }) {
    return LabelModel(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }

  LabelModel merge([LabelModel? other]) {
    if (other == null) return this;
    return copyWith(
      label: other.label,
      value: other.value,
    );
  }

  String _toString() {
    return 'LabelModel{label: $label,value: $value}';
  }
}
