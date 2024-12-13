import 'package:element_docs/global.dart';
import 'package:element_docs/hooks/simple_hook.dart';
import 'package:flutter/material.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      child: const MaterialApp(
        home: Demo(),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const ElText('xx'),
      ),
    );
  }
}
