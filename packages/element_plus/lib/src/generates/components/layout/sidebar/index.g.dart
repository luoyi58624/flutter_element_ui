// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/layout/sidebar/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSidebarThemeDataExtension on ElSidebarThemeData {
  /// 接收一组可选参数，返回新的对象
  ElSidebarThemeData copyWith({
    Color? color,
    double? width,
  }) {
    return ElSidebarThemeData(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElSidebarThemeData merge([ElSidebarThemeData? other]) {
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

class ElSidebarTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElSidebarTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElSidebarThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSidebarThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElSidebarTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSidebarThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.sidebarTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElSidebarTheme.of(context);
    return _ElSidebarTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElSidebarTheme extends InheritedWidget {
  const _ElSidebarTheme({
    required super.child,
    required this.data,
  });

  final ElSidebarThemeData data;

  @override
  bool updateShouldNotify(_ElSidebarTheme oldWidget) => true;
}
