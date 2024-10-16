import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

/// 响应式页面抽象类
abstract class ResponsivePage extends HookWidget {
  const ResponsivePage({super.key});

  /// 页面标题
  String get title;

  /// 页面地址
  String get path => '/';

  /// 构建通用的文档页面，适配桌面端和移动端
  List<Widget> buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ResponsivePageData(
      path,
      child: context.sm
          ? Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Column(
                      children: buildPage(context),
                    );
                  }),
                ),
              ),
            )
          : ScrollPhysicsBuilder(
              builder: (controller, physics) => SingleChildScrollView(
                controller: controller,
                physics: physics,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 50,
                ),
                child: Builder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H1(
                        title,
                        style: TextStyle(
                          color: context.isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade800,
                        ),
                      ),
                      ...buildPage(context),
                    ],
                  );
                }),
              ),
            ),
    );
  }
}

class ResponsivePageData extends InheritedWidget {
  const ResponsivePageData(
    this.path, {
    super.key,
    required super.child,
  });

  final String path;

  static ResponsivePageData of(BuildContext context) {
    final ResponsivePageData? result =
        context.dependOnInheritedWidgetOfExactType<ResponsivePageData>();
    assert(result != null, 'No _ResponsivePageData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ResponsivePageData oldWidget) => true;
}
