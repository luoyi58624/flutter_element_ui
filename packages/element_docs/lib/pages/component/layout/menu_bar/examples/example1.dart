import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: ['ElLayout 偏向于桌面端布局，对于移动端请使用 Scaffold 官方实现的布局组件'],
        ),
        textGap,
        const CodeExample(
          code: code,
          children: [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      child: ElLayout(
        navbar: ElNavbar(),
        sidebar: ElSidebar(),
        body: ElBody(),
      ),
    );
  }
}

const String code = """
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ElLayoutTheme(
        data: ElLayoutThemeData(
          navbarColor: Colors.blue,
          sidebarColor: Colors.blueGrey.shade800,
        ),
        child: const ElLayout(
          navbar: ElNavbar(),
          sidebar: ElSidebar(),
          body: ElBody(),
        ),
      ),
    );
  }
}""";
