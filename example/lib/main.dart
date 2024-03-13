import 'package:chicago/chicago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ElApp(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton('Default', onPressed: () {}),
                ElButton('Primary', onPressed: () {}, type: ElThemeType.primary),
                ElButton('Success', onPressed: () {}, type: ElThemeType.success),
                ElButton('Info', onPressed: () {}, type: ElThemeType.info),
                ElButton('Warning', onPressed: () {}, type: ElThemeType.warning),
                ElButton('Error', onPressed: () {}, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton('Default', onPressed: () {}, plain: true),
                ElButton('Primary', onPressed: () {}, type: ElThemeType.primary, plain: true),
                ElButton('Success', onPressed: () {}, type: ElThemeType.success, plain: true),
                ElButton('Info', onPressed: () {}, type: ElThemeType.info, plain: true),
                ElButton('Warning', onPressed: () {}, type: ElThemeType.warning, plain: true),
                ElButton('Error', onPressed: () {}, type: ElThemeType.error, plain: true),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton('Default', onPressed: () {}, round: true),
                ElButton('Primary', onPressed: () {}, type: ElThemeType.primary, round: true),
                ElButton('Success', onPressed: () {}, type: ElThemeType.success, round: true),
                ElButton('Info', onPressed: () {}, type: ElThemeType.info, round: true),
                ElButton('Warning', onPressed: () {}, type: ElThemeType.warning, round: true),
                ElButton('Error', onPressed: () {}, type: ElThemeType.error, round: true),
              ],
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton('Default', onPressed: null),
                ElButton('Primary', onPressed: null, type: ElThemeType.primary),
                ElButton('Success', onPressed: null, type: ElThemeType.success),
                ElButton('Info', onPressed: null, type: ElThemeType.info),
                ElButton('Warning', onPressed: null, type: ElThemeType.warning),
                ElButton('Error', onPressed: null, type: ElThemeType.error),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
