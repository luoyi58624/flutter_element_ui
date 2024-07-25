import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int id = 0;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoPage'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () {
            final newId = id++;
            late OverlayEntry overlayEntry;
            overlayEntry = OverlayEntry(
              builder: (context) => _Demo(
                id: newId,
              ),
            );
            Overlay.of(context).insert(overlayEntry);
            overlayEntry.remove.delay(5000);
          },
          child: const Text('插入overlay'),
        ),
      ),
    );
  }
}

class _Demo extends StatelessWidget {
  const _Demo({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    // i('build', id);
    return Positioned(
      top: id * 50,
      left: 0,
      child: Container(
        width: 50,
        height: 50,
        color: CupertinoColors.activeGreen,
      ),
    ).animate().fade().slideY(begin: -50, end: 0);
  }
}
