import 'package:flutter/foundation.dart';

import '../global.dart';

Ref<T> ref<T>(T value) {
  return Ref(value);
}

class Ref<T> with ChangeNotifier {
  Ref(this._value);

  T _value;

  T get value => _value;

  set value(T newValue) {
    i(newValue);
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => value.toString();
}
