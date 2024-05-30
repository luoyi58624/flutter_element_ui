import 'package:example/global.dart';

/// 简单的计数器 Hook
(int, void Function()) useCount() {
  final count = useState(0);
  void addCount() => count.value++;
  return (count.value, addCount);
}

/// 开关 Hook
(bool, void Function([bool? value])) useToggle() {
  final flag = useState(false);
  void toggle([bool? value]) => flag.value = value ?? !flag.value;
  return (flag.value, toggle);
}
