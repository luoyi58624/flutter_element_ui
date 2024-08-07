import 'package:example/global.dart';
import 'package:flutter/material.dart';

class InputNumberPage extends StatelessWidget {
  const InputNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(child: ElInputNumber());
    return const Align(
      child: Column(
        children: [
          Gap(50),
          ElInputNumber(),
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
