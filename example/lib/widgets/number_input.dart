import 'package:example/global.dart';
import 'package:flutter/material.dart';

class NumberInputWidget extends StatelessWidget {
  const NumberInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 36,
        constraints: BoxConstraints(
          maxWidth: 120,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expanded(
            //   child: Center(child: Text('value')),
            // ),
            Text('value'),
            ColoredBox(
              color: Colors.grey,
              child: SizedBox(
                width: 1,
                height: double.infinity,
              ),
            ),
            SizedBox(
              width: 20,
              child: Column(
                children: [
                  Expanded(
                    child: ElIcon(
                      ElIcons.arrowUpBold,
                      size: 16,
                    ),
                  ),
                  ColoredBox(
                    color: Colors.grey,
                    child: SizedBox(
                      height: 1,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: ElIcon(
                      ElIcons.arrowDownBold,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
