import 'package:docs/global.dart';
import 'package:flutter/material.dart';

/// 响应式页面抽象类
abstract class ResponsivePage extends HookWidget {
  const ResponsivePage({super.key});

  /// 页面标题
  String get title;

  /// 构建通用的文档页面，适配桌面端和移动端
  List<Widget> buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return context.sm
        ? Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: ColumnWidget(
              scroll: true,
              padding: const EdgeInsets.all(8),
              children: buildPage(context),
            ),
          )
        : ColumnWidget(
            scroll: true,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            children: [
              H1(
                title,
                style: TextStyle(
                  color: el.isDark
                      ? Colors.grey.shade300
                      : Colors.grey.shade800,
                ),
              ),
              ...buildPage(context),
            ],
          );
  }
}
