import 'package:flutter/material.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题颜色'),
      ),
      body: ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) => ListTile(
          title: Text('列表 - ${index + 1}'),
        ),
      ),
    );
  }
}
