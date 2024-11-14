import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

ElThemeData buildElementTheme({
  Brightness brightness = Brightness.light,
}) {
  ElThemeData data =
      brightness.isDark ? ElThemeData.darkTheme : ElThemeData.theme;

  final $data = data.copyWith(
    primary: brightness.isDark ? Colors.cyanAccent : GlobalState.primaryColor.value,
    textTheme: data.textTheme.copyWith(
      textStyle: ElFont.defaultTextStyle.copyWith(
        fontSize: GlobalState.globalFontSize,
      ),
    ),
    codePreviewTheme: const ElCodePreviewThemeData(
      fontFamily: MyFonts.consolas,
    ),
  );

  return $data;
}