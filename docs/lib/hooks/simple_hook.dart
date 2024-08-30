import 'package:decimal/decimal.dart';
import 'package:docs/global.dart';

/// 简单的计数器 Hook
(int, void Function()) useCount() {
  final count = useState(0.0);

  // hook小提示：在短时间内多次更新响应式变量页面是不会重复build的
  void addCount() {
    for (int i = 0; i < 100; i++) {
      count.value =
          (Decimal.parse(count.value.toString()) + Decimal.parse('0.01'))
              .toDouble();
    }
  }

  return (count.value.toInt(), addCount);
}

/// 开关 Hook
(bool, void Function([bool? value])) useToggle([bool? initialValue]) {
  final flag = useState(initialValue ?? false);
  void toggle([bool? value]) => flag.value = value ?? !flag.value;
  return (flag.value, toggle);
}
