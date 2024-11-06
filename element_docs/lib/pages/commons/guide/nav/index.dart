import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const Gap(50),
      const _Example(),
    ];
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 12);
    return Center(
      child: Column(
        children: [
          ElListener(
            onPointerDown: (e) {
              w('parent');
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.green,
              child: Center(
                child: ElStopPropagation(
                  child: ElListener(
                    onPointerDown: (e) {
                      i('child');
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      child: const Center(
                        child: ElText(
                          'ElListener, ElListener',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),
          ElTapBuilder(
            onTap: () {
              w('parent');
            },
            builder: (context) {
              return Container(
                width: 300,
                height: 300,
                color: Colors.green,
                child: Builder(builder: (context) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        i('child');
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.red,
                        child: const Center(
                          child: ElText(
                            'ElTapBuilder, GestureDetector',
                            style: textStyle,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          const Gap(8),
          GestureDetector(
            onLongPress: () {
              w('parent');
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.green,
              child: Center(
                child: ElTapBuilder(
                  onTap: () {
                    i('child');
                  },
                  builder: (context) => Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: const Center(
                      child: ElText(
                        'GestureDetector, ElTapBuilder',
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),
          GestureDetector(
            onTap: () {
              w('parent');
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.green,
              child: Center(
                child: AbsorbPointer(
                  child: GestureDetector(
                    onTap: () {
                      i('child');
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      child: const Center(
                        child: ElText(
                          'GestureDetector, GestureDetector',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  w('parent');
                },
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () {
                  i('child');
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.red,
                  child: const Center(
                    child: ElText(
                      'Stack - GestureDetector, GestureDetector',
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  w('parent');
                },
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.green,
                ),
              ),
              IgnorePointer(
                child: GestureDetector(
                  onTap: () {
                    i('child');
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: const Center(
                      child: ElText(
                        'Stack - GestureDetector, GestureDetector',
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  w('parent');
                },
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.green,
                ),
              ),
              IgnorePointer(
                child: ElTapBuilder(
                  onTap: () {
                    i('child');
                  },
                  builder: (context) => Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: const Center(
                      child: ElText(
                        'Stack - GestureDetector, GestureDetector',
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
