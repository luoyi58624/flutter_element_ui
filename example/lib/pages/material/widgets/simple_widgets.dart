import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

/// 构建通用的[ListTile]组件
Widget buildCellWidget(
  BuildContext context, {
  required String title,
  bool dense = true,
  Widget trailing = arrowRightWidget,
  GestureTapCallback? onTap,
  Widget? page,
  Widget? leading,
  Color? tileColor,
}) {
  return ListTile(
    onTap: onTap == null && page == null
        ? null
        : () {
            if (onTap != null) {
              onTap();
            } else {
              context.push(page!);
            }
          },
    dense: dense,
    leading: leading,
    trailing: arrowRightWidget,
    tileColor: tileColor,
    title: Text(
      title,
      style: TextStyle(
        fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize,
      ),
    ),
  );
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
      itemBuilder: (context, index) => buildCellWidget(
        context,
        onTap: () {},
        title: '列表-${index + 1}',
      ),
    );
  }
}

Widget buildCardWidget(
  BuildContext context, {
  String? title,
  List<Widget> children = const [],
}) {
  return Card(
    clipBehavior: Clip.hardEdge,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(title,
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
  const ColumnWidget({super.key, required this.children, this.center = true});

  final List<Widget> children;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return center
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          );
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
