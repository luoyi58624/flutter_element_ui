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
    return Padding(
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
              ElRadio(label: '选项二', value: 2),
              ElRadio(label: '选项三', value: 3),
            ],
          ),
        ],
      ),
    );
  }
}
