import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Container(
        width: 500,
        height: 300,
        color: Colors.grey,
        child: Row(
          children: [
            // FractionallySizedBox(
            //   widthFactor: 0.3,
            //   heightFactor: 1.0,
            //   child: Container(
            //     color: Colors.blue,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
