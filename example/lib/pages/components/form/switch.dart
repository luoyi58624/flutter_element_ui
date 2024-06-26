import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SwitchPage extends HookWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Center(
      child: Column(
        children: [
          Text("Hello").animate().fade(),
          ElSwitch(
            value: flag.value,
            onChanged: (v) => flag.value = v,
          ),
        ],
      ),
    );
  }
}
