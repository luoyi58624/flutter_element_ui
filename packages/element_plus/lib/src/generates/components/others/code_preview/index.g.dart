// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/code_preview/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCodePreviewThemeDataExtension on ElCodePreviewThemeData {
  /// 接收一组可选参数，返回新的对象
  ElCodePreviewThemeData copyWith({
    String? fontFamily,
    Color? color,
    Color? bgColor,
    bool? enableSection,
  }) {
    return ElCodePreviewThemeData(
      fontFamily: fontFamily ?? this.fontFamily,
      color: color ?? this.color,
      bgColor: bgColor ?? this.bgColor,
      enableSection: enableSection ?? this.enableSection,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElCodePreviewThemeData merge([ElCodePreviewThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      fontFamily: other.fontFamily,
      color: other.color,
      bgColor: other.bgColor,
      enableSection: other.enableSection,
    );
  }
}
