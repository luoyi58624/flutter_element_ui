import 'package:collection/collection.dart';

extension DartListExtension<T> on List<T> {
  /// 判断两个 List 是否相等
  bool eq(List other) {
    return const ListEquality().equals(this, other);
  }

  List<T> operator *(int num) {
    List<T> newList = [];
    for (int i = 0; i < num; i++) {
      newList.addAll(this);
    }
    return newList;
  }
}
