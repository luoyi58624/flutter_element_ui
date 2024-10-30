import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const _Example(),
    ];
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        ElSwitch(flag),
        const Gap(8),
        ElAnimatedButtonTheme(
          duration: 250.ms,
          curve: Curves.easeOut,
          data: ElButtonThemeData(width: flag.value ? 200 : null),
          child: const ElButton(child: 'Hello'),
        ),
      ],
    );
  }
}

extension ElColorExtension2 on Color {
  Color demo(BuildContext context) => mix(Colors.black, 50);

  Color demo2(BuildContext context) =>
      context.isDark ? mix(Colors.black, 50) : mix(Colors.white, 50);
}
