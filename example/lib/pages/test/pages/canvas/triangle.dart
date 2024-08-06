import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TrianglePage extends HookWidget {
  const TrianglePage({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = useState(0.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制三角形 - triangle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Slider(
              value: radius.value,
              max: 100,
              onChanged: (v) => radius.value = v,
              label: radius.value.round().toString(),
            ),
            Row(
              children: [
                ...AxisDirection.values.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElTriangle(
                      size: 20,
                      radius: radius.value,
                      direction: e,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                ...AxisDirection.values.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElTriangle(
                      size: 100,
                      radius: radius.value,
                      direction: e,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                ...AxisDirection.values.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElTriangle(
                      size: 100,
                      radius: radius.value,
                      direction: e,
                      onlyRightAngle: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
