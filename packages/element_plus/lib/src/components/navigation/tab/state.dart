part of 'index.dart';

class _ElTabState extends State<ElTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ElText(widget.title),
        ],
      ),
    );
  }
}
