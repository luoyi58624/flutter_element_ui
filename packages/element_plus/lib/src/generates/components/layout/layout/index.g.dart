// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/layout/layout/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElLayoutThemeDataExtension on ElLayoutThemeData {
  /// 接收一组可选参数，返回新的对象
  ElLayoutThemeData copyWith({
    Color? bgColor,
    Color? navbarColor,
    Color? sidebarColor,
    Color? borderColor,
  }) {
    return ElLayoutThemeData(
      bgColor: bgColor ?? this.bgColor,
      navbarColor: navbarColor ?? this.navbarColor,
      sidebarColor: sidebarColor ?? this.sidebarColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElLayoutThemeData merge([ElLayoutThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      bgColor: other.bgColor,
      navbarColor: other.navbarColor,
      sidebarColor: other.sidebarColor,
      borderColor: other.borderColor,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElLayoutTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElLayoutTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElLayoutThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElLayoutThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElLayoutTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElLayoutThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.layoutTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElLayoutTheme.of(context);
    return _ElLayoutTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElLayoutTheme extends InheritedWidget {
  const _ElLayoutTheme({
    required super.child,
    required this.data,
  });

  final ElLayoutThemeData data;

  @override
  bool updateShouldNotify(_ElLayoutTheme oldWidget) => true;
}
