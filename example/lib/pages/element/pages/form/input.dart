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
                    inputValue,
                    height: 50,
                    round: true,
                    onChanged: (v) => setState(() => inputValue = v),
                  ),
                  ElInput(
                    inputValue,
                    round: true,
                    onChanged: (v) => setState(() => inputValue = v),
                  ),
                  const Gap(50),
                  const ElText('========== Hook 写法 ==========='),
                  const Gap(24),
                  ElText(stateValue.value),
                  ElInput(stateValue),
                  ElInput(stateValue),
                  const Gap(50),
                  const ElText('========== Obs 写法 ==========='),
                  const Gap(24),
                  ObsBuilder(builder: (context) => ElText(obsValue.value)),
                  ElInput(obsValue),
                  ElInput(obsValue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
