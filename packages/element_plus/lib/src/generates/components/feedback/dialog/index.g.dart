// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/feedback/dialog/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElDialogThemeDataExtension on ElDialogThemeData {
  /// 接收一组可选参数，返回新的对象
  ElDialogThemeData copyWith({
    Duration? animationDuration,
    Alignment? alignment,
    Offset? offset,
  }) {
    return ElDialogThemeData(
      animationDuration: animationDuration ?? this.animationDuration,
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElDialogThemeData merge([ElDialogThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      animationDuration: other.animationDuration,
      alignment: other.alignment,
      offset: other.offset,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElDialogThemeData &&
          runtimeType == other.runtimeType &&
          animationDuration == other.animationDuration &&
          alignment == other.alignment &&
          offset == other.offset;

  /// 生成 hashCode 方法
  int get _hashCode =>
      animationDuration.hashCode ^ alignment.hashCode ^ offset.hashCode;
}
