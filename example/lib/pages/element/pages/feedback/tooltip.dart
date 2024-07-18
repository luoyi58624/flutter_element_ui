import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TooltipPage extends StatelessWidget {
  const TooltipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: ElTooltip(
              content: 'Top Center prompts info',
              child: ElButton(
                onPressed: () {},
                child: 'top',
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: ElTooltip(
              content: 'Top Center prompts info',
              child: ElButton(
                onPressed: () {},
                child: 'top',
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: ElTooltip(
              content: 'Top Center prompts info',
              child: ElButton(
                onPressed: () {},
                child: 'top',
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: ElTooltip(
              content: 'Top Center prompts info',
              child: ElButton(
                onPressed: () {},
                child: 'top',
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: UnconstrainedBox(
              child: ElTooltip(
                content: 'Top Center prompts info',
                child: ElButton(
                  onPressed: () {},
                  child: 'top',
                ),
              ),
            ),
          ),
          // Tooltip(
          //   message: 'Top Center prompts info',
          //   child: ElButton(
          //     onPressed: () {},
          //     child: 'top',
          //   ),
          // ),
        ],
      ),
    );
  }
}
