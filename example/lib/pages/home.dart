import 'package:flutter/cupertino.dart';
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
                SizedBox(height: 50, child: ElButton(onPressed: onPressed, child: childWidget)),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.success, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.info, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, child: childWidget),
                ElButton(onPressed: onPressed, type: ElThemeType.error, child: childWidget),
                ElButton.icon(onPressed: onPressed, icon: Icons.search),
                ElButton.icon(onPressed: onPressed, icon: Icons.edit_calendar_outlined, type: ElThemeType.primary),
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
                ElButton.icon(onPressed: onPressed, icon: Icons.search, circle: true),
                ElButton.icon(onPressed: onPressed, icon: Icons.edit_calendar_outlined, type: ElThemeType.primary, circle: true),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(onPressed: onPressed, icon: Icons.search),
                ElButton.icon(onPressed: onPressed, icon: Icons.edit_calendar_outlined, type: ElThemeType.primary),
                ElButton.icon(onPressed: onPressed, icon: Icons.check, type: ElThemeType.success),
                ElButton.icon(onPressed: onPressed, icon: Icons.email_outlined, type: ElThemeType.info),
                ElButton.icon(onPressed: onPressed, icon: Icons.delete, type: ElThemeType.warning),
                ElButton.icon(onPressed: onPressed, icon: Icons.access_alarm, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(onPressed: onPressed, icon: Icons.search, circle: true),
                ElButton.icon(onPressed: onPressed, icon: Icons.edit_calendar_outlined, type: ElThemeType.primary, circle: true),
                ElButton.icon(onPressed: onPressed, icon: Icons.check, type: ElThemeType.success, circle: true),
                ElButton.icon(onPressed: onPressed, icon: Icons.email_outlined, type: ElThemeType.info, circle: true),
                ElButton.icon(onPressed: onPressed, icon: Icons.delete, type: ElThemeType.warning, circle: true),
                ElButton.icon(onPressed: onPressed, icon: Icons.access_alarm, type: ElThemeType.error, circle: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
