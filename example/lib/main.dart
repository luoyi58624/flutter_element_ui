import 'package:example/layout/layout.dart';
import 'package:example/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return ElApp(
      theme: ElThemeData(
        primary: flag ? Colors.purple : Colors.blue,
        success: const Color(0xff059669),
        info: const Color(0xff64748B),
        warning: const Color(0xfff59e0b),
        error: const Color(0xffe11d48),
        radius: 8,
      ),
      child: MaterialApp.router(
        title: 'Flutter Element UI',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        // home: Scaffold(
        //   appBar: AppBar(
        //     actions: [
        //       Switch(
        //         value: flag,
        //         onChanged: (value) {
        //           setState(() {
        //             flag = !flag;
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        //   body: HomePage(),
        // ),
      ),
    );
  }
}
