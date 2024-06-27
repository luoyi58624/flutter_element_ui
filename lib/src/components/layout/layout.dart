import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

part 'aside.dart';

part 'header.dart';

part 'main.dart';

part 'footer.dart';

part 'split.dart';

/// Element UI 布局组件抽象类
abstract class ElLayoutWidget extends StatelessWidget {
  const ElLayoutWidget({super.key});
}

/// Element UI 布局容器组件，它的作用是自动调整内部布局容器的位置，如果子元素中包含
/// [ElHeader]、[ElFooter]，那么所有内容将会以垂直上下排列，否则会水平左右排列。
class ElLayout extends ElLayoutWidget {
  /// 布局组件，通过不同组合快速构建页面，例如：
  /// * 上下布局
  /// ```dart
  /// ElLayout(children: [
  ///   ElHeader(child: SizedBox()),
  ///   ElMain(child: SizedBox()),
  /// ]);
  /// ```
  /// * 左右布局
  /// ```dart
  /// ElLayout(children: [
  ///   ElAside(child: SizedBox()),
  ///   ElMain(child: SizedBox()),
  /// ]);
  /// ```
  /// * 包含头部、侧边栏、主页面布局
  /// ```dart
  /// ElLayout(children: [
  ///   ElHeader(child: SizedBox()),
  ///   ElLayout(children: [
  ///     ElAside(child: SizedBox()),
  ///     ElMain(child: SizedBox()),
  ///   ]),
  /// ]);
  /// ```
  /// * 或者侧边栏独占整个高度
  /// ```dart
  /// ElLayout(children: [
  ///   ElAside(child: SizedBox()),
  ///   ElLayout(children: [
  ///     ElHeader(child: SizedBox()),
  ///     ElMain(child: SizedBox()),
  ///   ]),
  /// ]);
  /// ```
  const ElLayout({super.key, required this.children});

  /// 布局子类组件
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
      currentWidget = _ElLayoutInheritedWidget(
        isColumn: true,
        child: Column(children: _childrenWidget),
      );
    } else {
      currentWidget = _ElLayoutInheritedWidget(
        isColumn: false,
        child: Row(children: _childrenWidget),
      );
    }
    return currentWidget;
  }
}

/// 注入布局数据
class _ElLayoutInheritedWidget extends InheritedWidget {
  const _ElLayoutInheritedWidget({
    required super.child,
    required this.isColumn,
  });

  /// 当前布局是否是垂直布局
  final bool isColumn;

  static _ElLayoutInheritedWidget of(BuildContext context) {
    final _ElLayoutInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ElLayoutInheritedWidget>();
    assert(result != null, '当前上下文没有找到 ElLayout 组件，请将 ElSplit 放置在 ElLayout 组件中');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElLayoutInheritedWidget oldWidget) => false;
}
