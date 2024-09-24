import 'dart:core';

import 'package:example/global.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<ElFormState>();
  final formData = {
    'username': 'luoyi',
    'count': 0,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElForm(
              key: formKey,
              model: formData,
              children: [
                ElFormItem(
                  label: '用户名: ',
                  prop: 'username',
                  child: ElInput(formData['username']),
                ),
                ElFormItem(
                  child: Row(
                    children: [
                      ElButton(
                        onPressed: () {
                          el.i(formData);
                        },
                        type: 'primary',
                        child: '提 交',
                      ),
                      ElButton(
                        onPressed: () {
                          formData['count'] = (formData['count'] as int) + 1;
                          setState(() {});
                          formKey.currentState!.reset();
                        },
                        child: '重 置',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
