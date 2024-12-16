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
        title: const Text(''),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: RepaintBoundary(
            child: Column(
              spacing: 8,
              children: List.generate(
                _num,
                // (index) => Padding(
                //   padding: const EdgeInsets.only(top: 8),
                //   child: ElButton2(
                //     child: 'Item - ${index + 1}',
                //   ),
                // ),
                (index) => const ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    width: 100,
                    height: 10,
                  ),
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
        title: const Text(''),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: RepaintBoundary(
            child: Column(
              spacing: 8,
              children: List.generate(
                _num,
                // (index) => Padding(
                //   padding: const EdgeInsets.only(top: 8),
                //   child: ElButton(
                //     type: El.primary,
                //     child: 'Item - ${index + 1}',
                //   ),
                // ),
                (index) => const ColoredBox(
                  color: Colors.red,
                  child: ElEmptyWidget(
                    width: 100,
                    height: 10,
                  ),
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
        title: const Text(''),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: RepaintBoundary(
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
      ),
    );
  }
}
