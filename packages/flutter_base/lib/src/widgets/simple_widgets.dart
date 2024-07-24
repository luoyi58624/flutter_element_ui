import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/extensions/router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

const Widget arrowRightWidget = Icon(Icons.keyboard_arrow_right);

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.size = 16, this.color});

  final double size;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({
    super.key,
    required this.title,
    this.dense = true,
    this.trailing = arrowRightWidget,
    this.leading,
    this.tileColor,
    this.page,
    this.onTap,
    this.value,
    this.onChanged,
  });

  final String title;
  final bool dense;
  final Widget trailing;
  final Widget? leading;
  final Color? tileColor;
  final Widget? page;
  final GestureTapCallback? onTap;

  /// Switch 开关 Cell
  final bool? value;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onChanged != null && value != null
          ? () {
              onChanged!(!value!);
            }
          : (onTap == null && page == null
              ? null
              : () {
                  if (onTap != null) {
                    onTap!();
                  } else {
                    context.push(page!);
                  }
                }),
      dense: dense,
      leading: leading,
      trailing: value == null
          ? trailing
          : Switch.adaptive(
              value: value!,
              onChanged: onChanged,
            ),
      tileColor: tileColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize,
        ),
      ),
    );
  }
}

class ListViewDemoWidget extends HookWidget {
  const ListViewDemoWidget({
    super.key,
    this.itemCount = 1000,
    this.physics,
  });

  final int? itemCount;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return SuperListView.builder(
      controller: controller,
      itemCount: itemCount,
      physics: physics,
      itemBuilder: (context, index) => CellWidget(
        onTap: () {},
        title: '列表-${index + 1}',
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.title,
    this.children = const [],
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: context.elTheme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            ),
          Column(children: children),
        ],
      ),
    );
  }
}

Widget buildPopupMenuButton({
  Offset? offset,
}) {
  return PopupMenuButton(
    elevation: 2,
    offset: const Offset(0, 50),
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
      const PopupMenuItem(
        child: Text('MaterialApp'),
      ),
      const PopupMenuItem(
        child: Text('CupertinoApp'),
      ),
      const PopupMenuItem(
        child: Text('重启App'),
      ),
    ],
  );
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.children,
    this.center = true,
    this.scroll = false,
    this.repaintBoundary = true,
    this.padding,
  });

  final List<Widget> children;
  final bool center;
  final bool scroll;

  /// 添加滚动绘制边界，滚动过程中会导致内部所有元素引起重绘，开启此属性可以提升滚动性能
  final bool repaintBoundary;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget result = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    if (padding != null) {
      result = Padding(
        padding: padding!,
        child: result,
      );
    }
    if (scroll) {
      if (repaintBoundary) {
        result = RepaintBoundary(child: result);
      }
      result = SingleChildScrollView(child: result);
    } else if (center) {
      result = Center(
        child: result,
      );
    }
    return result;
  }
}

Widget buildBoxWidget({
  double width = 36,
  double height = 36,
  double radius = 4,
  Color color = Colors.grey,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
    ),
  );
}

/// 构建ios loading
Widget buildCupertinoLoading({
  double radius = 16,
  bool animating = true,
  Color? color,
}) =>
    CupertinoActivityIndicator(
      animating: animating,
      radius: radius,
      color: color,
    );

/// ios加载loading预设
class CupertinoLoadingPreset {
  CupertinoLoadingPreset._();

  static const Widget mini = CupertinoActivityIndicator(
    animating: true,
    radius: 8,
  );

  static const Widget small = CupertinoActivityIndicator(
    animating: true,
    radius: 12,
  );

  static const Widget medium = CupertinoActivityIndicator(
    animating: true,
    radius: 16,
  );

  static const Widget large = CupertinoActivityIndicator(
    animating: true,
    radius: 20,
  );
}
