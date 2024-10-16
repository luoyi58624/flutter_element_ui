import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const _ScrollTest(),
    ];
  }
}

class _ScrollTest extends HookWidget {
  const _ScrollTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: ScrollPhysicsBuilder(
        builder: (controller, physics) => SingleChildScrollView(
          controller: controller,
          physics: physics,
          child: Column(
            children: [
              ...List.generate(
                10,
                (index) => ListTile(
                  onTap: () {},
                  title: Text(
                    'Item - ${index + 1}',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const _Child2(),
              const _Child(),
              ...List.generate(
                10,
                (index) => ListTile(
                  onTap: () {},
                  title: Text(
                    'Item - ${index + 1}',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const _Child2(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purpleAccent),
      ),
      child: Material(
        color: context.elTheme.colors.bg,
        child: ScrollPhysicsBuilder(builder: (controller, physics) {
          return SingleChildScrollView(
            controller: controller,
            physics: physics,
            child: Column(
              children: [
                ...List.generate(
                  20,
                  (index) => ListTile(
                    onTap: () {},
                    title: Text(
                      'Child Item - ${index + 1}',
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Child2 extends HookWidget {
  const _Child2();

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purpleAccent),
      ),
      child: HorizontalScrollWidget(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                20,
                (index) => Text(
                  'Child Item - ${index + 1}',
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ).rawScrollBehavior,
      ),
    );
  }
}
