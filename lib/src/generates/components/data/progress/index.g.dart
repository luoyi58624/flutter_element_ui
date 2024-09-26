// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/progress/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElProgressThemeDataExtension on ElProgressThemeData {
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

  ElProgressThemeData merge([ElProgressThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
      secondCurve: other.secondCurve,
    );
  }
}

class ElProgressTheme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ElProgressTheme({super.key, required super.child, required this.data});

  final ElProgressThemeData data;

  static ElProgressThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElProgressTheme>()?.data;
  }

  static ElProgressThemeData of(
      BuildContext context, ElProgressThemeData? data) {
    final result = maybeOf(context);
    assert(result != null, 'No ElProgressTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElProgressThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent =
          ElProgressTheme.maybeOf(context) ?? context.elTheme.progressTheme;
      return ElProgressTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElProgressTheme oldWidget) => true;
}
