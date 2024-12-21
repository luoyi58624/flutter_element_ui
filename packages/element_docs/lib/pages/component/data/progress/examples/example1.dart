import 'dart:math';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    final color = ProgressPage.colors[(progress.value / 10).toInt()];

    return Column(
      children: [
        Row(
          children: [
            ElButton(
              onPressed: () {
                progress.value = max(0, progress.value - 10);
              },
              child: '-10',
            ),
            const Gap(8),
            ElButton(
              onPressed: () {
                progress.value = min(100, progress.value + 10);
              },
              child: '+10',
            ),
          ],
        ),
        ElProgress(
          progress.value,
          color: color,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
        ),
        const ElProgress(20),
        const ElProgress(40, color: Colors.green),
        const ElProgress(60, color: Colors.orange),
        const ElProgress(80, color: Colors.red),
        const ElProgress(100, color: Colors.cyan),
      ],
    );
  }
}

String get code => '''
List<Color?> colors = [
  null,
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.grey,
  Colors.indigo,
  Colors.purpleAccent,
];

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    final color = colors[(progress.value / 10).toInt()];
    
    return Column(
      children: [
        Row(
          children: [
            ElButton(
              onPressed: () {
                progress.value = max(0, progress.value - 10);
              },
              child: '-10',
            ),
            const Gap(8),
            ElButton(
              onPressed: () {
                progress.value = min(100, progress.value + 10);
              },
              child: '+10',
            ),
          ],
        ),
        ElProgress(
          progress.value,
          color: color,
          duration: const Duration(milliseconds: 600),
          valueCurve: Curves.ease,
        ),
        const ElProgress(20),
        const ElProgress(40, color: Colors.green),
        const ElProgress(60, color: Colors.orange),
        const ElProgress(80, color: Colors.red),
        const ElProgress(100, color: Colors.cyan),
      ],
    );
  }
}''';

String get code1 => '''
import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/drag_resizer.dart';

class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({Key? key}) : super(key: key);

  @override
  GradientCircularProgressRouteState createState() {
    return  GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: <Widget>[
                          GradientCircularProgressIndicator(
                            // No gradient
                            colors: const [Colors.blue, Colors.blue],
                            radius: 50.0,
                            stokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: const [Colors.red, Colors.orange],
                            radius: 50.0,
                            stokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: const [Colors.red, Colors.orange, Colors.red],
                            radius: 50.0,
                            stokeWidth: 5.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: const [Colors.teal, Colors.cyan],
                            radius: 50.0,
                            stokeWidth: 5.0,
                            strokeCapRound: true,
                            value: CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.decelerate,
                            ).value,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressIndicator(
                              colors: const [Colors.red, Colors.orange, Colors.red],
                              radius: 50.0,
                              stokeWidth: 5.0,
                              strokeCapRound: true,
                              backgroundColor: Colors.red.shade50,
                              totalAngle: 1.5 * pi,
                              value: CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.ease,
                              ).value,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade200
                              ],
                              radius: 50.0,
                              stokeWidth: 3.0,
                              strokeCapRound: true,
                              backgroundColor: Colors.transparent,
                              value: _animationController.value,
                            ),
                          ),
                          GradientCircularProgressIndicator(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green.shade200,
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            stokeWidth: 5.0,
                            strokeCapRound: true,
                            value: _animationController.value,
                          ),
                        ],
                      ),
                      GradientCircularProgressIndicator(
                        colors: [Colors.blue.shade700, Colors.blue.shade200],
                        radius: 100.0,
                        stokeWidth: 20.0,
                        value: _animationController.value,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: GradientCircularProgressIndicator(
                          colors: [Colors.blue.shade700, Colors.blue.shade300],
                          radius: 100.0,
                          stokeWidth: 20.0,
                          value: _animationController.value,
                          strokeCapRound: true,
                        ),
                      ),
                      //剪裁半圆
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              //width: 100.0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan.shade500],
                                  radius: 100.0,
                                  stokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.0,
                        width: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              height: 200.0,
                              top: .0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan.shade500],
                                  radius: 100.0,
                                  stokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "\${(_animationController.value * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}''';
