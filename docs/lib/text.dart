import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _ElApp());
}

final isDark = Obs(false);

Brightness get brightness => isDark.value ? Brightness.dark : Brightness.light;

class _ElApp extends StatelessWidget {
  const _ElApp();

  @override
  Widget build(BuildContext context) {
    el.themeDuration = Duration.zero;
    return ObsBuilder(builder: (context) {
      return MaterialApp(
        navigatorKey: el.navigatorKey,
        home: HomePage(),
        theme: ThemeData(brightness: brightness),
        themeMode: ThemeMode.dark,
        themeAnimationDuration: el.themeDuration,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ElConfigProvider(
          brightness: brightness,
          child: child!,
        ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElSwitch(isDark),
          ),
        ],
      ),
      body: Column(
        children: [
          const ElText([
            'xxx',
            '富文本',
            'xxx',
            Text(
              'xxx',
              style: TextStyle(color: Colors.teal),
            ),
            TextSpan(
              text: 'xxx',
              style: TextStyle(color: Colors.green),
            ),
            ElText(
              'xxx',
              style: TextStyle(color: Colors.red),
            ),
            ElText(
              ['xxx', '富文本', 'ccc'],
              style: TextStyle(color: Colors.blue),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(Icons.home),
            ),
            H1('一级标题'),
            P(
              B([
                ElLink(child: '百度', href: 'https://www.baidu.com'),
              ]),
            ),
          ]),
          RichText(
            text: TextSpan(
              text: '普通文本',
              style: TextStyle(
                color: context.elTheme.textColor,
              ),
              children: [TextSpan(text: '一级标题')],
            ),
          ),
        ],
      ),
      // body: const ElText([
      //   H1('一级标题', style: TextStyle(color: Colors.red)),
      //   H2('二级标题', style: TextStyle(color: Colors.orange)),
      //   H3('三级标题', style: TextStyle(color: Colors.green)),
      //   H4('四级标题', style: TextStyle(color: Colors.cyan)),
      //   H5('五级标题', style: TextStyle(color: Colors.purple)),
      //   H6('六级标题', style: TextStyle(color: Colors.grey)),
      // ]),
      // body: Center(
      //   child: HoverBuilder(builder: (context) {
      //     return ElText(
      //       '文字',
      //       duration: 300.ms,
      //       style: context.isHover
      //           ? const TextStyle(
      //               fontSize: 50,
      //               color: Colors.blue,
      //             )
      //           : null,
      //     );
      //   }),
      // ),
    );
  }
}
