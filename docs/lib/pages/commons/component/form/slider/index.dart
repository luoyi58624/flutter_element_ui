import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class SliderPage extends ResponsivePage {
  const SliderPage({super.key});

  @override
  String get title => 'Slider 滑块';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      ElButton(
        onPressed: () {
          context.push(const _ElSliderPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('ElSlider性能测试'),
      ),
      const Example1(title: '基础使用'),
    ];
  }
}

class _ElSliderPage extends HookWidget {
  const _ElSliderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElSlider性能测试'),
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                child: Column(
                  children: List.generate(
                      500,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Row(
                              children: [
                                ElText('${index + 1}'),
                                const Gap(8),
                                const Expanded(child: _ElSlider()),
                              ],
                            ),
                          )),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  500,
                  (index) => Row(
                    children: [
                      ElText('${index + 1}'),
                      const Gap(8),
                      const Expanded(
                        child: _Slider(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ElSlider extends HookWidget {
  const _ElSlider();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    return ElSlider(progress);
  }
}

class _Slider extends HookWidget {
  const _Slider();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    return Slider(
      value: progress.value,
      onChanged: (v) => progress.value = v,
    );
  }
}
