// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/navigation/nav_menu/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElNavMenuThemeDataExtension on ElNavMenuThemeData {
  ElNavMenuThemeData copyWith({
    Color? activeTextColor,
  }) {
    return ElNavMenuThemeData(
      activeTextColor: activeTextColor ?? this.activeTextColor,
    );
  }

  ElNavMenuThemeData merge([ElNavMenuThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      activeTextColor: other.activeTextColor,
    );
  }
}
