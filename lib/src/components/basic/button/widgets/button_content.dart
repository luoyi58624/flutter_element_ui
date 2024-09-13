part of '../index.dart';

/// 按钮内容
class ElButtonContent extends StatelessWidget {
  const ElButtonContent({
    super.key,
    required this.child,
    required this.prop,
  });

  final dynamic child;
  final ElButtonProp prop;

  Widget buildIconTheme(BuildContext context, Widget iconWidget) {
    return ElIconTheme(
      color: ElDefaultTextStyle.of(context).style.color,
      size: prop.height / 2 - 2,
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    late Widget $child;
    if (child is Widget) {
      if (child is ElIcon) {
        $child = buildIconTheme(context, child);
      } else {
        $child = child;
      }
    } else {
      $child = ElText(
        '$child',
        strutStyle: const StrutStyle(forceStrutHeight: true),
      );
    }

    if (prop.loading || prop.leftIcon != null || prop.rightIcon != null) {
      $child = buildIconTheme(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prop.loading) const ElLoading(),
            if (prop.leftIcon != null) prop.leftIcon!,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: $child,
            ),
            if (prop.rightIcon != null) prop.rightIcon!,
          ],
        ),
      );
    }
    return $child;
  }
}
