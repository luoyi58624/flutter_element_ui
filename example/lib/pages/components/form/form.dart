import 'dart:core';

import 'package:example/global.dart';
import 'package:flutter/material.dart';

class FormPage extends HookWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = useObs({
      'count': 0,
      'username': '',
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElForm(
              model: formData,
              child: Column(
                children: [
                  ObsBuilder(builder: (context) {
                    return ElButton(
                      onPressed: () {
                        formData.value['count'] =
                            (formData.value['count'] as int) + 1;
                        formData.notify();
                      },
                      child: 'count：${formData.value['count']}',
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
