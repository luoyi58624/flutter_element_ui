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

class ElLinkTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElLinkTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElLinkThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElLinkThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElLinkTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElLinkThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.linkTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElLinkThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElLinkTheme.of(context);
      return ElLinkTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElLinkTheme oldWidget) => true;
}
