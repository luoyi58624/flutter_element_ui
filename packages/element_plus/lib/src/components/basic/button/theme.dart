import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part '../../../generates/components/basic/button/theme.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '默认按钮默认样式')
class ElButtonThemeData {
  static const theme = ElButtonThemeData();
  static const darkTheme = ElButtonThemeData();

  const ElButtonThemeData({
    this.duration,
    this.curve,
    this.type,
    this.bgColor,
    this.width,
    this.height,
    this.leftIcon,
    this.rightIcon,
    this.round,
    this.padding,
    this.iconSize,
    this.block,
    this.loadingWidget,
    this.loadingBuilder,
  });

  final Duration? duration;
  final Curve? curve;
  final String? type;
  final Color? bgColor;
  final double? width;
  final double? height;
  final double? iconSize;
  final bool? block;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool? round;
  final EdgeInsets? padding;
  final Widget? loadingWidget;
  final WidgetBuilder? loadingBuilder;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@ElModel.copy()
@ElThemeModel(desc: '边框按钮默认样式')
class ElOutlineButtonThemeData extends ElButtonThemeData {
  static const theme = ElOutlineButtonThemeData();
  static const darkTheme = ElOutlineButtonThemeData();

  const ElOutlineButtonThemeData({
    this.plain,
    this.onlyActiveBorder,
    this.borderWidth,
    super.duration,
    super.curve,
    super.type,
    super.bgColor,
    super.width,
    super.height,
    super.iconSize,
    super.block,
    super.round,
    super.padding,
    super.leftIcon,
    super.rightIcon,
    super.loadingWidget,
    super.loadingBuilder,
  });

  final bool? plain;
  final bool? onlyActiveBorder;
  final double? borderWidth;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@ElModel.copy()
@ElThemeModel(desc: '文字按钮默认样式')
class ElTextButtonThemeData extends ElButtonThemeData {
  static const theme = ElTextButtonThemeData();
  static const darkTheme = ElTextButtonThemeData();

  const ElTextButtonThemeData({
    this.color,
    this.bg,
    this.iconScale,
    super.duration,
    super.curve,
    super.type,
    super.round,
    super.padding,
    super.leftIcon,
    super.rightIcon,
    super.loadingWidget,
    super.loadingBuilder,
  });

  final Color? color;
  final bool? bg;
  final double? iconScale;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@ElModel.copy()
@ElThemeModel(desc: '链接按钮默认样式')
class ElLinkButtonThemeData extends ElTextButtonThemeData {
  static const theme = ElLinkButtonThemeData();
  static const darkTheme = ElLinkButtonThemeData();

  const ElLinkButtonThemeData({
    super.duration,
    super.curve,
    super.type,
    super.color,
    super.loadingBuilder,
  });

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
