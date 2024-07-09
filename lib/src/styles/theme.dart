import 'dart:ui';

import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'basic/input.dart';

part '../generates/styles/theme.g.dart';

/// Element UI 主题对象
@ElModel(copyWith: true)
class ElBrightnessData {
  static ElBrightnessData lightTheme = ElBrightnessData();
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
  static ElConfigData config = ElConfigData();

  /// 全局默认文字大小
  double fonSize;

  /// 全局默认图标大小，仅限[ElIcon]
  double iconSize;

  /// 全局基础控件圆角值: button、input
  double radius;

  /// 全局卡片圆角值
  double cardRadius;

  /// 背景颜色全局过渡持续时间(毫秒)
  int bgColorTransition;

  /// 按钮全局样式
  ElButtonStyle buttonStyle;

  /// 输入框全局样式
  ElInputStyle inputStyle;

  ElConfigData({
    this.fonSize = 14,
    this.iconSize = 20,
    this.radius = 4,
    this.cardRadius = 6,
    this.bgColorTransition = 100,
    this.buttonStyle = const ElButtonStyle(),
    this.inputStyle = const ElInputStyle(),
  });
}

class ElResponsiveData {
  /// 特小号手机最大尺寸
  final double xs;

  /// 手机最大尺寸
  final double sm;

  /// 平板最大尺寸
  final double md;

  /// 桌面最大尺寸
  final double lg;

  /// 大屏桌面最大尺寸
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
