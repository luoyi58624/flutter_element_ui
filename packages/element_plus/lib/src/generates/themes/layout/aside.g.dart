// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/aside.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElAsideThemeDataExtension on ElAsideThemeData {
  /// 接收一组可选参数，返回新的对象
  ElAsideThemeData copyWith({
    Color? color,
    double? width,
  }) {
    return ElAsideThemeData(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElAsideThemeData merge([ElAsideThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      width: other.width,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElAsideTheme extends StatelessWidget {
  const ElAsideTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElAsideThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElAsideThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElAsideTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElAsideThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.asideTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElAsideTheme.of(context);
    return _ElAsideTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElAsideTheme extends InheritedWidget {
  const _ElAsideTheme({
    required super.child,
    required this.data,
  });

  final ElAsideThemeData data;

  @override
  bool updateShouldNotify(_ElAsideTheme oldWidget) => true;
}

extension ElAsideThemeDataLerpExtension on ElAsideThemeData {
  /// 主题动画线性插值
  ElAsideThemeData lerp(ElAsideThemeData a, ElAsideThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElAsideThemeData(
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      width: lerpDouble(a.width, b.width, t) ?? a.width,
    );
  }
}
