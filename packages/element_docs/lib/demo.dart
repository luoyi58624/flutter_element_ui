import 'package:element_docs/global.dart';
import 'package:element_docs/hooks/simple_hook.dart';
import 'package:flutter/material.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Demo(),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              33,
              (row) {
                return Row(
                  children: List.generate(33, (int col) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('row: $row; col: $col'),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
