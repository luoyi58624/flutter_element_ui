import 'package:example/global.dart';
import 'package:flutter/material.dart';

class InputPage extends HookWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputValue = useState('初始文本');
    final inputValue2 = useState('hello');
    final formData = useRef({'username': 'luoyi'});
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ElInput(value: inputValue),
                ElText('input: ${inputValue.value}'),
                ElInput(
                  value: 'hello',
                  onChanged: (v) => inputValue2.value = v,
                ),
                ElText('input: ${inputValue2.value}'),
                const ElInput(value: {'username': 'luoyi'}),
                const ElInput(),
                ElInput(value: formData.value['username']),
                ElButton(
                  onPressed: () {
                    formData.value['username'] = 'xxx';
                  },
                  child: '更新',
                ),
                ElText('input: ${formData.value}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
