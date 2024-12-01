import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class ObsTestPage extends StatelessWidget {
  const ObsTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...List.generate(
            100,
            (index) => Test(
              index: index,
            ),
          ),
        ],
      ),
    );
  }
}

class Test extends HookWidget {
  const Test({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final size = useAnimateObs(
      50.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 600),
    );

    final color = useAnimateObs(
      Colors.green,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 600),
      tween: ColorTween(),
    );
    final radius = useAnimateObs(
      8.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 600),
    );

    return ObsBuilder(
      builder: (context) {
        return Material(
          color: color.value,
          borderRadius: BorderRadius.circular(radius.value),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              if (size.targetValue == size.initialValue) {
                size.value = 100.0;
                radius.value = 16.0;
                color.value = Colors.red;
              } else {
                size.reset();
                radius.reset();
                color.reset();
              }
            },
            child: SizedBox(
              width: size.value,
              height: size.value,
              child: Center(child: ElText(size.value.toStringAsFixed(0))),
            ),
          ),
        );
      },
    );
  }
}
