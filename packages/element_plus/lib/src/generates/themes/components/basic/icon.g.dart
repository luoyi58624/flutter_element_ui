// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/icon.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElIconThemeDataExtension on ElIconThemeData {
  /// 接收一组可选参数，返回新的对象
  ElIconThemeData copyWith({
    dynamic icon,
    double? size,
    Color? color,
  }) {
    return ElIconThemeData(
      icon: icon ?? this.icon,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElIconThemeData merge([ElIconThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      icon: other.icon,
      size: other.size,
      color: other.color,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElIconTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElIconTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElIconThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElIconThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElIconTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElIconThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.iconTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElIconThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElIconTheme.of(context);
      return ElIconTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElIconTheme oldWidget) => true;
}
