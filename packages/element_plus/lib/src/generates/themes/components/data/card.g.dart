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

class ElCardTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElCardTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElCardThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCardThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElCardTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCardThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.cardTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElCardThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElCardTheme.of(context);
      return ElCardTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElCardTheme oldWidget) => true;
}
