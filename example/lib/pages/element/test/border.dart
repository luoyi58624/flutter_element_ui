import 'package:flutter/material.dart';

class BorderTestPage extends StatefulWidget {
  const BorderTestPage({super.key});

  @override
  State<BorderTestPage> createState() => _BorderTestPageState();
}

class _BorderTestPageState extends State<BorderTestPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return TwoDimensionalScrollWidget(
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
    return Scrollbar(
      thickness: 12.0,
      trackVisibility: true,
      interactive: true,
      controller: _verticalController,
      scrollbarOrientation: ScrollbarOrientation.right,
      thumbVisibility: true,
      child: Scrollbar(
        thickness: 12.0,
        trackVisibility: true,
        interactive: true,
        controller: _horizontalController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        thumbVisibility: true,
        notificationPredicate: (ScrollNotification notif) => notif.depth == 1,
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
    );
  }
}
