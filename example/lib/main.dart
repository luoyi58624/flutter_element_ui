import 'package:chicago/chicago.dart';
import 'package:example/layout/layout.dart';
import 'package:example/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ElApp(
      // theme: ElThemeData(primary: Colors.purple, radius: 8),
      child: MaterialApp(
        title: 'Flutter Element UI',
        home: Material(child: LayoutPage()),
      ),
    );
  }
}
