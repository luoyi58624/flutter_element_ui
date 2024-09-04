import 'package:docs/global.dart';
import 'package:docs/utils/animate.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../responsive_page.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final flag = useState(false);
    final flag2 = useState(false);
    final flag3 = useState(false);
    return [
      // HoverBuilder(builder: (context) {
      //   return AnimatedContainer(
      //     duration: context.elThemeDuration ?? Duration.zero,
      //     width: 100,
      //     height: 100,
      //     color: context.isHover
      //         ? Colors.red
      //         : context.isDark
      //             ? Colors.blue
      //             : Colors.green,
      //   );
      // }),
      ElSwitch(flag),
      ElSwitch(flag2),
      ElSwitch(flag3),
      // _Text(TextStyle(
      //   fontSize: flag.value ? 28 : 16,
      //   color: context.isDark ? Colors.red : Colors.black,
      // )),
      // ElAnimateText(
      //   '这是一段文字' * 10000,
      //   style: TextStyle(
      //     fontSize: flag.value ? 28 : 16,
      //     color: context.isDark ? Colors.red : Colors.black,
      //   ),
      // ),
      // Wrap(
      //   children: Text(
      //     '这是一段文字',
      //     style: TextStyle(
      //       fontSize: flag.value ? 28 : 16,
      //       // color: context.isDark ? Colors.red : Colors.black,
      //     ),
      //   ) *
      //       1000,
      // ),
      // Wrap(
      //   children: ElText(
      //     '这是一段文字',
      //     style: TextStyle(
      //       fontSize: flag.value ? 28 : 16,
      //       // color: context.isDark ? Colors.red : Colors.black,
      //     ),
      //   ) *
      //       1000,
      // ),
      // flag2.value
      //     ? AnimatedDefaultTextStyle(
      //         duration: el.config.themeDuration,
      //         style: TextStyle(
      //           fontSize: flag.value ? 28 : 16,
      //           color: context.isDark ? Colors.red : Colors.black,
      //         ),
      //         child: Text(
      //           '这是一段文字' * 10000,
      //         ),
      //       )
      //     : ElAnimateText(
      //         '这是一段文字' * 10000,
      //         style: TextStyle(
      //           fontSize: flag.value ? 28 : 16,
      //           color: context.isDark ? Colors.green : Colors.black,
      //         ),
      //       ),
      flag3.value
          ?
          // AnimatedDefaultTextStyle(
          //         duration: el.config.themeDuration,
          //         style: TextStyle(
          //           fontSize: flag.value ? 28 : 16,
          //           color: context.isDark ? Colors.red : Colors.black,
          //         ),
          //         child: Builder(builder: (context) {
          //           return Wrap(
          //             children: RichText(
          //                   text: TextSpan(
          //                       text: '这是一段文字',
          //                       style: DefaultTextStyle.of(context).style),
          //                 ) *
          //                 1000,
          //           );
          //         }),
          //       )
          AnimatedDefaultTextStyle(
              duration: el.config.themeDuration,
              style: TextStyle(
                fontSize: flag.value ? 28 : 16,
                color: context.isDark ? Colors.red : Colors.black,
              ),
              child: Text(
                '这是一段文字' * 10000,
              ),
            )
          : ElAnimatedDefaultTextStyle(
              duration: el.config.themeDuration,
              style: TextStyle(
                fontSize: flag.value ? 28 : 16,
                color: context.isDark ? Colors.yellow : Colors.black,
              ),
              child: Wrap(
                children: const ElText('这是一段文字') * 1000,
              ),
            ),

      // Wrap(
      //     children: ElAnimateText(
      //           '这是一段文字',
      //           style: TextStyle(
      //             fontSize: flag.value ? 28 : 16,
      //             color: context.isDark ? Colors.yellow : Colors.black,
      //           ),
      //         ) *
      //         1000,
      //   ),
    ];
  }
}

extension _Ext on Widget {
  List<Widget> operator *(int other) {
    return List.generate(other, (index) => this);
  }
}

class _Text extends StatefulWidget {
  const _Text(this.style);

  final TextStyle style;

  @override
  State<_Text> createState() => _TextState();
}

class _TextState extends State<_Text> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: el.config.themeDuration,
  )..addListener(() {
      _style = styleAnimate.value;
    });

  TextStyle? _style;

  late Animation<TextStyle> styleAnimate = controller.createAnimate(
    tween: TextStyleTween(begin: widget.style),
  );

  @override
  void didUpdateWidget(covariant _Text oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style) {
      i(widget.style.fontSize);
      styleAnimate = controller.createAnimate(
        tween: TextStyleTween(
          begin: _style ?? oldWidget.style,
          end: widget.style,
        ),
      );
      controller.forward(from: 0);
    }
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();

    FlutterUtil.nextTick(() {
      controller.duration = el.config.themeDuration;
      i(controller.duration);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.view,
      builder: (context, child) {
        return ElAnimateText(
          'hello',
          style: styleAnimate.value,
        );
      },
    );
  }
}
