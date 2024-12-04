import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
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

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final username = useState('initialData');
    return SizedBox(
      height: 500,
      child: ElLayoutTheme(
        data: const ElLayoutThemeData(
          sidebarColor: Color.fromRGBO(34, 37, 43, 0.9),
        ),
        child: ElLayout(
          sidebar: ElSidebar(),
          body: ElBody(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ElInput(username),
                  const Gap(8),
                  const ElFocusScope(
                    child: ElButton(child: 'hello'),
                  ),
                ],
              ),
            ),
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
