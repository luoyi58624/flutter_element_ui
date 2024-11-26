import 'package:element_docs/global.dart';
import 'package:element_docs/main.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const Gap(50),
      // const FocusExample(),
      const Gap(8),
      // const FocusScope(child: FocusExample2()),
      //
      // _Demo(
      //   child: LookupBoundary(
      //     child: Builder(
      //       builder: (context) {
      //         // i(_Demo.of(context));
      //         i(LookupBoundary.findAncestorWidgetOfExactType<_Demo>(context));
      //         return Container();
      //       }
      //     ),
      //   ),
      // ),

      ElFocusScope(
        child: Column(
          children: [
            ElEvent(
              builder: (context) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Focus.maybeOf(context)?.hasFocus == true
                      ? Colors.green
                      : Colors.grey,
                );
              },
            ),
            const Gap(8),
            ElEvent(
              builder: (context) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Focus.maybeOf(context)?.hasFocus == true
                      ? Colors.green
                      : Colors.grey,
                );
              },
            ),
          ],
        ),
      ),
      // ElEvent(
      //   onPointerDown: (e) {
      //     i(e.buttons);
      //     if (e.buttons == kBackMouseButton) {
      //       i('鼠标返回');
      //     } else if (e.buttons == kForwardMouseButton) {
      //       i('鼠标前进');
      //     }
      //   },
      //   child: Builder(builder: (context) {
      //     return Container(
      //       width: 200,
      //       height: 200,
      //       alignment: Alignment.center,
      //       color: Colors.grey,
      //     );
      //   }),
      // ),

      // const _Example(),
    ];
  }
}

class _Demo extends InheritedWidget {
  const _Demo({
    super.key,
    required super.child,
  });

  static _Demo of(BuildContext context) {
    final _Demo? result = context.dependOnInheritedWidgetOfExactType<_Demo>();
    assert(result != null, 'No _Demo found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_Demo oldWidget) {
    return false;
  }
}

class FocusExample extends StatefulWidget {
  const FocusExample({super.key});

  @override
  State<FocusExample> createState() => _FocusExampleState();
}

class _FocusExampleState extends State<FocusExample> {
  final focus = FocusNode();
  final focus2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focus.hasFocus ? focus.unfocus() : focus.requestFocus();
        setState(() {});
      },
      child: Focus(
        focusNode: focus,
        canRequestFocus: false,
        child: Builder(
          builder: (context) {
            return Container(
              width: 300,
              height: 300,
              color: focus.hasFocus ? Colors.green : Colors.grey,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    focus2.hasFocus ? focus2.unfocus() : focus2.requestFocus();
                    setState(() {});
                  },
                  child: Focus(
                    focusNode: focus2,
                    child: Builder(
                      builder: (context) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: focus2.hasFocus
                              ? Colors.blue
                              : Colors.grey.shade300,
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FocusExample2 extends StatefulWidget {
  const FocusExample2({super.key});

  @override
  State<FocusExample2> createState() => _FocusExample2State();
}

class _FocusExample2State extends State<FocusExample2> {
  final focus = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: focus.hasFocus ? Colors.red : Colors.grey.shade100,
      child: InkWell(
        focusNode: focus,
        onTap: () {
          focus.hasFocus ? focus.unfocus() : focus.requestFocus();
          setState(() {});
        },
        child: Builder(
          builder: (context) {
            return SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Material(
                  color: focus2.hasFocus ? Colors.green : Colors.grey.shade200,
                  child: InkWell(
                    focusNode: focus2,
                    onTap: () {
                      focus2.hasFocus
                          ? focus2.unfocus()
                          : focus2.requestFocus();
                      setState(() {});
                    },
                    child: Builder(
                      builder: (context) {
                        return SizedBox(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Material(
                              color: focus3.hasFocus
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              child: InkWell(
                                focusNode: focus3,
                                onTap: () {
                                  focus3.hasFocus
                                      ? focus3.unfocus()
                                      : focus3.requestFocus();
                                  setState(() {});
                                },
                                child: Builder(
                                  builder: (context) {
                                    return const SizedBox(
                                      width: 100,
                                      height: 100,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Example extends StatefulHookWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(vsync: this);
  final flag = Obs(false);
  final position = Obs(Offset.zero);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      position.value = Offset(
        position.value.dx,
        position.value.dy + controller.value,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(50),
          Draggable(
            rootOverlay: true,
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 50,
          ),
          DragTarget(
            // onWillAcceptWithDetails: (e)
            builder: (context, _, __) => Container(
              height: 100,
              color: Colors.grey.shade200,
            ),
          ),
        ],
      );
    });
  }
}
