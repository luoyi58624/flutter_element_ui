// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/navigation/nav_menu.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElNavMenuThemeDataExtension on ElNavMenuThemeData {
  /// 接收一组可选参数，返回新的对象
  ElNavMenuThemeData copyWith({
    Color? activeTextColor,
  }) {
    return ElNavMenuThemeData(
      activeTextColor: activeTextColor ?? this.activeTextColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElNavMenuThemeData merge([ElNavMenuThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      activeTextColor: other.activeTextColor,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElNavMenuTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElNavMenuTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElNavMenuThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElNavMenuThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElNavMenuTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElNavMenuThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.navMenuTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElNavMenuThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElNavMenuTheme.of(context);
      return ElNavMenuTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElNavMenuTheme oldWidget) => true;
}

extension ElNavMenuThemeDataLerpExtension on ElNavMenuThemeData {
  ElNavMenuThemeData lerp(
      ElNavMenuThemeData a, ElNavMenuThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElNavMenuThemeData(
      activeTextColor: Color.lerp(a.activeTextColor, b.activeTextColor, t) ??
          a.activeTextColor,
    );
  }
}
