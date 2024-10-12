part of 'index.dart';

class _ElTabsState extends ElModelValueState<ElTabs, int>
    with SingleTickerProviderStateMixin {
  @override
  Widget builder(BuildContext context) {
    var theme = ElTabsTheme.of(context);
    return TabsInheritedWidget(
      prop: TabsProp(
        themeData: theme,
        children: widget.children,
      ),
      child: widget.child,
    );
  }
}
