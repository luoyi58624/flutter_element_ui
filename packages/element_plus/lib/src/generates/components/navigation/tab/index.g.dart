// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/navigation/tab/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabThemeDataExtension on ElTabThemeData {
  ElTabThemeData copyWith({
    double? size,
  }) {
    return ElTabThemeData(
      size: size ?? this.size,
    );
  }

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

  final ElTabThemeData data;

  static ElTabThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElTabTheme>()?.data;
  }

  static ElTabThemeData of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No ElTabTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElTabThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTabTheme.maybeOf(context) ?? context.elTheme.tabTheme;
      return ElTabTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTabTheme oldWidget) => true;
}
