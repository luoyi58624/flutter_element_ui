import 'package:flutter/material.dart';

import 'examples/01.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Example1(),
      ],
    );
  }
}
