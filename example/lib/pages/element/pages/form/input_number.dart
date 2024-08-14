import 'package:example/global.dart';
import 'package:flutter/material.dart';

class InputNumberPage extends HookWidget {
  const InputNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final show = useState(true);
    final (flag, toggle) = useToggle();
    return Align(
      child: Column(
        children: [
          const Gap(50),
          ElSwitch(show),
          const Gap(16),
          ElSwitch(flag, onChanged: toggle),
          if (show.value) const ElInputNumber(),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     ...AxisDirection.values.map(
          //       (e) => ElTriangle(
          //         size: const Size(100, 100),
          //         direction: e,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
