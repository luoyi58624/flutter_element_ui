// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/collapse/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCollapseThemeDataExtension on ElCollapseThemeData {
  /// 接收一组可选参数，返回新的对象
  ElCollapseThemeData copyWith({
    bool? keepState,
    Duration? duration,
    Curve? curve,
  }) {
    return ElCollapseThemeData(
      keepState: keepState ?? this.keepState,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElCollapseThemeData merge([ElCollapseThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      keepState: other.keepState,
      duration: other.duration,
      curve: other.curve,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElCollapseTheme extends InheritedWidget {
  const ElCollapseTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElCollapseThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCollapseThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElCollapseTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCollapseThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.collapseTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElCollapseThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElCollapseTheme.of(context);
      return ElCollapseTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElCollapseTheme oldWidget) => true;
}
