import 'package:flutter/widgets.dart';
import 'package:url_launcher/link.dart';

import '../../../widgets/hover.dart';
import 'base_link.dart';
import 'link.dart';

class ElLink extends ElBaseLink {
  const ElLink({
    super.key,
    required super.href,
    required super.builder,
    super.target,
    super.cursor,
    super.color,
    super.activeColor,
    super.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(href),
      target: target == ElLinkTarget.self ? LinkTarget.self : LinkTarget.blank,
      builder: (context, open) => ElHoverBuilder(
        cursor: cursor,
        builder: (context) {
          return buildTextTheme(context, builder(() {
            if (open != null) open();
          }));
        },
      ),
    );
  }
}
