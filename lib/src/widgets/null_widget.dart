import 'package:flutter/widgets.dart';

class ElNullWidget extends StatelessWidget {
  const ElNullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'ElNullWidget 通常用于混入 build 方法，子类如果没有执行 super.build 函数将抛出此异常',
    );
  }
}
