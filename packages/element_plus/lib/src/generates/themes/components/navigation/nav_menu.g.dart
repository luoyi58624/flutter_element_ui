// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/navigation/nav_menu.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElNavMenuThemeDataExtension on ElNavMenuThemeData {
  /// 接收一组可选参数，返回新的对象
  ElNavMenuThemeData copyWith({
    Color? activeTextColor,
  }) {
    return ElNavMenuThemeData(
      activeTextColor: activeTextColor ?? this.activeTextColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElNavMenuThemeData merge([ElNavMenuThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      activeTextColor: other.activeTextColor,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElNavMenuThemeDataLerpExtension on ElNavMenuThemeData {
  /// 默认主题动画线性插值
  ElNavMenuThemeData lerp(
      ElNavMenuThemeData a, ElNavMenuThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElNavMenuThemeData(
      activeTextColor: Color.lerp(a.activeTextColor, b.activeTextColor, t) ??
          a.activeTextColor,
    );
  }
}

class ElNavMenuTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElNavMenuTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElNavMenuThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElNavMenuThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElNavMenuTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElNavMenuThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.navMenuTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElNavMenuTheme.of(context);
    return _ElNavMenuTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElNavMenuTheme extends InheritedWidget {
  const _ElNavMenuTheme({
    required super.child,
    required this.data,
  });

  final ElNavMenuThemeData data;

  @override
  bool updateShouldNotify(_ElNavMenuTheme oldWidget) => true;
}
