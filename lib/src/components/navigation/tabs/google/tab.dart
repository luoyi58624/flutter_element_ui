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
    final $indexData = ChildIndexData.of(context);
    return GestureDetector(
      onTapDown: (e) {
        $tabsData.modelValue.value = $indexData.index;
      },
      child: ElHoverBuilder(builder: (context) {
        return ColoredBox(
          color: ElHoverBuilder.of(context)
              ? context.isDark
                  ? context.elTheme.primary.elLight1()
                  : Colors.grey.shade100
              : Colors.transparent,
          child: _TabContent($indexData.index, title: title),
        );
      }),
    );
  }
}

/// 激活的标签页浮层
class _TabActiveLayer extends StatelessWidget {
  const _TabActiveLayer(this.index, this.size, this.tab);

  final int index;
  final Size size;
  final ElBaseTab tab;

  @override
  Widget build(BuildContext context) {
    return AnimatedColoredBox(
      duration: context.elConfig.themeDuration,
      color: context.isDark ? context.elTheme.primary : Colors.white,
      child: SizedBox.fromSize(
        size: size,
        child: _TabContent(index, title: tab.title),
      ),
    );
  }
}

class _TabContent extends ElBaseTab {
  const _TabContent(this.index, {required super.title});

  final int index;

  @override
  Widget build(BuildContext context) {
    final $tabsData = TabsData.of(context);
    final $googleTabData = GoogleTabsData.of(context);
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
                  final List<ElGoogleTab> tabList =
                      [...$tabsData.children.value].cast();
                  if ($tabsData.children.value.length == 1) return;
                  final activeIndex = $tabsData.modelValue.value;
                  if (index == activeIndex) {
                    if (activeIndex == tabList.length - 1) {
                      $tabsData.modelValue.value = tabList.length - 2;
                    }
                  } else {
                    if (index < activeIndex) {
                      $tabsData.modelValue.value -= 1;
                    }
                  }
                  tabList.removeAt(index);
                  $tabsData.children.value = tabList;
                },
                child: ElHoverBuilder(builder: (context) {
                  return Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: ElHoverBuilder.of(context)
                          ? Colors.grey.shade400
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const ElIcon(Icons.close, size: 14),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
