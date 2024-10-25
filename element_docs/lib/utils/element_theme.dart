import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

ElThemeData buildElementTheme({
  Brightness brightness = Brightness.light,
}) {
  return ElThemeData(
    primary: GlobalState.primaryColor.value,
    textTheme: ElTextThemeData(
      style: TextStyle(
        fontFamily: FontUtil.fontFamily,
        fontSize: GlobalState.globalFontSize,
      ),
    ),
    codePreviewTheme: const ElCodePreviewThemeData(
      fontFamily: MyFonts.consolas,
    ),
  );
}
