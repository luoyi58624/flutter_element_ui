// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/navigation/tab.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabThemeDataExtension on ElTabThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTabThemeData copyWith({
    double? size,
  }) {
    return ElTabThemeData(
      size: size ?? this.size,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTabThemeData merge([ElTabThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTabTheme extends StatelessWidget {
  const ElTabTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElTabThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTabThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTabTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElTabThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.tabTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElTabTheme.of(context);
    return _ElTabTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElTabTheme extends InheritedWidget {
  const _ElTabTheme({
    required super.child,
    required this.data,
  });

  final ElTabThemeData data;

  @override
  bool updateShouldNotify(_ElTabTheme oldWidget) => true;
}

extension ElTabThemeDataLerpExtension on ElTabThemeData {
  /// 主题动画线性插值
  ElTabThemeData lerp(ElTabThemeData a, ElTabThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTabThemeData(
      size: lerpDouble(a.size, b.size, t) ?? a.size,
    );
  }
}
