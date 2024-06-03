part of flutter_element_ui;

/// 按钮局部默认样式
class ElButtonTheme extends InheritedWidget {
  const ElButtonTheme({
    super.key,
    required super.child,
    required this.style,
  });

  final ElButtonStyle style;

  static ElButtonStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.style;

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => true;
}

/// 按钮样式
class ElButtonStyle {
  /// 默认按钮样式
  static const ElButtonStyle style = ElButtonStyle(
    height: 36,
    type: null,
    text: false,
    plain: false,
    round: false,
    block: false,
    radius: null,
    rightIcon: null,
    circle: false,
    disabled: false,
  );

  /// 按钮高度，默认36
  final double? height;

  /// 主题类型，默认null
  final ElThemeType? type;

  /// 文字按钮，默认false
  final bool? text;

  /// 镂空按钮，默认false
  final bool? plain;

  /// 圆角按钮，默认false
  final bool? round;

  /// 块级按钮，宽度会充满容器，默认false
  final bool? block;

  /// 自定义按钮圆角，如果[round]为true，则渲染圆角按钮，否则按钮默认圆角为 4 像素
  final BorderRadiusGeometry? radius;

  /// 按钮右图标，默认null
  final ElIcon? rightIcon;

  /// 圆形图标按钮，当child为[ElIcon]时生效，默认false
  final bool? circle;

  /// 禁用按钮，默认false
  final bool? disabled;

  /// 自定义按钮样式，创建的样式会基于默认的[style]进行合并
  const ElButtonStyle({
    this.height,
    this.type,
    this.text,
    this.plain,
    this.round,
    this.block,
    this.radius,
    this.rightIcon,
    this.circle,
    this.disabled,
  });

  ElButtonStyle copyWith({
    double? height,
    ElThemeType? type,
    bool? text,
    bool? plain,
    bool? round,
    bool? block,
    BorderRadiusGeometry? radius,
    ElIcon? rightIcon,
    bool? circle,
    bool? disabled,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      type: type ?? this.type,
      text: text ?? this.text,
      plain: plain ?? this.plain,
      round: round ?? this.round,
      block: block ?? this.block,
      radius: radius ?? this.radius,
      rightIcon: rightIcon ?? this.rightIcon,
      circle: circle ?? this.circle,
      disabled: disabled ?? this.disabled,
    );
  }

  ElButtonStyle merge([ElButtonStyle? style]) {
    return ElButtonStyle(
      height: style?.height ?? height,
      type: style?.type ?? type,
      text: style?.text ?? text,
      plain: style?.plain ?? plain,
      round: style?.round ?? round,
      block: style?.block ?? block,
      radius: style?.radius ?? radius,
      rightIcon: style?.rightIcon ?? rightIcon,
      circle: style?.circle ?? circle,
      disabled: style?.disabled ?? disabled,
    );
  }

  @override
  String toString() {
    return 'ElButtonStyle{height: $height, type: $type, text: $text, plain: $plain, round: $round, block: $block, radius: $radius, rightIcon: $rightIcon, circle: $circle, disabled: $disabled}';
  }
}
