import 'package:collection/collection.dart';

extension DartSetExtension on Set {
  /// 判断两个 Set 是否相等
  bool eq(Set other) {
    return const SetEquality().equals(this, other);
  }
}
