import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

part 'aside.dart';

part 'header.dart';

part 'main.dart';

part 'footer.dart';

/// Element UI 布局组件抽象类
abstract class ElLayoutWidget extends StatelessWidget {
  const ElLayoutWidget({super.key});
}

/// Element UI 布局容器组件，它的作用是自动调整内部布局容器的位置，如果子元素中包含
/// [ElHeader]、[ElFooter]，那么所有内容将会以垂直上下排列，否则会水平左右排列。
class ElLayout extends ElLayoutWidget {
  const ElLayout({super.key, required this.children});

  /// 布局子类组件，通过组合 [ElLayout]、[ElAside]、[ElHeader]、[ElMain]、[ElFooter]
  /// 等布局组件可以快速搭建页面结构。
  final List<ElLayoutWidget> children;

  List<Widget> get _childrenWidget => children.map((e) {
        if (e is ElLayout) {
          return Expanded(child: e);
        } else {
          return e;
        }
      }).toList();

  @override
  Widget build(BuildContext context) {
    late Widget currentWidget;
    if (children.any((e) => e is ElHeader || e is ElFooter)) {
      assert(children.any((e) => e is ElAside) == false,
          'ElAside不可以和ElHeader、ElFooter放在同一容器');
      currentWidget = Column(children: _childrenWidget);
    } else {
      currentWidget = Row(children: _childrenWidget);
    }
    return currentWidget;
  }
}
