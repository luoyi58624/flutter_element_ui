import 'package:example/global.dart';
import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  int? selected = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElRadioGroup(
              onChanged: (v) {
                setState(() {
                  selected = v;
                });
              },
              value: selected,
              children: const [
                ElRadio(label: '选项一', value: 1),
                ElRadio(label: '选项二', value: 2, disabled: true),
                ElRadio(label: '选项三', value: 3),
              ],
            ),
            ElRadio(
              label: '选项一',
              value: 1,
              selectedValue: selected,
              onChanged: (v) {
                setState(() {
                  selected = v;
                });
              },
            ),
            ElRadio(
              label: '选项二',
              value: 2,
              disabled: true,
              selectedValue: selected,
            ),
            ElRadio(
              label: '选项三',
              value: 3,
              selectedValue: selected,
              onChanged: (v) {
                setState(() {
                  selected = v;
                });
              },
            ),
            ListTile(
              onTap: () {
                setState(() {
                  selected = 1;
                });
              },
              leading: ElRadio(value: 1, selectedValue: selected),
              title: const Text('选项一'),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  selected = 2;
                });
              },
              leading: ElRadio(value: 2, selectedValue: selected),
              title: const Text('选项二'),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  selected = 3;
                });
              },
              leading: ElRadio(value: 3, selectedValue: selected),
              title: const Text('选项三'),
            ),
          ],
        ),
      ),
    );
  }
}
