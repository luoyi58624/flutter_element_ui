import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class MaterialLayoutPage extends ResponsivePage {
  const MaterialLayoutPage({super.key});

  @override
  String get title => 'Material 风格布局';

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
      child: ElLayout(
        navbar: ElNavbar(child: navbar),
        sidebar: ElSidebar(child: sidebar),
        body: Container(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }

  Widget get navbar {
    return const Material(
      color: Colors.blue,
      elevation: 4,
      child: Row(),
    );
  }

  Widget get sidebar {
    // 应用 Material 局部暗黑模式，这里只用来处理波纹的颜色，但这种方式并不好，因为它会覆盖祖先定义的主题，
    // 但我不知道如何局部更改 Material 的主题
    return Theme(
      data: ThemeData.dark(),
      // 强制 Element UI 局部主题为黑暗模式，只需要嵌套一个 ElBrightness 小部件并指定主题模式即可
      child: ElBrightness(
        brightness: Brightness.dark,
        // 波纹绘制必须放在 Material 小部件中
        child: Material(
          color: Colors.blueGrey.shade800,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  100,
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
        body: Container(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }

  Widget get navbar {
    return const Material(
      color: Colors.blue,
      elevation: 4,
      child: Row(),
    );
  }

  Widget get sidebar {
    // 应用 Material 局部暗黑模式，这里只用来处理波纹的颜色，但这种方式并不好，因为它会覆盖祖先定义的主题，
    // 但我不知道如何局部更改 Material 的主题
    return Theme(
      data: ThemeData.dark(),
      // 强制 Element UI 局部主题为黑暗模式，只需要嵌套一个 ElBrightness 小部件并指定主题模式即可
      child: ElBrightness(
        brightness: Brightness.dark,
        // 波纹绘制必须放在 Material 小部件中
        child: Material(
          color: Colors.blueGrey.shade800,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  100,
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
}""";
