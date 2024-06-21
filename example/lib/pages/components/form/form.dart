import 'dart:core';

import 'package:example/global.dart';
import 'package:example/hooks/reactive.dart';
import 'package:flutter/material.dart';

class FormPage extends HookWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = useState<Map<String, dynamic>>({
      'username': '',
    });
    final formModel = useModel(FormModel());
    final model = ref({'count': 100});
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElForm(
              model: formData.value,
              child: Column(
                children: [
                  ListenableBuilder(
                    listenable: model,
                    builder: (context, child) {
                      return ElButton(
                        onPressed: () {
                          model.value['count'] = 1;
                          model.value = {'count': 1};
                        },
                        child: 'count：${model.value['count']}',
                      );
                    },
                  ),
                  ElButton(
                    onPressed: () {
                      formModel.increment();
                    },
                    child: 'count：${formModel.count}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormModel with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}

Model useModel<Model extends ChangeNotifier>(Model model) {
  final $model = useMemoized(() => model);
  useEffect(() => $model.dispose, [$model]);
  useListenable($model);
  return $model;
}

MyInt proxy(int value) {
  return MyInt(value);
}

class MyInt {
  int value;

  MyInt(this.value);

  MyInt operator +(int other) {
    value = value + other + 100;
    return this;
  }

  int call() => value;

  @override
  String toString() {
    return value.toString();
  }
}
