<p align="center">
  <img width="300px" src="https://user-images.githubusercontent.com/10731096/95823103-9ce15780-0d5f-11eb-8010-1bd1b5910d4f.png">
</p>

<p align="center">Flutter Element UI - A Flutter UI library</p>

<p align="center">
  <a href="https://flutter.cn/" target="_blank">
    <img src="https://img.shields.io/badge/flutter-%20%3E%3D%203.24.0-47c219" />
  </a>
   <a href="https://pub.dartlang.org/packages/element_plus" target="_blank">
    <img src="https://img.shields.io/pub/v/element_plus.svg?style=popout" />
  </a>
  <a href="https://github.com/invertase/melos" target="_blank">
    <img src="https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square" />
  </a>
  <a href="https://npmcharts.com/compare/element-plus?minimal=true" target="_blank">
    <img src="https://codecov.io/gh/Sub6Resources/element_plus/branch/master/graph/badge.svg" />
  </a>
    <a href="https://github.com/luoyi58624/flutter_element_ui/blob/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" />
  </a>
  <br>
</p>

## Getting Started

- Install

```
flutter pub add element_plus
```

- Edit main.dart

```dart
import 'package:flutter/material.dart';
import 'package:element_plus/element_plus.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      child: MaterialApp(
        navigatorKey: el.navigatorKey,
        home: const HomePage(),
        builder: ElApp.builder(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: const Center(
        child: ElButton(
            child: 'Hello'
        ),
      ),
    );
  }
}
```

## Fork flutter_element_ui

You need global install [melos](https://github.com/invertase/melos), It is monorepo cli tools.

```
dart pub global activate melos
melos bs
```
