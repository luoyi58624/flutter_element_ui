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
        child: Wrap(
          children: [
            ...List.generate(
              1000,
              (index) => SizedBox(
                width: 200,
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
