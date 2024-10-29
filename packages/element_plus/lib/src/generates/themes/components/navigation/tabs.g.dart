// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/navigation/tabs.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabsThemeDataExtension on ElTabsThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTabsThemeData copyWith({
    double? size,
    EdgeInsets? padding,
    double? itemGap,
    bool? enabledDrag,
    Duration? dragDelay,
    AxisDirection? direction,
  }) {
    return ElTabsThemeData(
      size: size ?? this.size,
      padding: padding ?? this.padding,
      itemGap: itemGap ?? this.itemGap,
      enabledDrag: enabledDrag ?? this.enabledDrag,
      dragDelay: dragDelay ?? this.dragDelay,
      direction: direction ?? this.direction,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTabsThemeData merge([ElTabsThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      padding: other.padding,
      itemGap: other.itemGap,
      enabledDrag: other.enabledDrag,
      dragDelay: other.dragDelay,
      direction: other.direction,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTabsTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElTabsTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTabsThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTabsThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTabsTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTabsThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.tabsTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTabsThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTabsTheme.of(context);
      return ElTabsTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTabsTheme oldWidget) => true;
}

extension ElTabsThemeDataLerpExtension on ElTabsThemeData {
  /// 主题动画线性插值
  ElTabsThemeData lerp(ElTabsThemeData a, ElTabsThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTabsThemeData(
      size: lerpDouble(a.size, b.size, t) ?? a.size,
      padding: EdgeInsets.lerp(a.padding, b.padding, t) ?? a.padding,
      itemGap: lerpDouble(a.itemGap, b.itemGap, t) ?? a.itemGap,
      enabledDrag: t < 0.5 ? a.enabledDrag : b.enabledDrag,
      dragDelay: t < 0.5 ? a.dragDelay : b.dragDelay,
      direction: t < 0.5 ? a.direction : b.direction,
    );
  }
}
