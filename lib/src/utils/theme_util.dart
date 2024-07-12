import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_element_ui/src/theme.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../styles/theme.dart';
import 'font.dart';

class ElMaterialThemeData {
  static final data = ElMaterialThemeData();

  ElMaterialThemeData({
    this.useMaterial3 = true,
    this.enableRipple = true,
    this.translucenceStatusBar = false,
    this.appbarCenterTitle = true,
    this.appbarHeight = 56,
    this.appbarElevation = 0,
    this.appbarScrollElevation = 0,
  });

  /// 是否开启material3
  bool useMaterial3;

  /// 是否开启波纹动画
  bool enableRipple;

  /// 是否显示半透明遮罩状态栏，只有m2生效
  bool translucenceStatusBar;

  /// appbar 标题是否居中
  bool appbarCenterTitle;

  /// appbar 高度
  double appbarHeight;

  /// appbar 海拔
  double appbarElevation;

  /// appbar 滚动时海拔
  double appbarScrollElevation;
}

class ElThemeUtil {
  /// 基于 Element UI 主题系统构建 Material 主题
  ///
  /// * context 通过上下文获取 [ElTheme] 配置，请注意传递正确的[context]，
  /// 同一作用域内请使用 [Builder] 转发 [context] 对象
  static ThemeData buildMaterialTheme(
    BuildContext context, {
    ElMaterialThemeData? data,
    Brightness brightness = Brightness.light,
  }) {
    data ??= ElMaterialThemeData.data;
    bool isDarkMode = brightness == Brightness.dark;
    final lightTheme = context.theme;
    final darkTheme = context.darkTheme;
    final elTheme = isDarkMode ? darkTheme : lightTheme;
    final elConfig = context.elConfig;
    final textStyle = DefaultTextStyle.of(context).style;
    if (data.translucenceStatusBar) {
      () {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
      }.delay(200);
    } else {
      () {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
      }.delay(200);
    }

    final cardBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(elConfig.cardRadius),
    );

