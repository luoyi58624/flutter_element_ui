import 'package:example/global.dart';
import 'package:flutter/material.dart';

class SliderPage extends HookWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildSlider(
          (progress) => RepaintBoundary(child: ElSlider(progress)),
        ),
        buildSlider(
          (progress) => ObsBuilder(builder: (context) {
            return Slider(
              value: progress.value,
              max: 100,
              onChanged: (v) {
                progress.value = v;
              },
            );
          }),
        ),
      ],
    );
  }

  Widget buildSlider(Widget Function(Obs<double> progress) child) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ...List.generate(1000, (index) {
                final progress = Obs(30.0);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(child: child(progress)),
                      ObsBuilder(builder: (context) {
                        return Text((progress.value.floor()).toString());
                      }),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
