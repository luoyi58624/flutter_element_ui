import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'basic/input.dart';

part '../generates/styles/theme.g.dart';

/// Element UI 根据平台亮度应用的主题对象
@ElModel(copyWith: true)
class ElBrightnessData {
  /// 亮色默认主题
  static ElBrightnessData lightTheme = ElBrightnessData();

  /// 暗色默认主题
  static ElBrightnessData darkTheme = ElBrightnessData.dark();

  /// 描述当前主题系统是否是亮色、暗色
  @ElModelField(ignore: ElModel.all())
  final Brightness brightness;

  /// 主要颜色
  Color primary;

  /// 成功颜色
  Color success;

  /// 普通颜色
  Color info;

  /// 警告颜色
  Color warning;

  /// 错误颜色
  Color error;

  /// 全局背景色
  Color bgColor;

  /// 头部背景颜色
  Color headerColor;

  /// 侧边栏背景色
  Color asideBgColor;

  /// 卡片背景色
  Color cardColor;

  /// 模态框、弹出层背景色
  Color modalColor;

  /// 标题颜色
  Color titleColor;

  /// 文字颜色
  Color textColor;

  /// icon颜色
  Color iconColor;

  /// 边框颜色
  Color borderColor;

  /// 边框悬停颜色
  Color get borderHoverColor => borderColor.deepen(16);

  /// 菜单栏激活文字颜色
  Color menuActiveColor;

  /// 卡片海拔高度，设置较低的海拔能让应用更加扁平化，设置较高的海拔则让应用更具层级感
  double cardElevation;

  /// 模态弹窗海拔高度
  double modalElevation;

  /// 默认的亮色主题构造函数
  ElBrightnessData({
    this.brightness = Brightness.light,
    this.primary = const Color(0xff409eff),
    this.success = const Color(0xff67c23a),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffe6a23c),
    this.error = const Color(0xfff56c6c),
    this.bgColor = const Color(0xfffafafa),
    this.headerColor = const Color(0xffffffff),
    this.cardColor = const Color(0xffffffff),
    this.modalColor = const Color(0xffffffff),
    this.titleColor = const Color(0xff181818),
    this.textColor = const Color(0xff222222),
    this.iconColor = const Color(0xff404040),
    this.borderColor = const Color(0xffdcdfe6),
    this.asideBgColor = const Color(0xff565c64),
    this.menuActiveColor = const Color(0xffffd04b),
    this.cardElevation = 0,
    this.modalElevation = 2,
  });

  /// 默认的暗色主题构造函数
  ElBrightnessData.dark({
    this.brightness = Brightness.dark,
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff14b8a6),
    this.info = const Color(0xff64748B),
    this.warning = const Color(0xfffbbf24),
    this.error = const Color(0xfffb7185),
    this.bgColor = const Color(0xff2b2b2b),
    this.headerColor = const Color(0xff404040),
    this.cardColor = const Color(0xffffffff),
    this.modalColor = const Color(0xffffffff),
    this.titleColor = const Color(0xfffafafa),
    this.textColor = const Color(0xfff2f2f2),
    this.iconColor = const Color(0xfff6f6f6),
    this.borderColor = const Color(0xffa3a3a3),
    this.asideBgColor = const Color(0xff374151),
    this.menuActiveColor = const Color(0xff6ee7b7),
    this.cardElevation = 2,
    this.modalElevation = 4,
  });
}

/// Element UI 全局配置，定义了所有组件的默认配置信息
@ElModel(copyWith: true)
class ElConfigData {
  static ElConfigData data = ElConfigData();

  /// 全局默认图标大小
  double iconSize;

  /// 全局基础控件圆角值: button、input
  double radius;

  /// 全局卡片圆角值
  double cardRadius;

  /// 背景颜色全局过渡持续时间(毫秒)
  int bgColorTransition;

  /// 全局文本样式
  TextStyle textStyle;

  /// 按钮全局样式
  ElButtonStyle buttonStyle;

  /// 输入框全局样式
  ElInputStyle inputStyle;

  ElConfigData({
    this.iconSize = 18,
    this.radius = 4,
    this.cardRadius = 6,
    this.bgColorTransition = 100,
    this.textStyle = const TextStyle(fontSize: 15),
    this.buttonStyle = const ElButtonStyle(),
    this.inputStyle = const ElInputStyle(),
  });
}

/// Element UI 响应式配置
class ElResponsiveData {
  /// 特小号设备最大尺寸
  final double xs;

  /// 移动设备最大尺寸
  final double sm;

  /// 平板设备最大尺寸
  final double md;

  /// 桌面设备最大尺寸
  final double lg;

  /// 大屏桌面设备最大尺寸
  final double xl;

  const ElResponsiveData({
    this.xs = 320,
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });

  ElResponsiveData copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ElResponsiveData(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}

/// Element UI 字体排版配置
class ElTypographyData {
  /// 默认的字体排版配置
  static final data = ElTypographyData(
    h1: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    h2: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    h3: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    h4: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    h5: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    h6: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    text: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
  );

  /// 一级标题
  final TextStyle h1;

  /// 二级标题
  final TextStyle h2;

  /// 三级标题
  final TextStyle h3;

  /// 四级标题
  final TextStyle h4;

  /// 五级标题
  final TextStyle h5;

  /// 六级标题
  final TextStyle h6;

  /// 普通文本
  final TextStyle text;

  /// 超链接文本颜色，默认跟随主题色
  final Color? hrefColor;

  /// 超链接是否显示下划线
  final bool underline;

  /// 是否在鼠标悬停时显示下划线，默认false，若为true，[underline]将无效
  final bool hoverUnderline;

  ElTypographyData({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.text,
    this.hrefColor,
    this.underline = true,
    this.hoverUnderline = false,
  });

  ElTypographyData copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
    TextStyle? text,
    Color? hrefColor,
    bool? underline,
    bool? hoverUnderline,
  }) {
    return ElTypographyData(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      text: text ?? this.text,
      hrefColor: hrefColor ?? this.hrefColor,
      underline: underline ?? this.underline,
      hoverUnderline: hoverUnderline ?? this.hoverUnderline,
    );
  }

  /// 接受一个文本样式，将其应用于所有文本
  ElTypographyData merge(TextStyle style) {
    return mergeTitle(style)
      ..copyWith(
        text: text.merge(style),
      );
  }

  /// 接受一个文本样式，将其应用于所有标题
  ElTypographyData mergeTitle(TextStyle style) {
    return copyWith(
      h1: h1.merge(style),
      h2: h2.merge(style),
      h3: h3.merge(style),
      h4: h4.merge(style),
      h5: h5.merge(style),
      h6: h6.merge(style),
    );
  }
}
