// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/link.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElLinkThemeDataExtension on ElLinkThemeData {
  /// 接收一组可选参数，返回新的对象
  ElLinkThemeData copyWith({
    Color? color,
    Color? activeColor,
    ElLinkDecoration? decoration,
    bool? allowDrag,
  }) {
    return ElLinkThemeData(
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      decoration: decoration ?? this.decoration,
      allowDrag: allowDrag ?? this.allowDrag,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElLinkThemeData merge([ElLinkThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      activeColor: other.activeColor,
      decoration: other.decoration,
      allowDrag: other.allowDrag,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElLinkTheme extends StatelessWidget {
  const ElLinkTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElLinkThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElLinkThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElLinkTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElLinkThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.linkTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElLinkTheme.of(context);
    return _ElLinkTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElLinkTheme extends InheritedWidget {
  const _ElLinkTheme({
    required super.child,
    required this.data,
  });

  final ElLinkThemeData data;

  @override
  bool updateShouldNotify(_ElLinkTheme oldWidget) => true;
}

extension ElLinkThemeDataLerpExtension on ElLinkThemeData {
  /// 主题动画线性插值
  ElLinkThemeData lerp(ElLinkThemeData a, ElLinkThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElLinkThemeData(
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      activeColor: Color.lerp(a.activeColor, b.activeColor, t) ?? a.activeColor,
      decoration: t < 0.5 ? a.decoration : b.decoration,
      allowDrag: t < 0.5 ? a.allowDrag : b.allowDrag,
    );
  }
}
