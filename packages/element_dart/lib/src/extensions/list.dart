import 'package:collection/collection.dart';

extension DartListExtension<E> on List<E> {
  /// 判断两个 List 是否相等
  bool eq(List other) {
    return const ListEquality().equals(this, other);
  }

  List<E> operator *(int num) {
    List<E> newList = [];
    for (int i = 0; i < num; i++) {
      newList.addAll(this);
    }
    return newList;
  }
}
