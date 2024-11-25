part of 'index.dart';

class _ElTreeState extends State<ElTree> {
  late ElTreeThemeData treeThemeData;

  Widget buildItem(Map<String, dynamic> mapData) {
    return Container(
      height: treeThemeData.itemHeight,
      padding: treeThemeData.padding,
      decoration: BoxDecoration(
        borderRadius: treeThemeData.borderRadius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    treeThemeData = ElTreeTheme.of(context);
    return CustomScrollView(
      slivers: [
        SuperListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) => SizedBox(),
        ),
      ],
    );
  }
}