    final themeData = ThemeData(
      useMaterial3: data.useMaterial3,
      colorScheme: data.useMaterial3
          ? ColorScheme.fromSeed(
              brightness: brightness, seedColor: elTheme.primary)
          : ColorScheme.fromSwatch(
              brightness: brightness,
              primarySwatch: elTheme.primary.toMaterialColor()),
      // 设置全局默认文字主题
      textTheme: _textTheme(textStyle, elTheme),
      // 是否禁用波纹
      splashFactory:
          data.enableRipple ? InkRipple.splashFactory : noRipperFactory,
      // 解决web上material按钮外边距为0问题，与移动端的效果保持一致
      materialTapTargetSize: MaterialTapTargetSize.padded,
      // 标准显示密度
      visualDensity: VisualDensity.standard,
      // 统一页面过渡动画
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      }),
      // 背景颜色
      scaffoldBackgroundColor: elTheme.bgColor,
      // 图标颜色
      iconTheme: IconThemeData(color: elTheme.iconColor),
    );

    return themeData.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: data.appbarCenterTitle,
        toolbarHeight: data.appbarHeight,
        elevation: data.appbarElevation,
        scrolledUnderElevation: data.appbarScrollElevation,
        backgroundColor: elTheme.headerColor,
        titleTextStyle: TextStyle(
          fontFamily: textStyle.fontFamily,
          fontSize: 18,
          fontWeight: ElFontWeight.bold,
          color: elTheme.headerColor.isDark
              ? darkTheme.textColor
              : lightTheme.textColor,
        ),
        iconTheme: IconThemeData(
          color: elTheme.headerColor.isDark
              ? darkTheme.iconColor
              : lightTheme.iconColor,
        ),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: TextStyle(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.bold,
          fontSize: 15,
        ),
        labelStyle: TextStyle(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.bold,
          fontSize: 15,
          color: elTheme.primary,
        ),
        unselectedLabelColor: elTheme.headerColor.isDark
            ? darkTheme.textColor.deepen(10)
            : lightTheme.textColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: elTheme.headerColor,
        unselectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: ElFontWeight.medium),
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: ElFontWeight.bold,
            color: elTheme.primary),
        unselectedIconTheme: const IconThemeData(size: 26),
        selectedIconTheme: IconThemeData(color: elTheme.primary, size: 26),
      ),
      cardTheme: CardTheme(
        color: elTheme.cardColor,
        // m3会将此颜色和color进行混合从而产生一个新的material颜色 (生成一个淡淡的Primary Color)，
        // 这里将其重置为透明，表示卡片用默认color展示
        surfaceTintColor: Colors.transparent,
        elevation: elTheme.cardElevation,
        margin: const EdgeInsets.all(8),
        shape: cardBorder,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: elTheme.modalColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.medium,
          color: elTheme.textColor,
          fontSize: 15,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.normal,
          color: elTheme.textColor.deepen(10),
          fontSize: 13,
        ),
        iconColor: elTheme.iconColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // border: const OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.grey),
        // ),
        labelStyle: TextStyle(
            fontFamily: textStyle.fontFamily,
            fontSize: 16,
            fontWeight: ElFontWeight.medium),
        hintStyle: TextStyle(
            fontFamily: textStyle.fontFamily,
            fontSize: 14,
            fontWeight: ElFontWeight.medium),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        textColor: elTheme.primary,
        shape: Border.all(width: 0, style: BorderStyle.none),
        collapsedShape: Border.all(width: 0, style: BorderStyle.none),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: elTheme.modalColor,
        surfaceTintColor: Colors.transparent,
        elevation: elTheme.modalElevation,
        enableFeedback: true,
        textStyle: TextStyle(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.normal,
          color: elTheme.textColor,
          fontSize: 14,
        ),
        shape: cardBorder,
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: elTheme.textColor,
          fontSize: 18,
          fontWeight: ElFontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: elTheme.textColor.deepen(16),
          fontSize: 15,
          fontWeight: ElFontWeight.normal,
        ),
        elevation: elTheme.modalElevation,
        backgroundColor: elTheme.modalColor,
        surfaceTintColor: Colors.transparent,
        shape: cardBorder,
        actionsPadding: const EdgeInsets.all(8),
        insetPadding: EdgeInsets.zero,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        refreshBackgroundColor:
            isDarkMode ? Colors.grey.shade700 : Colors.white,
        color: isDarkMode ? Colors.white : elTheme.primary,
      ),
      segmentedButtonTheme: const SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            StadiumBorder(side: BorderSide()),
          ),
          side: WidgetStatePropertyAll(BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }

  static CupertinoThemeData buildCupertinoThemeData(
    BuildContext context, {
    Brightness brightness = Brightness.light,
  }) {
    bool isDarkMode = brightness == Brightness.dark;
    final lightTheme = context.theme;
    final darkTheme = context.darkTheme;
    final elTheme = isDarkMode ? darkTheme : lightTheme;
    final textStyle = DefaultTextStyle.of(context).style;
    CupertinoThemeData themeData = CupertinoThemeData(brightness: brightness);

    return themeData.copyWith(
      primaryColor: elTheme.primary,
      textTheme: CupertinoTextThemeData(
        textStyle: themeData.textTheme.textStyle.copyWith(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.normal,
        ),
        tabLabelTextStyle: themeData.textTheme.tabLabelTextStyle.copyWith(
          fontSize: 12,
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.normal,
        ),
        navActionTextStyle: themeData.textTheme.navActionTextStyle.copyWith(
          color: elTheme.primary,
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.medium,
          fontSize: 16,
        ),
        navTitleTextStyle: themeData.textTheme.navTitleTextStyle.copyWith(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.medium,
        ),
        navLargeTitleTextStyle:
            themeData.textTheme.navLargeTitleTextStyle.copyWith(
          fontFamily: textStyle.fontFamily,
          fontWeight: ElFontWeight.normal,
        ),
      ),
    );
  }
}

TextTheme _textTheme(TextStyle style, ElBrightnessData elTheme) {
  return TextTheme(
    displayLarge: TextStyle(
      fontWeight: ElFontWeight.bold,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    displayMedium: TextStyle(
      fontWeight: ElFontWeight.medium,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    displaySmall: TextStyle(
      fontWeight: ElFontWeight.medium,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    headlineLarge: TextStyle(
      fontWeight: ElFontWeight.normal,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    headlineMedium: TextStyle(
      fontWeight: ElFontWeight.normal,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    headlineSmall: TextStyle(
      fontWeight: ElFontWeight.normal,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    titleLarge: TextStyle(
      fontWeight: ElFontWeight.bold,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    titleMedium: TextStyle(
      fontWeight: ElFontWeight.bold,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    titleSmall: TextStyle(
      fontWeight: ElFontWeight.bold,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    bodyLarge: TextStyle(
      fontWeight: ElFontWeight.normal,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    bodyMedium: TextStyle(
      fontWeight: ElFontWeight.normal,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    bodySmall: TextStyle(
      fontWeight: ElFontWeight.normal,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    labelLarge: TextStyle(
      fontWeight: ElFontWeight.medium,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    labelMedium: TextStyle(
      fontWeight: ElFontWeight.medium,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
    labelSmall: TextStyle(
      fontWeight: ElFontWeight.medium,
      color: elTheme.textColor,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
    ),
  );
}
