import 'dart:core';

import 'package:example/global.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formData = {
    'username': '',
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
              model: formData,
              children: [
                const ElFormItem(
                  label: '用户名: ',
                  prop: 'username',
                  child: ElInput(),
                ),
                const ElFormItem(
                  label: '用户名: ',
                  prop: 'username',
                  child: ElInput(),
                ),
                ElFormItem(
                  child: Row(
                    children: [
                      ElButton(
                        onPressed: () {},
                        type: 'primary',
                        child: '提 交',
                      ),
                      ElButton(
                        onPressed: () {
                          formData['count'] = (formData['count'] as int) + 1;
                          setState(() {});
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
