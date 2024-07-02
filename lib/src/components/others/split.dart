import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ElSplitPanel extends StatefulWidget {
  const ElSplitPanel({
    super.key,
    required this.children,
    this.horizontal = true,
  }) : assert(children.length == 0, '必须包含两个子节点');

  /// 需要分割的子节点
  final List<Widget> children;

  /// 是否水平布局，默认true
  final bool horizontal;

  @override
  State<ElSplitPanel> createState() => _ElSplitPanelState();
}

class _ElSplitPanelState extends State<ElSplitPanel> {
  final isActive = Obs(false);
  final width = Obs(200.0);

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Row(
        children: [
          ObsBuilder(builder: (context) {
            return Container(
              width: width.value,
              color: Colors.green,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    1000,
                    (index) => ElButton(
                      onPressed: () {},
                      child: '按钮 - ${index + 1}',
                    ),
                  ),
                ),
              ),
            );
          }),
          buildResizeWidget(),
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResizeWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 1,
          height: double.infinity,
          color: Colors.yellow,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: -10,
          right: -10,
          child: DeferPointer(
            paintOnTop: true,
            child: GestureDetector(
              onHorizontalDragStart: (e) {
                isActive.value = true;
              },
              onHorizontalDragUpdate: (e) {
                if (isActive.value) {
                  width.value += e.delta.dx;
                }
              },
              onHorizontalDragEnd: (e) {
                isActive.value = false;
              },
              onHorizontalDragCancel: () {
                isActive.value = false;
              },
              child: HoverBuilder(
                cursor: SystemMouseCursors.resizeColumn,
                builder: (isHover) {
                  return ObsBuilder(builder: (context) {
                    return Container(
                      color: isActive.value ? Colors.cyan : null,
                    );
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
