import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/layout_header.dart';
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
    final controller = useScrollController();
    return ElBubbleBuilder(builder: (stopBubble) {
      return ResponsivePageData(
        path,
        child: context.sm
            ? Scaffold(
                appBar: AppBar(
                  title: Text(title),
                ),
                body: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: stopBubble
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    padding:
                        EdgeInsets.all(PlatformUtil.isDesktop ? 16.0 : 8.0),
                    child: RepaintBoundary(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildPage(context),
                      ),
                    ),
                  ),
                ),
              )
            : NestScrollWrapper(
                controller: controller,
                child: SingleChildScrollView(
                  controller: controller,
                  physics:
                      stopBubble ? const NeverScrollableScrollPhysics() : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 50,
                  ),
                  child: RepaintBoundary(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElAnimatedDefaultTextStyle(
                          style: TextStyle(
                            color: context.isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade800,
                          ),
                          child: H1(title),
                        ),
                        ...buildPage(context),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
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
