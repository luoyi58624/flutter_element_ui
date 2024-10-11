import 'package:boxy/boxy.dart';
import 'package:example/global.dart';
import 'package:flutter/material.dart';

class Test extends HookWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return CustomBoxy(
      delegate: MyDelegate(),
      children: [
        LayoutId(
          id: #first,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8.0),
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                flag.value = !flag.value;
              },
              child: AnimatedContainer(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1000),
                color: flag.value ? Colors.lightBlue : Colors.lightGreen,
                width: flag.value ? 200 : 400,
                height: flag.value ? 100 : 400,
              ),
            ),
          ),
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

    var text = Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "^ This guy is ${firstSize.width.round()} x ${firstSize.height.round()}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ));

    // Inflate the text widget
    var secondChild = inflate(text, id: #second);

    var secondSize = secondChild.layout(constraints
        .deflate(EdgeInsets.only(top: firstSize.height))
        .tighten(width: firstSize.width));

    secondChild.position(Offset(0, firstSize.height + 100));

    return Size(
      firstSize.width,
      firstSize.height + secondSize.height,
    );
  }
}
