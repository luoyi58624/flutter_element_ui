import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import '../state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('首页'),
    );
  }
}
