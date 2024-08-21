import 'package:flutter/material.dart';

import 'examples/01.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ButtonPage1(),
      ],
    );
  }
}
