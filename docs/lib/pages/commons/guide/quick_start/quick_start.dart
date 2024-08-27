import 'package:docs/global.dart';
import 'package:docs/pages/commons/responsive_page.dart';
import 'package:docs/utils/animate.dart';
import 'package:flutter/material.dart';

TickerProvider? parent;

class QuickStartPage extends ResponsivePage {
  const QuickStartPage({super.key});

  @override
  String get title => '快速开始';

  @override
  List<Widget> buildPage(BuildContext context) {
    final numList = useState<List<double>>([]);
    final slider = useState(0.0);
    final flag = useState(true);
    final vsync = useSingleTickerProvider();
    if (parent != null) {
      i(vsync == parent);
    }
    parent = vsync;
    final controller = useAnimationController(
      duration: 1500.ms,
      initialValue: flag.value ? 1 : 0,
      vsync: vsync,
    );
    final sizeAnimate = controller.createAnimate(
      100.0,
      200.0,
      curve: Interval(0.1, 0.9,
          curve: flag.value
              ? Curves.fastEaseInToSlowEaseOut
              : Curves.fastEaseInToSlowEaseOut.flipped),
    );
    final borderAnimate = controller.createAnimate(
      8.0,
      32.0,
      curve: Interval(0.0, 1.0,
          curve: flag.value
              ? Curves.fastEaseInToSlowEaseOut
              : Curves.fastEaseInToSlowEaseOut.flipped),
    );

    useEffect(() {
      if (flag.value) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return null;
    }, [flag.value]);
    return [
      ElSwitch(flag),
      const Gap(8),
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            width: sizeAnimate.value,
            height: sizeAnimate.value,
            decoration: BoxDecoration(
              color: Colors.green,
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
