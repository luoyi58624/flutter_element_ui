import 'package:docs/global.dart';
import 'package:docs/utils/animate.dart';
import 'package:flutter/material.dart';

TickerProvider? parent;

void useLoadData() {
  useMounted(() async {
    ElLoading.show('加载数据中');
    await 1000.ms.delay();
    ElLoading.close();
    el.toast.show('加载完成');
  });
}

class QuickStartPage extends ResponsivePage {
  const QuickStartPage({super.key});

  @override
  String get title => '快速开始';

  @override
  List<Widget> buildPage(BuildContext context) {
    final flag = useState(true);
    final vsync = useSingleTickerProvider();
    parent = vsync;
    final controller = useAnimationController(
      duration: 500.ms,
      initialValue: flag.value ? 1 : 0,
      vsync: vsync,
    );
    final sizeAnimate = controller.createAnimate(
      tween: Tween(begin: 100.0, end: 200.0),
    );
    final borderAnimate = controller.createAnimate(
      tween: Tween(begin: 8.0, end: 32.0),
    );
    final colorAnimate = controller.createAnimate(
      tween: ColorTween(begin: Colors.green, end: Colors.red),
    );

    useLoadData();
    useMounted(() async {
      i('mounted, size: ${context.size}');
    });
    useWatch(flag, (newValue, oldValue) {
      if (newValue) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
    return [
      const Gap(8),
      ElSwitch(flag),
      const Gap(8),
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            width: sizeAnimate.value,
            height: sizeAnimate.value,
            decoration: BoxDecoration(
              color: colorAnimate.value,
              borderRadius: BorderRadius.circular(borderAnimate.value),
            ),
          );
        },
      ),
      // Slider(
      //   value: slider.value,
      //   label: '${slider.value}',
      //   divisions: 10,
      //   max: 1000,
      //   onChanged: (value) {
      //     slider.value = value;
      //   },
      // ),
      // ElevatedButton(
      //   onPressed: () {
      //     AnimationUtil.createNumTween(
      //       vsync: ticker,
      //       begin: 0,
      //       end: 100,
      //       milliseconds: slider.value.toInt(),
      //       callback: (value) {
      //         numList.value = [
      //           ...numList.value,
      //           value,
      //         ];
      //       },
      //     );
      //   },
      //   child: const Text('生成0-100的区间数字动画值'),
      // ),
      // ElevatedButton(
      //   onPressed: () {
      //     numList.value = [];
      //   },
      //   child: const Text('清除'),
      // ),
      // Column(
      //   children: [...numList.value.map((e) => Text('$e'))],
      // ),
    ];
  }
}
