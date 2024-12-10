import 'package:element_docs/global.dart';
import 'package:element_docs/hooks/simple_hook.dart';
import 'package:flutter/material.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Demo(),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TwoDimensionalScrollWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                33,
                (row) {
                  return Row(
                    children: List.generate(33, (int col) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('row: $row; col: $col'),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwoDimensionalScrollWidget extends StatelessWidget {
  final Widget child;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  TwoDimensionalScrollWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElScrollbar(
      // interactive: true,
      controller: _verticalController,
      scrollbarOrientation: ScrollbarOrientation.right,
      // thumbVisibility: true,
      child: ElScrollbar(
        thickness: 12.0,
        // interactive: true,
        controller: _horizontalController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        // thumbVisibility: true,
        notificationPredicate: (ScrollNotification notify) => notify.depth == 1,
        child: SingleChildScrollView(
          controller: _verticalController,
          child: SingleChildScrollView(
            primary: false,
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ),
    ).noScrollBehavior;
  }
}
