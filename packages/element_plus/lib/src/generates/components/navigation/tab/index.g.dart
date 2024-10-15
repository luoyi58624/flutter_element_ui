// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/navigation/tab/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabThemeDataExtension on ElTabThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTabThemeData copyWith({
    double? size,
  }) {
    return ElTabThemeData(
      size: size ?? this.size,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTabThemeData merge([ElTabThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElTabTheme extends InheritedWidget {
  const ElTabTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTabThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTabThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTabTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTabThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.tabTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTabThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTabTheme.of(context);
      return ElTabTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTabTheme oldWidget) => true;
}