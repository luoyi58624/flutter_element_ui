import 'dart:math';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Example5 extends HookWidget {
  const Example5({super.key, required this.title});

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

String _svg = '''
<svg t="1727403412605" class="icon" viewBox="0 0 1104 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6189" width="200" height="200">
  <path d="M285.80095 16.245436l178.931809 179.135953H639.989984L819.125937 16.347508a55.220826 55.220826 0 0 1 78.084902 78.084902L796.159789 195.381389h115.239026a193.936359 193.936359 0 0 1 193.426 193.323928v441.970755a193.936359 193.936359 0 0 1-193.426 193.323928H193.323928A193.323928 193.323928 0 0 1 0 830.676072v-441.970755a193.323928 193.323928 0 0 1 193.323928-193.323928h115.136954l-100.948978-101.05105A55.220826 55.220826 0 1 1 285.80095 16.245436zM911.398815 306.231329H193.323928a82.780204 82.780204 0 0 0-82.473988 74.818606v449.932352a82.882275 82.882275 0 0 0 74.920677 82.473988h725.628198a82.780204 82.780204 0 0 0 82.473988-74.818605V388.705317A82.780204 82.780204 0 0 0 911.398815 306.231329zM331.42703 471.587593a55.220826 55.220826 0 0 1 55.220826 55.220826v110.543725a55.220826 55.220826 0 0 1-110.441652 0V526.808419a55.220826 55.220826 0 0 1 55.220826-55.220826z m441.868683 0a55.322898 55.322898 0 0 1 55.322898 55.220826v110.543725a55.322898 55.322898 0 0 1-110.543724 0V526.808419a55.220826 55.220826 0 0 1 55.220826-55.220826z" 
        fill="#515151" p-id="6190"></path>
</svg>
''';

/// 在 [进度条交互] 示例基础上实现简易的视频进度条
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          progress.value = e.localPosition.dx / constraints.maxWidth * 100;
          isDrag.value = true;
        },
        onHorizontalDragUpdate: (e) {
          final value = e.localPosition.dx / constraints.maxWidth * 100;
          progress.value = min(100, max(value, 0));
        },
        onHorizontalDragEnd: (e) {
          isDrag.value = false;
        },
        onHorizontalDragCancel: () {
          isDrag.value = false;
        },
        child: HoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ElProgress(
                  progress.value,
                  duration: Duration.zero,
                  strokeSize: isHover || isDrag.value ? 6 : 2,
                  round: false,
                  radius: 2,
                ),
                Positioned(
                  left: progress.value * constraints.maxWidth / 100 - 8,
                  top: -1,
                  child: AnimatedSwitcher(
                    duration: 200.ms,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: isHover || isDrag.value
                        ? Container(
                            color: Colors.white,
                            child: SvgPicture.string(
                              _svg,
                              width: 16,
                              height: 16,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

String get code => """
String _svg = '''
<svg t="1727403412605" class="icon" viewBox="0 0 1104 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6189" width="200" height="200">
  <path d="M285.80095 16.245436l178.931809 179.135953H639.989984L819.125937 16.347508a55.220826 55.220826 0 0 1 78.084902 78.084902L796.159789 195.381389h115.239026a193.936359 193.936359 0 0 1 193.426 193.323928v441.970755a193.936359 193.936359 0 0 1-193.426 193.323928H193.323928A193.323928 193.323928 0 0 1 0 830.676072v-441.970755a193.323928 193.323928 0 0 1 193.323928-193.323928h115.136954l-100.948978-101.05105A55.220826 55.220826 0 1 1 285.80095 16.245436zM911.398815 306.231329H193.323928a82.780204 82.780204 0 0 0-82.473988 74.818606v449.932352a82.882275 82.882275 0 0 0 74.920677 82.473988h725.628198a82.780204 82.780204 0 0 0 82.473988-74.818605V388.705317A82.780204 82.780204 0 0 0 911.398815 306.231329zM331.42703 471.587593a55.220826 55.220826 0 0 1 55.220826 55.220826v110.543725a55.220826 55.220826 0 0 1-110.441652 0V526.808419a55.220826 55.220826 0 0 1 55.220826-55.220826z m441.868683 0a55.322898 55.322898 0 0 1 55.322898 55.220826v110.543725a55.322898 55.322898 0 0 1-110.543724 0V526.808419a55.220826 55.220826 0 0 1 55.220826-55.220826z"
        fill="#515151" p-id="6190"></path>
</svg>
''';

/// 在 [进度条交互] 示例基础上实现简易的视频进度条
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          progress.value = e.localPosition.dx / constraints.maxWidth * 100;
          isDrag.value = true;
        },
        onHorizontalDragUpdate: (e) {
          final value = e.localPosition.dx / constraints.maxWidth * 100;
          progress.value = min(100, max(value, 0));
        },
        onHorizontalDragEnd: (e) {
          isDrag.value = false;
        },
        onHorizontalDragCancel: () {
          isDrag.value = false;
        },
        child: HoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ElProgress(
                  progress.value,
                  duration: Duration.zero,
                  strokeSize: isHover || isDrag.value ? 6 : 2,
                  round: false,
                  radius: 2,
                ),
                Positioned(
                  left: progress.value * constraints.maxWidth / 100 - 8,
                  top: -1,
                  child: AnimatedSwitcher(
                    duration: 200.ms,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: isHover || isDrag.value
                        ? Container(
                            color: Colors.white,
                            child: SvgPicture.string(
                              _svg,
                              width: 16,
                              height: 16,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}""";
