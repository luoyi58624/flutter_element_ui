import 'package:flutter/material.dart';

import '../../global.dart';

class NestScrollTest extends HookWidget {
  const NestScrollTest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return SizedBox(
      height: 800,
      child: NestScrollWrapper(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
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
              // const _Child2(),
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

class _Child extends HookWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purpleAccent),
      ),
      child: Material(
        color: context.elTheme.bgColor,
        child: NestScrollWrapper(
          controller: controller,
          child: SingleChildScrollView(
            controller: controller,
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
          ),
        ),
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
                200,
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