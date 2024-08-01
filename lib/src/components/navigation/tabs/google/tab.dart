part of 'tabs.dart';

/// 谷歌风格标签页离顶部有4px的间距
const double googleTabPaddingTop = 4.0;

class ElGoogleTab extends ElBaseTab {
  /// 子标签
  const ElGoogleTab({
    super.key,
    required super.title,
    super.disabled,
    super.closable,
  });

  @override
  Widget build(BuildContext context) {
    final $tabsData = TabsData.of(context);
    final $indexData = ElChildIndexData.of(context);
    return GestureDetector(
      onTapDown: (e) {
        $tabsData.modelValue.value = $indexData.index;
      },
      child: HoverBuilder(builder: (context) {
        return ColoredBox(
          color: HoverBuilder.of(context)
              ? context.isDark
                  ? context.elTheme.primary.light1(context)
                  : Colors.grey.shade100
              : Colors.transparent,
          child: Opacity(
            opacity: 0,
            child: _TabContent(title: title),
          ),
        );
      }),
    );
  }
}

/// 激活的标签页浮层
class _TabActiveLayer extends StatelessWidget {
  const _TabActiveLayer(this.size);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final $tabsData = TabsData.of(context);
    return AnimatedColoredBox(
      duration: el.config.colorDuration,
      color: context.isDark ? context.elTheme.primary : Colors.white,
      child: $tabsData.enabledAnimate
          ? AnimatedSize(
              duration: $tabsData.duration ?? el.config.globalDuration,
              curve: $tabsData.curve,
              child: SizedBox(
                width: size.width,
                height: size.height,
              ),
            )
          : SizedBox(width: size.width, height: size.height),
    );
  }
}

/// 标签文字浮层，它显示在最上层
class _TabTextLayer extends StatelessWidget {
  const _TabTextLayer(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final $tabsData = TabsData.of(context);
    final $googleTabsData = GoogleTabsData.of(context);
    final $indexData = ElChildIndexData.of(context);
    return Stack(
      children: [
        IgnorePointer(
          child: _TabContent(
            title: $tabsData.children.value[index].title,
          ),
        ),
        // Positioned(
        //   top: 0,
        //   bottom: 0,
        //   right: $googleTabsData.radius,
        //   child: Center(
        //     child: GestureDetector(
        //       onTap: () {
        //         i('close');
        //         final List<ElGoogleTab> newList =
        //             [...$tabsData.children.value].cast();
        //         newList.removeAt($indexData.index);
        //         $tabsData.children.value = newList;
        //       },
        //       child: HoverBuilder(
        //         cursor: SystemMouseCursors.click,
        //         builder: (context) {
        //           return Container(
        //               width: 16,
        //               height: 16,
        //               decoration: BoxDecoration(
        //                 color: HoverBuilder.of(context)
        //                     ? Colors.grey.shade400
        //                     : null,
        //                 borderRadius: BorderRadius.circular(8),
        //               ),
        //               child: const ElIcon(Icons.close, size: 14));
        //         },
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _TabContent extends ElBaseTab {
  const _TabContent({required super.title});

  @override
  Widget build(BuildContext context) {
    final $tabsData = TabsData.of(context);
    final $googleTabData = GoogleTabsData.of(context);
    final $indexData = ElChildIndexData.of(context);
    return UnconstrainedBox(
      child: SizedBox(
        height: $googleTabData.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: $googleTabData.radius),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: $tabsData.childMaxWidth - 80,
                ),
                child: ElText(
                  title,
                  style: TextStyle(
                    fontSize: $tabsData.fontSize,
                    fontWeight: ElFont.medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(8),
              GestureDetector(
                onTap: () {
                  i('close');
                  final List<ElGoogleTab> newList =
                  [...$tabsData.children.value].cast();
                  newList.removeAt($indexData.index);
                  $tabsData.children.value = newList;
                },
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: HoverBuilder.of(context) ? Colors.grey.shade400 : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const ElIcon(Icons.close, size: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
