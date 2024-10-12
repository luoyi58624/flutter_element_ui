part of 'index.dart';

class _ElTabsState extends ElModelValueState<ElTabs, int>
    with SingleTickerProviderStateMixin {
  @override
  Widget builder(BuildContext context) {
    var theme = ElTabsTheme.maybeOf(context) ?? context.elTheme.tabsTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: theme.size,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            ...widget.children.map(
              (e) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    ElText(e.title),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


