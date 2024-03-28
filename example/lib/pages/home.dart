import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_plugin/flutter_plugin.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

import '../state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SmoothListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ElButton(
          'count: $count',
          onPressed: () {
            setState(() {
              count++;
            });
          },
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}
