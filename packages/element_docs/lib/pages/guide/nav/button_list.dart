import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _num = 2000;

class ButtonListTestPage extends StatelessWidget {
  const ButtonListTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          _num,
          (index) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElButton2(
              child: 'Item - ${index + 1}',
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonListTestPage2 extends StatelessWidget {
  const ButtonListTestPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          _num,
          (index) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElButton(
              type: El.primary,
              child: 'Item - ${index + 1}',
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonListTestPage3 extends StatelessWidget {
  const ButtonListTestPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          _num,
          (index) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Item - ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }
}
