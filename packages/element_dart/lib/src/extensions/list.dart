import 'package:collection/collection.dart';

extension DartListExtension on List {
  /// 判断两个 List 是否相等
  bool eq(List other) {
    return const ListEquality().equals(this, other);
  }
}
