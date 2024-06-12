import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';

import 'body.dart';
import 'header.dart';

class ElPage extends StatelessWidget {
  const ElPage({
    super.key,
    this.header,
    this.body,
  });

  final ElHeader? header;
  final ElBody? body;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.elTheme.bgColor,
      child: Column(
        children: [
          if (header != null) header!,
          if (body != null) body!,
        ],
      ),
    );
  }
}
