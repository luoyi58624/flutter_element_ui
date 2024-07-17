import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final direction = useState(AxisDirection.up);
    final slider = useState(20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          if (context.sm)
            ObsBuilder(builder: (context) {
              return Switch(
                value: GlobalState.isDark.value,
                onChanged: (v) => GlobalState.isDark.value = v,
              );
            }),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElSlider2(
            value: slider.value,
            onChanged: (v) => slider.value = v,
          ),
          // ElButton(
          //   onPressed: () {
          //     switch (direction.value) {
          //       case AxisDirection.up:
          //         direction.value = AxisDirection.right;
          //         break;
          //       case AxisDirection.right:
          //         direction.value = AxisDirection.down;
          //         break;
          //       case AxisDirection.down:
          //         direction.value = AxisDirection.left;
          //         break;
          //       case AxisDirection.left:
          //         direction.value = AxisDirection.up;
          //         break;
          //     }
          //   },
          //   child: '${direction.value}',
          // ),
          // const Gap(16),
          // ElTriangle(
          //   direction: direction.value,
          // ),
        ],
      ),
    );
  }
}
