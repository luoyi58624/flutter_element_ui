import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ElHeader extends StatelessWidget {
  const ElHeader({
    super.key,
    this.title,
    this.height,
  });

  final dynamic title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final headerColor = context.elTheme.headerColor;
    final titleWidget = buildTitle(context);
    return ColoredBox(
      color: headerColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height ?? 56,
          child: Row(
            children: [
              if (titleWidget != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: headerColor.elTextColor(context),
                    ),
                    child: titleWidget,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? buildTitle(BuildContext context) {
    if (DartUtil.isBaseType(title)) {
      return Text(
        '$title',
        style: TextStyle(
          fontWeight: FontUtil.bold,
          fontSize: 20,
        ),
      );
    }
    if (title is Widget) return title;
    return null;
  }
}
