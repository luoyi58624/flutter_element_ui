part of 'index.dart';

class ElTab extends StatelessWidget {
  const ElTab({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final $theme = ElTabsTheme.of(context);
    return ElHoverBuilder(builder: (context) {
      return ElTagTheme(
        data: ElTagThemeData(
          bgColor: context.isHover ? $theme.hoverBgColor : $theme.bgColor,
        ),
        child: ElTag(
          title,
          height: $theme.size!,
          duration: 200.ms,
          borderRadius: BorderRadius.zero,
          closable: true,
        ),
      );
    });
  }
}
