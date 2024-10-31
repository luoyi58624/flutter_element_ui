// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/progress.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElProgressThemeDataExtension on ElProgressThemeData {
  /// 接收一组可选参数，返回新的对象
  ElProgressThemeData copyWith({
    Duration? duration,
    Curve? curve,
    Curve? secondCurve,
  }) {
    return ElProgressThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      secondCurve: secondCurve ?? this.secondCurve,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElProgressThemeData merge([ElProgressThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
      secondCurve: other.secondCurve,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElProgressTheme extends StatelessWidget {
  const ElProgressTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElProgressThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElProgressThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElProgressTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElProgressThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.progressTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElProgressTheme.of(context);
    return _ElProgressTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElProgressTheme extends InheritedWidget {
  const _ElProgressTheme({
    required super.child,
    required this.data,
  });

  final ElProgressThemeData data;

  @override
  bool updateShouldNotify(_ElProgressTheme oldWidget) => true;
}

extension ElProgressThemeDataLerpExtension on ElProgressThemeData {
  /// 主题动画线性插值
  ElProgressThemeData lerp(
      ElProgressThemeData a, ElProgressThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElProgressThemeData(
      duration: t < 0.5 ? a.duration : b.duration,
      curve: t < 0.5 ? a.curve : b.curve,
      secondCurve: t < 0.5 ? a.secondCurve : b.secondCurve,
    );
  }
}
