import 'package:flutter/material.dart';

import '../global.dart';

class AnimateValueGeneratePage extends HookWidget {
  const AnimateValueGeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> numList = [];
    final inputValue = useState('100');
    final duration = useState(1000.0);
    final controller = useAnimationController(
      duration: (duration.value).toInt().ms,
    );
    final animate = Tween(
      begin: 0.0,
      end: double.parse(inputValue.value),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ));

    return SingleChildScrollView(
      child: Column(
        children: [
          Slider(
            min: 100,
            max: 1000,
            divisions: 9,
            label: duration.value.round().toString(),
            value: duration.value,
            onChanged: (v) => duration.value = v,
          ),
          Row(
            children: [
              Expanded(child: ElInput(inputValue)),
              const Gap(8),
              ElButton(
                onPressed: () {
                  numList = [];
                  controller.forward(from: 0);
                },
                child: '生成',
                type: El.primary,
              ),
            ],
          ),
          AnimatedBuilder(
            animation: controller.view,
            builder: (context, child) {
              numList.add(animate.value);
              return Column(
                children: [
                  ElText('生成的值数量：${numList.length - 1}'),
                  ...numList.map(
                    (e) => ElText(e),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
