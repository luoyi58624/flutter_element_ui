// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/progress/index.dart';

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
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
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

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElProgressThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.progressTheme;

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
