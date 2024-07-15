import 'package:example/global.dart';
import 'package:flutter/widgets.dart';

class SliderPage extends HookWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = useObs(30.0);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ...List.generate(
              50,
              (index) => Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(child: ElSlider(progress)),
                    ObsBuilder(builder: (context) {
                      return Text((progress.value.floor()).toString());
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
