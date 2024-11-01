// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/card.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCardThemeDataExtension on ElCardThemeData {
  /// 接收一组可选参数，返回新的对象
  ElCardThemeData copyWith({
    Color? color,
    double? elevation,
    BorderRadius? radius,
  }) {
    return ElCardThemeData(
      color: color ?? this.color,
      elevation: elevation ?? this.elevation,
      radius: radius ?? this.radius,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElCardThemeData merge([ElCardThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      elevation: other.elevation,
      radius: other.radius,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElCardTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElCardTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElCardThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCardThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElCardTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCardThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.cardTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElCardTheme.of(context);
    return _ElCardTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElCardTheme extends InheritedWidget {
  const _ElCardTheme({
    required super.child,
    required this.data,
  });

  final ElCardThemeData data;

  @override
  bool updateShouldNotify(_ElCardTheme oldWidget) => true;
}
