import 'package:flutter/widgets.dart';

import '../../global.dart';

class ElAnchor extends StatefulWidget {
  /// Element UI 锚点小部件，你可以通过 [el.anchor] 访问相关 api
  const ElAnchor({
    super.key,
    required this.name,
    required this.child,
  });

  /// 锚点名字，请确保它唯一
  final String name;
  final Widget child;

  @override
  State<ElAnchor> createState() => _ElAnchorState();
}

class _ElAnchorState extends State<ElAnchor> {
  final globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    el.anchor.setAnchor(widget.name, globalKey);
  }

  @override
  void didUpdateWidget(covariant ElAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != oldWidget.name) {
      el.anchor.removeAnchor(oldWidget.name);
      el.anchor.setAnchor(widget.name, globalKey);
    }
  }

  @override
  void dispose() {
    super.dispose();
    el.anchor.removeAnchor(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      key: globalKey,
      builder: (context) {
        return widget.child;
      },
    );
  }
}
