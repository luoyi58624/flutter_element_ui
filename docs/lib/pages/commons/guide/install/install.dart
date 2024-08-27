import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class InstallPage extends HookWidget {
  const InstallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);

    Widget result = InkWell(
      onTap: () {
        count.value++;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: ElText('count: ${count.value}'),
      ),
    );
    return Center(
      // child: Material(
      //   type: MaterialType.transparency,
      //   borderRadius: BorderRadius.circular(6),
      //   clipBehavior: Clip.hardEdge,
      //   child:
      // ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipPath(
          clipBehavior: Clip.hardEdge,
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: result,
        ),
      ),
    );
  }
}
