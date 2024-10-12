<p align="center">
  <img width="300px" src="https://user-images.githubusercontent.com/10731096/95823103-9ce15780-0d5f-11eb-8010-1bd1b5910d4f.png">
</p>

<p align="center">Flutter Element UI - A Flutter UI library</p>

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

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

### Dev Flutter Element UI

- global install monorepo project cli

```
dart pub global activate melos
```

- install dev dependent

```
flutter pub get
```

- initialize project

```
melos bs
```
