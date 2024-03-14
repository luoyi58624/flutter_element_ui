import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool disabled = false;
  int count = 0;

  VoidCallback? get onPressed => disabled
      ? null
      : () => {
            setState(() {
              count++;
            })
          };

  Widget get childWidget => Text('count: $count');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ElButton(
              onPressed: () {
                setState(() {
                  disabled = !disabled;
                });
              },
              child: Text(disabled ? 'Enabled' : 'Disabled'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onPressed, child: childWidget),
                ElButton(onPressed: onPressed, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.success, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.info, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.error, child: childWidget),
                ElButton.icon(Icons.search, onPressed: onPressed),
                ElButton.icon(Icons.edit_calendar_outlined, onPressed: onPressed, type: ElThemeType.primary),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onPressed, plain: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, plain: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.success, plain: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.info, plain: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, plain: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.error, plain: true, child: childWidget),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onPressed, round: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, round: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.success, round: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.info, round: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, round: true, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.error, round: true, child: childWidget),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.text('Default', onPressed: onPressed),
                ElButton.text('Primary', onPressed: onPressed, type: ElThemeType.primary),
                ElButton.text('Success', onPressed: onPressed, type: ElThemeType.success),
                ElButton.text('Info', onPressed: onPressed, type: ElThemeType.info),
                ElButton.text('Warning', onPressed: onPressed, type: ElThemeType.warning),
                ElButton.text('Error', onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.text('Default', onPressed: onPressed, bg: true),
                ElButton.text('Primary', onPressed: onPressed, type: ElThemeType.primary, bg: true),
                ElButton.text('Success', onPressed: onPressed, type: ElThemeType.success, bg: true),
                ElButton.text('Info', onPressed: onPressed, type: ElThemeType.info, bg: true),
                ElButton.text('Warning', onPressed: onPressed, type: ElThemeType.warning, bg: true),
                ElButton.text('Error', onPressed: onPressed, type: ElThemeType.error, bg: true),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(Icons.search, onPressed: onPressed),
                ElButton.icon(Icons.edit_calendar_outlined, onPressed: onPressed, type: ElThemeType.primary),
                ElButton.icon(Icons.check, onPressed: onPressed, type: ElThemeType.success),
                ElButton.icon(Icons.email_outlined, onPressed: onPressed, type: ElThemeType.info),
                ElButton.icon(Icons.delete, onPressed: onPressed, type: ElThemeType.warning),
                ElButton.icon(Icons.access_alarm, onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(Icons.search, onPressed: onPressed, circle: true),
                ElButton.icon(Icons.edit_calendar_outlined, onPressed: onPressed, type: ElThemeType.primary, circle: true),
                ElButton.icon(Icons.check, onPressed: onPressed, type: ElThemeType.success, circle: true),
                ElButton.icon(Icons.email_outlined, onPressed: onPressed, type: ElThemeType.info, circle: true),
                ElButton.icon(Icons.delete, onPressed: onPressed, type: ElThemeType.warning, circle: true),
                ElButton.icon(Icons.access_alarm, onPressed: onPressed, type: ElThemeType.error, circle: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
