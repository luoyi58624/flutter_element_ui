import 'package:boxy/boxy.dart';
import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomBoxy(
      delegate: MyDelegate(),
      children: [
        LayoutId(
          id: #first,
          child: ElText(text),
        ),
      ],
    );
  }
}

class MyDelegate extends BoxyDelegate {
  @override
  Size layout() {
    var firstChild = getChild(#first);

    var firstSize = firstChild.layout(constraints);
    firstChild.position(Offset.zero);

    i(firstSize);
    var text = AnimatedContainer(
      duration: 500.ms,
      width: firstSize.width,
      height: 100,
      color: Colors.green,
    );

    // Inflate the text widget
    var secondChild = inflate(text, id: #second);

    var secondSize = secondChild.layout(constraints
        .deflate(EdgeInsets.only(top: firstSize.height))
        .tighten(width: firstSize.width));

    secondChild.position(Offset(0, firstSize.height));

    return Size(
      firstSize.width,
      firstSize.height + secondSize.height,
    );
  }
}
