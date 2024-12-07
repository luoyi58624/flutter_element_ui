import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class ThrottleTestPage extends StatefulWidget {
  const ThrottleTestPage({super.key});

  @override
  State<ThrottleTestPage> createState() => _ThrottleTestPageState();
}

class _ThrottleTestPageState extends State<ThrottleTestPage> {
  final count = WatchObs(0);

  void printCount() {
    i(count.value);
  }

  @override
  void initState() {
    super.initState();
    final fun = DartUtil.debounce(printCount, 1000);
    count.addWatch((newValue, oldValue) {
      fun();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('节流测试'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ObsBuilder(builder: (context) {
              return ElButton(
                onPressed: DartUtil.throttle(() {
                  count.value++;
                }, 500, key: 'addCount'),
                type: El.primary,
                child: 'count: $count',
              );
            }),
          ],
        ),
      ),
    );
  }
}
