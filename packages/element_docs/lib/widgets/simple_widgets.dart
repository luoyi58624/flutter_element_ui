import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

/// 标题间距
const Widget titleGap = Gap(36);

/// 普通文字间距
const Widget textGap = Gap(20);

const Widget arrowRightWidget = Icon(Icons.keyboard_arrow_right);

class SectionTitle extends StatelessWidget {
  /// 段落标题，只能用于 [ResponsivePage] 页面中
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleGap,
        // ElLink(
        //   href: '${ResponsivePageData.of(context).path}#$title',
        //   child: ElAnchor(
        //     name: title,
        //     child: H2(
        //       title,
        //       style: TextStyle(
        //         color: context.isDark
        //             ? Colors.grey.shade300
        //             : Colors.grey.shade800,
        //       ),
        //     ),
        //   ),
        // ),
        ElAnchor(
          name: title,
          child: ElAnimatedDefaultTextStyle(
            style: TextStyle(
              color:
                  context.isDark ? Colors.grey.shade300 : Colors.grey.shade800,
            ),
            child: H2(
              title,
            ),
          ),
        ),
        textGap,
      ],
    );
  }
}

class SectionText extends StatelessWidget {
  /// 段落文本
  const SectionText(this.text, {super.key});

  final dynamic text;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElText(text),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    this.type = El.primary,
    required this.title,
    required this.content,
  });

  final String type;
  final String title;
  final List<dynamic> content;

  @override
  Widget build(BuildContext context) {
    Widget result = ElDefaultTextStyle(
      style: const TextStyle(
        fontFamily: MyFonts.consolas,
        fontSize: 15,
        height: 1.5,
      ),
      child: AnimatedContainer(
        duration: context.elDuration(),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: context.elThemeColors[type]!.elLight9(context),
          borderRadius: context.elConfig.cardRadius!,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H4(title),
            const Gap(8),
            ...content.map((e) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: e is Widget ? e : ElText(e),
              );
            }),
          ],
        ),
      ),
    );

    result = SelectionArea(
      child: result,
    );

    return Stack(
      children: [
        result,
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: context.elConfig.cardRadius!.bottomLeft.x,
            decoration: BoxDecoration(
              color: context.elThemeColors[type],
              borderRadius: BorderRadius.only(
                topLeft: context.elConfig.cardRadius!.topLeft,
                bottomLeft: context.elConfig.cardRadius!.bottomLeft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlutterHookTip extends StatelessWidget {
  const FlutterHookTip(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Tip',
      content: [
        ElText([
          '$name 支持双向绑定，推荐你使用 ',
          LinkWidgets.flutterHook,
          ' 代替 StatefulWidget',
        ]),
      ],
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
    this.elevation,
  });

  final String? title;
  final List<Widget> children;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: context.elTheme.cardTheme.color,
      elevation: elevation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: H4(title!),
            ),
          Column(children: children),
        ],
      ),
    );
  }
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.children,
    this.center = true,
    this.scroll = false,
    this.repaintBoundary = true,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final List<Widget> children;
  final bool center;
  final bool scroll;
  final bool repaintBoundary;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    Widget result = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
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
