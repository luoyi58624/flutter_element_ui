// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/progress.dart';

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

class ElProgressTheme extends InheritedWidget {
  /// 设置局部默认数据，注意：如果你想尊重 "全局" 或 "祖先" 提供的默认样式，请使用 [merge] 方法构建
  const ElProgressTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElProgressThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElProgressThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElProgressTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElProgressThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.progressTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElProgressThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElProgressTheme.of(context);
      return ElProgressTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElProgressTheme oldWidget) => true;
}
