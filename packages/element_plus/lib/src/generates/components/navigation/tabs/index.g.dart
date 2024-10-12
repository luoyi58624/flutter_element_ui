// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/navigation/tabs/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabsThemeDataExtension on ElTabsThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTabsThemeData copyWith({
    double? size,
  }) {
    return ElTabsThemeData(
      size: size ?? this.size,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTabsThemeData merge([ElTabsThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElTabsTheme extends InheritedWidget {
  const ElTabsTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTabsThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTabsThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTabsTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTabsThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.tabsTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTabsThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTabsTheme.of(context);
      return ElTabsTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTabsTheme oldWidget) => true;
}