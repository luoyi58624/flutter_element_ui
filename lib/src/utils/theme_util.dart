// import 'package:flutter/material.dart';
//
// class ElThemeUtil {
//   static ThemeData buildMaterialTheme(
//     BuildContext context, {
//     Color primaryColor = Colors.blue,
//     Brightness brightness = Brightness.light,
//     bool useMaterial3 = true,
//     bool enableRipple = true,
//     bool translucenceStatusBar = false,
//     double cardRadius = 8,
//   }) {
//
//     bool isDarkMode = brightness == Brightness.dark;
//
//     if (translucenceStatusBar) {
//       () {
//         SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//             statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
//       }.delay(200);
//     } else {
//       () {
//         SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//             statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
//       }.delay(200);
//     }
//
//     final cardBorder = RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(elConfig.cardRadius),
//     );
//
//     final themeData = ThemeData(
//       useMaterial3: useMaterial3,
//       colorScheme: useMaterial3
//           ? ColorScheme.fromSeed(
//               brightness: brightness, seedColor: primaryColor)
//           : ColorScheme.fromSwatch(
//               brightness: brightness,
//               primarySwatch: primaryColor.toMaterialColor()),
//       // 设置全局默认文字主题
//       textTheme: _textTheme(elTheme),
//       // 是否禁用波纹
//       splashFactory: enableRipple ? InkRipple.splashFactory : noRipperFactory,
//       // 解决web上material按钮外边距为0问题，与移动端的效果保持一致
//       materialTapTargetSize: MaterialTapTargetSize.padded,
//       // 标准显示密度
//       visualDensity: VisualDensity.standard,
//       // 统一页面过渡动画
//       pageTransitionsTheme: const PageTransitionsTheme(builders: {
//         TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//         TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//         TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
//       }),
//       // 背景颜色
//       scaffoldBackgroundColor: elTheme.bgColor,
//       // 图标颜色
//       iconTheme: IconThemeData(color: elTheme.iconColor),
//     );
//
//     return themeData.copyWith(
//       appBarTheme: AppBarTheme(
//         centerTitle: flutterConfigData.centerTitle,
//         toolbarHeight: flutterConfigData.appbarHeight,
//         elevation: flutterConfigData.appbarElevation,
//         scrolledUnderElevation: flutterConfigData.appbarScrollElevation,
//         backgroundColor: elTheme.headerColor,
//         titleTextStyle: TextStyle(
//           fontFamily: FontUtil.fontFamily,
//           fontSize: 18,
//           fontWeight: FontUtil.bold,
//           color: elTheme.headerColor.isDark
//               ? elDarkTheme.textColor
//               : elLightTheme.textColor,
//         ),
//         iconTheme: IconThemeData(
//           color: elTheme.headerColor.isDark
//               ? elDarkTheme.iconColor
//               : elLightTheme.iconColor,
//         ),
//       ),
//       tabBarTheme: TabBarTheme(
//         unselectedLabelStyle: TextStyle(
//           fontFamily: FontUtil.fontFamily,
//           fontWeight: FontUtil.bold,
//           fontSize: 15,
//         ),
//         labelStyle: TextStyle(
//           fontFamily: FontUtil.fontFamily,
//           fontWeight: FontUtil.bold,
//           fontSize: 15,
//           color: primaryColor,
//         ),
//         unselectedLabelColor: elTheme.headerColor.isDark
//             ? elDarkTheme.textColor.deepen(10)
//             : elLightTheme.textColor,
//       ),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         elevation: 2,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: elTheme.headerColor,
//         unselectedLabelStyle:
//             TextStyle(fontSize: 12, fontWeight: FontUtil.medium),
//         selectedLabelStyle: TextStyle(
//             fontSize: 12, fontWeight: FontUtil.bold, color: primaryColor),
//         unselectedIconTheme: const IconThemeData(size: 26),
//         selectedIconTheme: IconThemeData(color: primaryColor, size: 26),
//       ),
//       cardTheme: CardTheme(
//         color: elTheme.cardColor,
//         // m3会将此颜色和color进行混合从而产生一个新的material颜色 (生成一个淡淡的Primary Color)，
//         // 这里将其重置为透明，表示卡片用默认color展示
//         surfaceTintColor: Colors.transparent,
//         elevation: elTheme.cardElevation,
//         margin: const EdgeInsets.all(8),
//         shape: cardBorder,
//       ),
//       drawerTheme: DrawerThemeData(
//         backgroundColor: elTheme.modalColor,
//         surfaceTintColor: Colors.transparent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(0),
//         ),
//       ),
//       listTileTheme: ListTileThemeData(
//         titleTextStyle: TextStyle(
//           fontFamily: FontUtil.fontFamily,
//           fontWeight: FontUtil.medium,
//           color: elTheme.textColor,
//           fontSize: 15,
//         ),
//         subtitleTextStyle: TextStyle(
//           fontFamily: FontUtil.fontFamily,
//           fontWeight: FontUtil.normal,
//           color: elTheme.textColor.deepen(10),
//           fontSize: 13,
//         ),
//         iconColor: elTheme.iconColor,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         // border: const OutlineInputBorder(
//         //   borderSide: BorderSide(color: Colors.grey),
//         // ),
//         labelStyle: TextStyle(
//             fontFamily: FontUtil.fontFamily,
//             fontSize: 16,
//             fontWeight: FontUtil.medium),
//         hintStyle: TextStyle(
//             fontFamily: FontUtil.fontFamily,
//             fontSize: 14,
//             fontWeight: FontUtil.medium),
//       ),
//       expansionTileTheme: ExpansionTileThemeData(
//         textColor: primaryColor,
//         shape: Border.all(width: 0, style: BorderStyle.none),
//         collapsedShape: Border.all(width: 0, style: BorderStyle.none),
//       ),
//       popupMenuTheme: PopupMenuThemeData(
//         color: elTheme.modalColor,
//         surfaceTintColor: Colors.transparent,
//         elevation: elTheme.modalElevation,
//         enableFeedback: true,
//         textStyle: TextStyle(
//           fontFamily: FontUtil.fontFamily,
//           fontWeight: FontUtil.normal,
//           color: elTheme.textColor,
//           fontSize: 14,
//         ),
//         shape: cardBorder,
//       ),
//       dialogTheme: DialogTheme(
//         titleTextStyle: TextStyle(
//           color: elTheme.textColor,
//           fontSize: 18,
//           fontWeight: FontUtil.bold,
//         ),
//         contentTextStyle: TextStyle(
//           color: elTheme.textColor.deepen(16),
//           fontSize: 15,
//           fontWeight: FontUtil.normal,
//         ),
//         elevation: elTheme.modalElevation,
//         backgroundColor: elTheme.modalColor,
//         surfaceTintColor: Colors.transparent,
//         shape: cardBorder,
//         actionsPadding: const EdgeInsets.all(8),
//         insetPadding: EdgeInsets.zero,
//       ),
//       progressIndicatorTheme: ProgressIndicatorThemeData(
//         refreshBackgroundColor:
//             isDarkMode ? Colors.grey.shade700 : Colors.white,
//         color: isDarkMode ? Colors.white : primaryColor,
//       ),
//       segmentedButtonTheme: const SegmentedButtonThemeData(
//         style: ButtonStyle(
//           shape: WidgetStatePropertyAll(
//             StadiumBorder(side: BorderSide()),
//           ),
//           side: WidgetStatePropertyAll(BorderSide(color: Colors.grey)),
//         ),
//       ),
//     );
//   }
// }
//
// TextTheme _textTheme(ElColorThemeData theme) {
//   return TextTheme(
//     displayLarge: TextStyle(
//       fontWeight: FontUtil.bold,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     displayMedium: TextStyle(
//       fontWeight: FontUtil.medium,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     displaySmall: TextStyle(
//       fontWeight: FontUtil.medium,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     headlineLarge: TextStyle(
//       fontWeight: FontUtil.normal,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     headlineMedium: TextStyle(
//       fontWeight: FontUtil.normal,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     headlineSmall: TextStyle(
//       fontWeight: FontUtil.normal,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     titleLarge: TextStyle(
//       fontWeight: FontUtil.bold,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     titleMedium: TextStyle(
//       fontWeight: FontUtil.bold,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     titleSmall: TextStyle(
//       fontWeight: FontUtil.bold,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     bodyLarge: TextStyle(
//       fontWeight: FontUtil.normal,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     bodyMedium: TextStyle(
//       fontWeight: FontUtil.normal,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     bodySmall: TextStyle(
//       fontWeight: FontUtil.normal,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     labelLarge: TextStyle(
//       fontWeight: FontUtil.medium,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     labelMedium: TextStyle(
//       fontWeight: FontUtil.medium,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//     labelSmall: TextStyle(
//       fontWeight: FontUtil.medium,
//       color: theme.textColor,
//       fontFamily: FontUtil.fontFamily,
//       fontFamilyFallback: FontUtil.fontFamilyFallback,
//     ),
//   );
// }
