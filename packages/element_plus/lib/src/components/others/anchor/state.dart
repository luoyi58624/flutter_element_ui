part of 'index.dart';

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
