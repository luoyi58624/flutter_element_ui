import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ChildPage extends StatelessWidget {
  const ChildPage({super.key, this.title, this.previousPageTitle = '返回'});

  final String? title;
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    var isCupertinoApp = FlutterUtil.hasAncestorElement<CupertinoApp>(context);
    if (isCupertinoApp) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title ?? '子页面'),
          previousPageTitle: previousPageTitle,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                CupertinoButton.filled(
                  onPressed: () {
                    context.push(ChildPage(title: title ?? '子页面'));
                  },
                  child: const Text('进入下一个子页面'),
                ),
                CupertinoButton.filled(
                  onPressed: () {
                    context.pop(context);
                  },
                  child: const Text('返回'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title ?? '子页面'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push(ChildPage(title: title ?? '子页面'));
                },
                child: const Text('进入下一个子页面'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
