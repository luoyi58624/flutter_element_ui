import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class MobileComponentLayout extends StatelessWidget {
  const MobileComponentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件'),
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      body: Center(
        child: ElevatedButton(
           onPressed: () {
             context.go('/component/child');
           },
           child: Text('子页面'),
        ),
      ),
    );
  }
}

class ComponentChildPage extends StatelessWidget {
  const ComponentChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/component/child/next_child');
          },
          child: const Text('下一个子页面'),
        ),
      ),
    );
  }
}

class ComponentChildPage2 extends StatelessWidget {
  const ComponentChildPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('二级子页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/component');
          },
          child: const Text('返回组件页面'),
        ),
      ),
    );
  }
}
