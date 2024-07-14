import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/global.dart';

import 'common.dart';

class FormWidgets extends HookWidget {
  const FormWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final inputController = useTextEditingController();
    final switchValue = useState(true);
    final radioValue = useState(0);
    final checkboxValue = useState(false);
    final tristateCheckboxValue = useState<bool?>(null);
    final sliderValue = useState(0.0);
    return ComponentDecoration(title: 'Form', children: [
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
          contentPadding: EdgeInsets.only(bottom: 8),
        ),
      ),
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
          filled: true,
        ),
      ),
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding:
              EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Switch(value: false, onChanged: (v) {}),
          Switch(
              value: switchValue.value,
              onChanged: (v) => switchValue.value = v),
          CupertinoSwitch(value: false, onChanged: (v) {}),
          CupertinoSwitch(
              value: switchValue.value,
              onChanged: (v) => switchValue.value = v),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Radio(
              value: 0,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
          Radio(
              value: 1,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
          Radio(
              value: 2,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
          Radio(
              value: 3,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Checkbox(
              value: checkboxValue.value,
              onChanged: (v) => checkboxValue.value = v!),
          Checkbox(
              value: !checkboxValue.value,
              isError: true,
              onChanged: (v) => checkboxValue.value = v!),
          Checkbox(
              value: tristateCheckboxValue.value,
              tristate: true,
              onChanged: (v) {
                if (v == false) {
                  tristateCheckboxValue.value = true;
                } else if (v == null) {
                  tristateCheckboxValue.value = false;
                } else {
                  tristateCheckboxValue.value = null;
                }
              }),
          Checkbox(value: checkboxValue.value, onChanged: null),
        ],
      ),
      Column(
        children: [
          RadioListTile(
              title: const Text('Option 1'),
              value: 0,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
          RadioListTile(
              title: const Text('Option 2'),
              value: 1,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
          RadioListTile(
              title: const Text('Option 3'),
              value: 2,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
          RadioListTile(
              title: const Text('Option 4'),
              value: 3,
              groupValue: radioValue.value,
              onChanged: (v) => radioValue.value = v!),
        ],
      ),
      Column(
        children: [
          CheckboxListTile(
              title: const Text('Option 1'),
              value: checkboxValue.value,
              onChanged: (v) => checkboxValue.value = v!),
          CheckboxListTile(
            title: const Text('Option 1'),
            value: !checkboxValue.value,
            isError: true,
            onChanged: (v) => checkboxValue.value = !checkboxValue.value,
          ),
          CheckboxListTile(
              title: const Text('Option 1'),
              value: tristateCheckboxValue.value,
              tristate: true,
              onChanged: (v) {
                if (v == false) {
                  tristateCheckboxValue.value = true;
                } else if (v == null) {
                  tristateCheckboxValue.value = false;
                } else {
                  tristateCheckboxValue.value = null;
                }
              }),
          CheckboxListTile(
              title: const Text('Option 1'),
              value: checkboxValue.value,
              onChanged: null),
        ],
      ),
      buildProgressWidget(),
      Slider(
        max: 100,
        value: sliderValue.value,
        onChanged: (v) => sliderValue.value = v,
      ),
      Slider(
        max: 100,
        divisions: 10,
        value: sliderValue.value,
        label: sliderValue.value.round().toString(),
        onChanged: (v) => sliderValue.value = v,
      ),
      const _SliderWidget(),
    ]);
  }

  Widget buildProgressWidget() {
    final play = useState(false);
    final double? progressValue = play.value ? null : 0.7;
    return Row(
      children: [
        IconButton(
          isSelected: play.value,
          selectedIcon: const Icon(Icons.pause),
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            play.value = !play.value;
          },
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              const Gap(16),
              CircularProgressIndicator(
                value: progressValue,
              ),
              const Gap(16),
              Expanded(
                child: LinearProgressIndicator(
                  value: progressValue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SliderWidget extends HookWidget {
  const _SliderWidget();

  @override
  Widget build(BuildContext context) {
    final sliderValue = useState(0.0);
    return Column(
      children: [
        Slider(
          max: 100,
          value: sliderValue.value,
          onChanged: (v) => sliderValue.value = v,
        ),
        Slider(
          max: 100,
          divisions: 10,
          value: sliderValue.value,
          label: sliderValue.value.round().toString(),
          onChanged: (v) => sliderValue.value = v,
        )
      ],
    );
  }
}
