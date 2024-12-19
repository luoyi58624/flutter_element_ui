import 'package:flutter/material.dart';

import '../../global.dart';

class BoxShadowTestPage extends HookWidget {
  const BoxShadowTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = useState(0.0);
    final offset = useState(4.0);
    final width = useState(6.0);
    final isActive = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('阴影生成器'),
      ),
      body: Row(
        children: [
          Column(
            children: [],
          ),
          Container(),
        ],
      ),
    );
  }
}
