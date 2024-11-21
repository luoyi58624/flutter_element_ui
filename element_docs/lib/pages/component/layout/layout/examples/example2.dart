import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ElLayout(
        navbar: ElNavbar(child: navbar),
        sidebar: ElSidebar(child: sidebar),
      ),
    );
  }

  Widget get navbar {
    return Material(
      color: Colors.blue,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            buildIconButton(Icons.menu),
            const Gap(8),
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            buildIconButton(Icons.search),
            buildIconButton(Icons.favorite),
            buildIconButton(Icons.more_vert_outlined),
          ],
        ),
      ),
    );
  }

  Widget get sidebar {
    // 应用 Material 局部暗黑主题
    return Theme(
      data: ThemeData.dark(),
      // 应用 Element UI 局部暗黑主题
      child: ElBrightness(
        brightness: Brightness.dark,
        // 波纹绘制必须放在 Material 小部件中
        child: Material(
          color: Colors.blueGrey.shade800,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  20,
                  (index) => ListTile(
                    onTap: () {},
                    title: ElText(
                      'Item - ${index + 1}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIconButton(IconData iconData) {
    return IconButton(
      onPressed: () {},
      hoverColor: Colors.white10,
      focusColor: Colors.white10,
      highlightColor: Colors.white24,
      splashColor: Colors.white,
      constraints: BoxConstraints.tight(const Size(48, 48)),
      icon: Icon(
        iconData,
        color: Colors.white,
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
      child: ElLayout(
        navbar: ElNavbar(child: navbar),
        sidebar: ElSidebar(child: sidebar),
      ),
    );
  }

  Widget get navbar {
    return Material(
      color: Colors.blue,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            buildIconButton(Icons.menu),
            const Gap(8),
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            buildIconButton(Icons.search),
            buildIconButton(Icons.favorite),
            buildIconButton(Icons.more_vert_outlined),
          ],
        ),
      ),
    );
  }

  Widget get sidebar {
    // 应用 Material 局部暗黑主题
    return Theme(
      data: ThemeData.dark(),
      // 应用 Element UI 局部暗黑主题
      child: ElBrightness(
        brightness: Brightness.dark,
        // 波纹绘制必须放在 Material 小部件中
        child: Material(
          color: Colors.blueGrey.shade800,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  20,
                  (index) => ListTile(
                    onTap: () {},
                    title: ElText(
                      'Item - \${index + 1}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIconButton(IconData iconData) {
    return IconButton(
      onPressed: () {},
      hoverColor: Colors.white10,
      focusColor: Colors.white10,
      highlightColor: Colors.white24,
      splashColor: Colors.white,
      constraints: BoxConstraints.tight(const Size(48, 48)),
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}""";
