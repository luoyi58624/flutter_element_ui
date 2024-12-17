import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class ScrollPerformanceTest extends StatelessWidget {
  const ScrollPerformanceTest({
    super.key,
    required this.title,
    this.itemCount = 1000,
    required this.leftBuilder,
    required this.rightBuilder,
  });

  final String title;
  final int itemCount;
  final NullableIndexedWidgetBuilder leftBuilder;
  final NullableIndexedWidgetBuilder rightBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: RepaintBoundary(
                  child: _LeftWidget(itemCount, leftBuilder),
                ),
              ),
              Expanded(
                child: RepaintBoundary(
                  child: _RightWidget(itemCount, rightBuilder),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftWidget extends HookWidget {
  const _LeftWidget(this.itemCount, this.builder);

  final int itemCount;
  final NullableIndexedWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ColumnWidget(
      scroll: true,
      repaintBoundary: false,
      children: List.generate(
        itemCount,
        (index) => builder(context, index)!,
      ),
    );
  }
}

class _RightWidget extends HookWidget {
  const _RightWidget(this.itemCount, this.builder);

  final int itemCount;
  final NullableIndexedWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ColumnWidget(
      scroll: true,
      repaintBoundary: false,
      children: List.generate(
        itemCount,
        (index) => builder(context, index)!,
      ),
    );
  }
}
