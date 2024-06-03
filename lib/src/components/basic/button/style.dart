part of flutter_element_ui;

class ElButtonTheme extends InheritedWidget {
  const ElButtonTheme({
    super.key,
    required super.child,
    required this.style,
  });

  final ElButtonStyle style;

  static ElButtonTheme of(BuildContext context) {
    final ElButtonTheme? result = context.dependOnInheritedWidgetOfExactType<ElButtonTheme>();
    assert(result != null, 'No ElButtonTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => true;
}

/// 按钮样式
class ElButtonStyle {
  /// 主题类型
  final ElThemeType? type;

  /// 文字按钮
  final bool? text;

  /// 镂空按钮
  final bool? plain;

  /// 圆角按钮
  final bool? round;

  /// 块级按钮，宽度会充满容器
  final bool? block;

  /// 按钮右图标，当按钮 child 为 String 类型时生效
  final ElIcon? rightIcon;

  /// 圆形图标按钮，仅图标按钮生效
  final bool? circle;

  /// 禁用按钮
  final bool? disabled;

  ElButtonStyle({
    this.type,
    this.text,
    this.plain,
    this.round,
    this.block,
    this.rightIcon,
    this.circle,
    this.disabled,
  });
}
