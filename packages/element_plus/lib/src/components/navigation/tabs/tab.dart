part of 'index.dart';

class ElTab extends StatelessWidget {
  /// 最简单的 Tab 子项实现，默认实现基于 [ElTag] 标签
  const ElTab({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final $key = key as ValueKey<int>;
    final $theme = ElTabsTheme.of(context);
    final $data = ElTabs.of(context);

    return ElEvent(builder: (context) {
      return ElTagTheme(
        data: ElTagThemeData(
          bgColor: $key.value == $data.activeIndex
              ? context.elTheme.primary
              : context.hasHover
                  ? $theme.hoverBgColor
                  : $theme.bgColor,
        ),
        child: ElCloseButtonTheme(
          data: const ElCloseButtonThemeData(
            cursor: SystemMouseCursors.click,
          ),
          child: ElTag(
            title,
            height: $theme.size!,
            duration: 200.ms,
            borderRadius: BorderRadius.zero,
            closable: true,
            onClose: () {
              el.message.show('关闭');
            },
          ),
        ),
      );
    });
  }
}
