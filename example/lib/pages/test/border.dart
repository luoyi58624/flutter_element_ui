import 'package:example/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class BorderTestPage extends StatefulWidget {
  const BorderTestPage({super.key});

  @override
  State<BorderTestPage> createState() => _BorderTestPageState();
}

class _BorderTestPageState extends State<BorderTestPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        LoggerUtil.i(constraints.maxWidth);
        return Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: constraints.maxWidth,
              height: 50,
              child: Row(
                children: [
                  Container(
                    width: 200,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Container(
                      width: 200,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 200,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
