part of 'index.dart';

class _ElTabState extends State<ElTab> {
  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            // color: context.isHover?
          ),
          child: Row(
            children: [
              ElText(widget.title),
            ],
          ),
        );
      }
    );
  }
}
