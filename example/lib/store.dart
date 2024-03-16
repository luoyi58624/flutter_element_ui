import 'package:flutter/widgets.dart';

class GlobalStore {
  static final ValueNotifier<String> activePath = ValueNotifier<String>('/');
  static final ValueNotifier<int> counter = ValueNotifier<int>(0);
}
