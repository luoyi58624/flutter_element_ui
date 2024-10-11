import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class SliderPage extends ResponsivePage {
  const SliderPage({super.key});

  @override
  String get title => 'Slider 滑块';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      textGap,
      ElButton(
        onPressed: () {
          context.push(const _ElSliderPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('ElSlider性能测试'),
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '设置最大值、最小值'),
    ];
  }
}

class _ElSliderPage extends HookWidget {
  const _ElSliderPage();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElSlider性能测试'),
        actions: [
          ElText(flag.value ? '虚拟滚动' : '普通滚动'),
          const Gap(8),
          Switch(
            value: flag.value,
            onChanged: (v) => flag.value = v,
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: flag.value
                ? ListView.builder(
                itemCount: 1000,
                itemBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Row(
                        children: [
                          ElText('${index + 1}'),
                          const Gap(8),
                          const Expanded(child: _ElSlider()),
                        ],
                      ),
                    ))
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                child: Column(
                  children: List.generate(
                      100,
                          (index) =>
                          Padding(
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
            child: flag.value
                ? ListView.builder(
                itemCount: 1000,
                itemBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Row(
                        children: [
                          ElText('${index + 1}'),
                          const Gap(8),
                          const Expanded(
                            child: _Slider(),
                          ),
                        ],
                      ),
                    ))
                : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  100,
                      (index) =>
                      Row(
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
