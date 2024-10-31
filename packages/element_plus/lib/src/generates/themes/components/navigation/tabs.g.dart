// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/navigation/tabs.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabsThemeDataExtension on ElTabsThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTabsThemeData copyWith({
    Widget Function(BuildContext, Widget)? builderWrapper,
    Widget Function(BuildContext, ScrollController, Widget)? builderScrollbar,
    double? size,
    AxisDirection? direction,
    Color? bgColor,
    Color? hoverBgColor,
    Color? activeBgColor,
    Color? textColor,
    Color? hoverTextColor,
    Color? activeTextColor,
    EdgeInsets? padding,
    double? itemGap,
    bool? enabledDrag,
    Duration? dragDelay,
    double? autoScrollerVelocityScalar,
    Widget Function(Widget, int, Animation<double>)? dragProxyDecorator,
  }) {
    return ElTabsThemeData(
      builderWrapper: builderWrapper ?? this.builderWrapper,
      builderScrollbar: builderScrollbar ?? this.builderScrollbar,
      size: size ?? this.size,
      direction: direction ?? this.direction,
      bgColor: bgColor ?? this.bgColor,
      hoverBgColor: hoverBgColor ?? this.hoverBgColor,
      activeBgColor: activeBgColor ?? this.activeBgColor,
      textColor: textColor ?? this.textColor,
      hoverTextColor: hoverTextColor ?? this.hoverTextColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      padding: padding ?? this.padding,
      itemGap: itemGap ?? this.itemGap,
      enabledDrag: enabledDrag ?? this.enabledDrag,
      dragDelay: dragDelay ?? this.dragDelay,
      autoScrollerVelocityScalar:
          autoScrollerVelocityScalar ?? this.autoScrollerVelocityScalar,
      dragProxyDecorator: dragProxyDecorator ?? this.dragProxyDecorator,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTabsThemeData merge([ElTabsThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      builderWrapper: other.builderWrapper,
      builderScrollbar: other.builderScrollbar,
      size: other.size,
      direction: other.direction,
      bgColor: other.bgColor,
      hoverBgColor: other.hoverBgColor,
      activeBgColor: other.activeBgColor,
      textColor: other.textColor,
      hoverTextColor: other.hoverTextColor,
      activeTextColor: other.activeTextColor,
      padding: other.padding,
      itemGap: other.itemGap,
      enabledDrag: other.enabledDrag,
      dragDelay: other.dragDelay,
      autoScrollerVelocityScalar: other.autoScrollerVelocityScalar,
      dragProxyDecorator: other.dragProxyDecorator,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElTabsThemeDataLerpExtension on ElTabsThemeData {
  /// 默认主题动画线性插值
  ElTabsThemeData lerp(ElTabsThemeData a, ElTabsThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTabsThemeData(
      builderWrapper: t < 0.5 ? a.builderWrapper : b.builderWrapper,
      builderScrollbar: t < 0.5 ? a.builderScrollbar : b.builderScrollbar,
      size: lerpDouble(a.size, b.size, t) ?? a.size,
      direction: t < 0.5 ? a.direction : b.direction,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      hoverBgColor:
          Color.lerp(a.hoverBgColor, b.hoverBgColor, t) ?? a.hoverBgColor,
      activeBgColor:
          Color.lerp(a.activeBgColor, b.activeBgColor, t) ?? a.activeBgColor,
      textColor: Color.lerp(a.textColor, b.textColor, t) ?? a.textColor,
      hoverTextColor:
          Color.lerp(a.hoverTextColor, b.hoverTextColor, t) ?? a.hoverTextColor,
      activeTextColor: Color.lerp(a.activeTextColor, b.activeTextColor, t) ??
          a.activeTextColor,
      padding: EdgeInsets.lerp(a.padding, b.padding, t) ?? a.padding,
      itemGap: lerpDouble(a.itemGap, b.itemGap, t) ?? a.itemGap,
      enabledDrag: t < 0.5 ? a.enabledDrag : b.enabledDrag,
      dragDelay: t < 0.5 ? a.dragDelay : b.dragDelay,
      autoScrollerVelocityScalar: lerpDouble(
              a.autoScrollerVelocityScalar, b.autoScrollerVelocityScalar, t) ??
          a.autoScrollerVelocityScalar,
      dragProxyDecorator: t < 0.5 ? a.dragProxyDecorator : b.dragProxyDecorator,
    );
  }
}

class ElTabsTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElTabsTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElTabsThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTabsThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTabsTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTabsThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.tabsTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElTabsTheme.of(context);
    return _ElTabsTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElTabsTheme extends InheritedWidget {
  const _ElTabsTheme({
    required super.child,
    required this.data,
  });

  final ElTabsThemeData data;

  @override
  bool updateShouldNotify(_ElTabsTheme oldWidget) => true;
}
