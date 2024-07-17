import 'package:example/global.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulHookWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String inputValue = 'StatefulWidget';

  @override
  Widget build(BuildContext context) {
    final stateValue = useState('useState');
    final obsValue = useObs('obs');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const ElText('========== StatefulWidget 传统写法 ==========='),
                  const Gap(24),
                  ElText(inputValue),
                  ElInput(
                    value: inputValue,
                    height: 50,
                    round: true,
                    onChanged: (v) => setState(() => inputValue = v),
                  ),
                  ElInput(
                    value: inputValue,
                    round: true,
                    onChanged: (v) => setState(() => inputValue = v),
                  ),
                  const Gap(50),
                  const ElText('========== Hook 写法 ==========='),
                  const Gap(24),
                  ElText(stateValue.value),
                  ElInput(
                    value: stateValue.value,
                    onChanged: (v) => stateValue.value = v,
                  ),
                  ElInput(
                    value: stateValue.value,
                    onChanged: (v) => stateValue.value = v,
                  ),
                  const Gap(50),
                  const ElText('========== Obs 写法 ==========='),
                  const Gap(24),
                  ObsBuilder(builder: (context) {
                    return ElText(obsValue.value);
                  }),
                  ObsBuilder(builder: (context) {
                    return ElInput(
                      value: obsValue.value,
                      onChanged: (v) => obsValue.value = v,
                    );
                  }),
                  ObsBuilder(builder: (context) {
                    return ElInput(
                      value: obsValue.value,
                      onChanged: (v) => obsValue.value = v,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
