import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

ElThemeData buildElementTheme({
  Brightness brightness = Brightness.light,
}) {
  ElThemeData data = brightness == Brightness.light
      ? ElThemeData.theme
      : ElThemeData.darkTheme;
  if (brightness == Brightness.light) {
    return ElThemeData(
      primary: GlobalState.primaryColor.value,
      textTheme: ElTextThemeData(
        style: ElFont.defaultTextStyle.copyWith(
          fontFamily: FontUtil.fontFamily,
          fontSize: GlobalState.globalFontSize,
        ),
      ),
      codePreviewTheme: const ElCodePreviewThemeData(
        fontFamily: MyFonts.consolas,
      ),
    );
  } else {
    return ElThemeData.dark(
      primary: GlobalState.primaryColor.value,
      textTheme: ElTextThemeData(
        style: ElFont.defaultTextStyle.copyWith(
          fontFamily: FontUtil.fontFamily,
          fontSize: GlobalState.globalFontSize,
        ),
      ),
      codePreviewTheme: const ElCodePreviewThemeData(
        fontFamily: MyFonts.consolas,
      ),
    );
  }

  return data.copyWith(
    primary: GlobalState.primaryColor.value,
    textTheme: ElTextThemeData(
      style: ElFont.defaultTextStyle.copyWith(
        fontFamily: FontUtil.fontFamily,
        fontSize: GlobalState.globalFontSize,
      ),
    ),
    codePreviewTheme: const ElCodePreviewThemeData(
      fontFamily: MyFonts.consolas,
    ),
  );
}
