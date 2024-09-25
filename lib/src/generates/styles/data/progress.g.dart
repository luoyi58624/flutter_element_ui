// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/data/progress.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElProgressDataExtension on ElProgressData {
  ElProgressData copyWith({
    Duration? duration,
    Curve? curve,
    Curve? secondCurve,
  }) {
    return ElProgressData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      secondCurve: secondCurve ?? this.secondCurve,
    );
  }

  ElProgressData merge([ElProgressData? other]) {
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

  final ElProgressData data;

  static ElProgressData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElProgressTheme>()?.data;
  }

  static ElProgressData of(BuildContext context, ElProgressData? data) {
    final result = maybeOf(context);
    assert(result != null, 'No ElProgressTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElProgressData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElProgressTheme.maybeOf(context) ?? const ElProgressData();
      return ElProgressTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElProgressTheme oldWidget) => true;
}
