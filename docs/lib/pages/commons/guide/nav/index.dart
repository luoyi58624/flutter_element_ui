import 'package:boxy/boxy.dart';
import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'test.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final count = useState(0);

    final disabled = useState(false);
    final loading = useState(false);

    final childWidth = useObs(0.0);
    final username = useState('');
    return [
      // ElButton(
      //   onPressed: () {
      //     count.value++;
      //   },
      //   child: ElText('count: ${count.value}'),
      // ),
      // ElevatedButton(
      //   onPressed: () {
      //     count.value++;
      //   },
      //   child: Text('count: ${count.value}'),
      // ),
      // const Gap(8),
      ElButton2(
        onPressed: () {
          count.value++;
        },
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),

      ElButton2(
        onPressed: () {
          count.value++;
        },
        type: 'primary',
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),
      // ElButton2(
      //   onPressed: () {
      //     disabled.value = true;
      //     () {
      //       disabled.value = false;
      //     }.delay(1500);
      //   },
      //   disabled: disabled.value,
      //   child: ElText('count: ${count.value}'),
      // ),
      // const Gap(8),

      // ElSizeBuilder(
      //   delay: 100,
      //   builder: (context, size) {
      //     return ElButton2(
      //       onPressed: () {
      //         loading.value = true;
      //         () {
      //           loading.value = false;
      //         }.delay(1500);
      //       },
      //       loading: loading.value,
      //       child: ElText('$size'),
      //     );
      //   },
      // ),

      const Gap(8),
      GestureDetector(
        onTapDown: (e) {
          loading.value = true;
        },
        onTapUp: (e) {
          loading.value = false;
        },
        onTapCancel: () {
          loading.value = false;
        },
        child: ElAnimateSize(
          onChanged: (size) {
            i(size);
            childWidth.value = size.width / 2;
          },
          child: AnimatedContainer(
            duration: 300.ms,
            height: 100,
            width: loading.value ? 500 : 50,
            color: Colors.green,
            child: ObsBuilder(builder: (context) {
              return UnconstrainedBox(
                child: Container(
                  width: childWidth.value,
                  height: 50,
                  color: Colors.red,
                ),
              );
            }),
          ),
        ),
      ),

      // LayoutBuilder(builder: (builder))

      // GestureDetector(
      //   onTap: () {
      //     loading.value = !loading.value;
      //   },
      //   child: ColoredBox(
      //     color: Colors.green,
      //     child: ElAnimateSizedBox(
      //       child: SizedBox(
      //         height: 100,
      //         width: loading.value ? 200 : 100,
      //       ),
      //     ),
      //   ),
      // ),
      const Gap(8),
      ElInput(username),
      const Gap(8),
      Test(username.value),
    ];
  }
}

