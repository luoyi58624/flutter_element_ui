import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class PerformanceTestPage extends HookWidget {
  const PerformanceTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('进度条性能测试'),
        actions: [
          ElText(flag.value ? 'Flutter' : 'Element'),
          const Gap(8),
          Switch(
            value: flag.value,
            onChanged: (v) => flag.value = v,
          ),
        ],
      ),
      body: flag.value ? const _Left() : const _Right(),
    );
  }
}

class _Left extends HookWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: List.generate(
            1000,
            (index) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  ElText('${index + 1}. '),
                  Expanded(
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Right extends HookWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    final duration = useState(1800.0);
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            valueIndicatorTextStyle:
                ElDefaultTextStyle.of(context).style.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
          ),
          child: Slider(
            value: duration.value,
            min: 1000,
            max: 10000,
            label: '动画时间：${duration.value.round().toString()} 毫秒',
            onChanged: (v) => duration.value = v,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: List.generate(
                  1000,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        ElText('${index + 1}. '),
                        Expanded(
                          child: ElProgress.animate(
                            50,
                            duration: Duration(
                              milliseconds: duration.value.toInt(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
