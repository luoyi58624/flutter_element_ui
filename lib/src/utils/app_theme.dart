import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElMaterialThemeData {
  static final data = ElMaterialThemeData();

  ElMaterialThemeData({
    this.useMaterial3 = true,
    this.enableRipple = true,
    this.translucenceStatusBar = false,
    this.appbarCenterTitle = true,
    this.appbarHeight = 56,
    this.appbarElevation,
    this.appbarScrollElevation,
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
  double? appbarElevation;

  /// appbar 滚动时海拔，默认跟随 appbarElevation
  double? appbarScrollElevation;
}

class ElThemeUtil {
  ElThemeUtil._();

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
    final lightTheme = ElApp.of(context).theme;
    final darkTheme = context.darkTheme;
    final elTheme = isDarkMode ? darkTheme : lightTheme;
    final textStyle = ElApp.of(context).textStyle;
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
      borderRadius: elTheme.cardStyle.radius,
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
      fontFamilyFallback: textStyle.fontFamilyFallback,
      // 是否禁用波纹
      splashFactory:
          data.enableRipple ? InkRipple.splashFactory : noRipperFactory,
      // 解决web上material按钮外边距为0问题，与移动端的效果保持一致
      materialTapTargetSize: MaterialTapTargetSize.padded,
      // 标准显示密度
      visualDensity: VisualDensity.standard,
      // 统一页面过渡动画
      // pageTransitionsTheme: const PageTransitionsTheme(builders: {
      //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      //   TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      //   TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      // }),
      // 背景颜色
      scaffoldBackgroundColor: elTheme.bgColor,
      // 图标颜色
      iconTheme: IconThemeData(color: elTheme.iconStyle.color),
    );

    return themeData.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: data.appbarCenterTitle,
        toolbarHeight: data.appbarHeight,
        elevation: data.appbarElevation,
        scrolledUnderElevation: data.appbarScrollElevation,
        backgroundColor: elTheme.headerStyle.color,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black87,
        titleTextStyle: textStyle.copyWith(
          fontSize: 18,
          fontWeight: ElFont.bold,
          color: elTheme.headerStyle.color.isDark
              ? darkTheme.textColor
              : lightTheme.textColor,
        ),
        iconTheme: IconThemeData(
          color: elTheme.headerStyle.color.isDark
              ? darkTheme.iconStyle.color
              : lightTheme.iconStyle.color,
        ),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: textStyle.copyWith(
          fontWeight: ElFont.medium,
          fontSize: 15,
        ),
        labelStyle: textStyle.copyWith(
          fontWeight: ElFont.medium,
          fontSize: 15,
          color: elTheme.primary,
        ),
        unselectedLabelColor: elTheme.headerStyle.color.isDark
            ? darkTheme.textColor.deepen(10)
            : lightTheme.textColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        backgroundColor: elTheme.headerStyle.color,
        unselectedLabelStyle: textStyle.copyWith(
          fontSize: 12,
          fontWeight: ElFont.medium,
        ),
        selectedLabelStyle: textStyle.copyWith(
          fontSize: 12,
          fontWeight: ElFont.medium,
          color: elTheme.primary,
        ),
        unselectedIconTheme: const IconThemeData(size: 26),
        selectedIconTheme: IconThemeData(color: elTheme.primary, size: 26),
      ),
      cardTheme: CardTheme(
        color: elTheme.cardStyle.color,
        // m3会将此颜色和color进行混合从而产生一个新的material颜色 (生成一个淡淡的Primary Color)，
        // 这里将其重置为透明，表示卡片用默认color展示
        surfaceTintColor: Colors.transparent,
        elevation: elTheme.cardStyle.elevation,
        margin: const EdgeInsets.all(8),
        shape: cardBorder,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: elTheme.modalStyle.color,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: textStyle.copyWith(
          fontWeight: ElFont.medium,
          fontSize: 15,
        ),
        subtitleTextStyle: textStyle.copyWith(
          fontWeight: ElFont.normal,
          color: elTheme.textColor.deepen(10),
          fontSize: 13,
        ),
        iconColor: elTheme.iconStyle.color,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: textStyle.copyWith(
          fontSize: 16,
          fontWeight: ElFont.medium,
        ),
        hintStyle: textStyle.copyWith(
          fontSize: 14,
          fontWeight: ElFont.medium,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        textColor: elTheme.primary,
        shape: Border.all(width: 0, style: BorderStyle.none),
        collapsedShape: Border.all(width: 0, style: BorderStyle.none),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: elTheme.modalStyle.color,
        surfaceTintColor: Colors.transparent,
        elevation: elTheme.modalStyle.elevation,
        enableFeedback: true,
        textStyle: textStyle.copyWith(fontSize: 14),
        shape: cardBorder,
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: textStyle.copyWith(
          fontSize: 18,
          fontWeight: ElFont.bold,
        ),
        contentTextStyle: textStyle.copyWith(
          color: elTheme.textColor.deepen(16),
          fontSize: 15,
        ),
        elevation: elTheme.modalStyle.elevation,
        backgroundColor: elTheme.bgColor,
        surfaceTintColor: Colors.transparent,
        shape: cardBorder,
        actionsPadding: const EdgeInsets.all(8),
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
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      ),
    );
  }

  static CupertinoThemeData buildCupertinoThemeData(
    BuildContext context, {
    Brightness brightness = Brightness.light,
  }) {
    bool isDarkMode = brightness == Brightness.dark;
    final lightTheme = ElApp.of(context).theme;
    final darkTheme = context.darkTheme;
    final elTheme = isDarkMode ? darkTheme : lightTheme;
    final textStyle = ElApp.of(context).textStyle;

    CupertinoThemeData themeData = CupertinoThemeData(brightness: brightness);

    return themeData.copyWith(
      primaryColor: elTheme.primary,
      textTheme: CupertinoTextThemeData(
        textStyle: themeData.textTheme.textStyle.merge(textStyle),
        tabLabelTextStyle:
            themeData.textTheme.tabLabelTextStyle.merge(textStyle).copyWith(
                  fontSize: 12,
                ),
        navActionTextStyle:
            themeData.textTheme.navActionTextStyle.merge(textStyle).copyWith(
                  color: elTheme.primary,
                  fontWeight: ElFont.medium,
                  fontSize: 16,
                ),
        navTitleTextStyle:
            themeData.textTheme.navTitleTextStyle.merge(textStyle).copyWith(
                  fontWeight: ElFont.bold,
                ),
        navLargeTitleTextStyle: themeData.textTheme.navLargeTitleTextStyle
            .merge(textStyle)
            .copyWith(
              fontWeight: ElFont.bold,
            ),
      ),
    );
  }
}

TextTheme _textTheme(TextStyle style, ElThemeData elTheme) {
  return TextTheme(
    displayLarge: style.copyWith(fontWeight: ElFont.bold),
    displayMedium: style.copyWith(fontWeight: ElFont.medium),
    displaySmall: style.copyWith(fontWeight: ElFont.medium),
    headlineLarge: style.copyWith(fontWeight: ElFont.normal),
    headlineMedium: style.copyWith(fontWeight: ElFont.normal),
    headlineSmall: style.copyWith(fontWeight: ElFont.normal),
    titleLarge: style.copyWith(fontWeight: ElFont.bold),
    titleMedium: style.copyWith(fontWeight: ElFont.bold),
    titleSmall: style.copyWith(fontWeight: ElFont.bold),
    bodyLarge: style.copyWith(fontWeight: ElFont.normal),
    bodyMedium: style.copyWith(fontWeight: ElFont.normal),
    bodySmall: style.copyWith(fontWeight: ElFont.normal),
    labelLarge: style.copyWith(fontWeight: ElFont.medium),
    labelMedium: style.copyWith(fontWeight: ElFont.medium),
    labelSmall: style.copyWith(fontWeight: ElFont.medium),
  );
}
