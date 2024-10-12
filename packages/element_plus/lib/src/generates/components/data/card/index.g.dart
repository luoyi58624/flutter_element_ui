// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/card/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCardThemeDataExtension on ElCardThemeData {
  ElCardThemeData copyWith({
    Color? color,
    double? elevation,
    BorderRadius? radius,
  }) {
    return ElCardThemeData(
      color: color ?? this.color,
      elevation: elevation ?? this.elevation,
      radius: radius ?? this.radius,
    );
  }

  ElCardThemeData merge([ElCardThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      elevation: other.elevation,
      radius: other.radius,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElCardTheme extends InheritedWidget {
  const ElCardTheme({super.key, required super.child, required this.data});

  final ElCardThemeData data;

  static ElCardThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElCardTheme>()?.data;
  }

  static ElCardThemeData of(BuildContext context, ElCardThemeData? data) {
    final result = maybeOf(context);
    assert(result != null, 'No ElCardTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElCardThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElCardTheme.maybeOf(context) ?? context.elTheme.cardTheme;
      return ElCardTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElCardTheme oldWidget) => true;
}
