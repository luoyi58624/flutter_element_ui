part of '../../data/tag/index.dart';

class _ElTagState extends State<ElTag> {
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
