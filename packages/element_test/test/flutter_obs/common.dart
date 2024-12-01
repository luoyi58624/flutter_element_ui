import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';

Future<dynamic> push(BuildContext context, Widget child) {
  return Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => child),
  );
}

/// 通用的子页面，包含一个 back 返回文本按钮
class ChildPage extends StatelessWidget {
  const ChildPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Text('back'),
        ),
        child,
      ],
    );
  }
}

/// 局部状态小部件
class LocalStateWidget extends StatelessWidget {
  const LocalStateWidget(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final count = Obs(0);
    return GestureDetector(
      onTap: () {
        count.value++;
      },
      child: ObsBuilder(builder: (context) {
        return Text('$name: $count');
      }),
    );
  }
}
