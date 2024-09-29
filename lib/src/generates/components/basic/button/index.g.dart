// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/button/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonThemeDataExtension on ElButtonThemeData {
  ElButtonThemeData copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElButtonThemeData(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  ElButtonThemeData merge([ElButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      padding: other.padding,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElButtonTheme extends InheritedWidget {
  const ElButtonTheme({super.key, required super.child, required this.data});

  final ElButtonThemeData data;

  static ElButtonThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.data;
  }

  static ElButtonThemeData of(BuildContext context, ElButtonThemeData? data) {
    final result = maybeOf(context);
    assert(result != null, 'No ElButtonTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElButtonThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent =
          ElButtonTheme.maybeOf(context) ?? context.elTheme.buttonTheme;
      return ElButtonTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => true;
}
