import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ElFont.init();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: GlobalState.brightness,
        builder: (context, value, _) {
          return MaterialApp.router(
            routerConfig: router,
            builder: (context, child) => ElTheme(
              textStyle: TextStyle(
                fontFamily: ElFont.fontFamily,
                fontFamilyFallback: ElFont.fontFamilyFallback,
              ),
              theme: ElThemeData(
                primary: const Color.fromARGB(255, 0, 120, 212),
                success: const Color.fromARGB(255, 16, 185, 129),
                info: const Color.fromARGB(255, 127, 137, 154),
                warning: const Color.fromARGB(255, 245, 158, 11),
                error: const Color.fromARGB(255, 239, 68, 68),
              ),
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

// theme: ElThemeData(
//   primary: flag ? Colors.purple : Colors.blue,
//   success: const Color(0xff059669),
//   info: const Color(0xff64748B),
//   warning: const Color(0xfff59e0b),
//   error: const Color(0xffe11d48),
//   radius: 8,
// ),

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            100,
            (index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Gap(16),
                  ElButton('hello'),
                  Gap(16),
                  ElButton('hello', type: 'primary'),
                  Gap(16),
                  ElButton('hello', type: 'success'),
                ],
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
