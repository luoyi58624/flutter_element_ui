// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonThemeDataExtension on ElButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElButtonThemeData copyWith({
    double? height,
    String? type,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElButtonThemeData(
      height: height ?? this.height,
      type: type ?? this.type,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElButtonThemeData merge([ElButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      type: other.type,
      borderRadius: other.borderRadius,
      padding: other.padding,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElButtonTheme extends InheritedWidget {
  const ElButtonTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.buttonTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElButtonThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElButtonTheme.of(context);
      return ElButtonTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => true;
}
