import 'package:element_docs/global.dart';
import 'package:element_docs/test/temp_test_page.dart';
import 'package:flutter/material.dart';

class LayoutTemplatePage extends StatelessWidget {
  const LayoutTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElLayout(
      body: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
