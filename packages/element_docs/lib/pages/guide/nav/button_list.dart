import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _num = 1000;

class ButtonListTestPage extends StatelessWidget {
  const ButtonListTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElButton2'),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: List.generate(
              _num,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ElButton2(
                  type: El.primary,
                  child: 'Item - ${index + 1}',
                ),
              ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElButton'),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
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
        ),
      ),
    );
  }
}

class ButtonListTestPage3 extends StatelessWidget {
  const ButtonListTestPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElevatedButton'),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
