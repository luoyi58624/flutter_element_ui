import 'package:element_docs/global.dart';
import 'package:element_docs/test/temp_test_page.dart';
import 'package:flutter/material.dart';

class SimpleLayoutPage extends ResponsivePage {
  const SimpleLayoutPage({super.key});

  @override
  String get title => '简单布局';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      textGap,
      const CodeExample(
        expanded: true,
        code: code,
        children: [
          _Example(),
        ],
      ),
    ];
  }
}

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
          navbar: ElNavbar(
            child: Row(),
          ),
          sidebar: ElSidebar(
            child: Column(),
          ),
        ),
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
          navbar: ElNavbar(
            child: Row(),
          ),
          sidebar: ElSidebar(
            child: Column(),
          ),
        ),
      ),
    );
  }
}""";
