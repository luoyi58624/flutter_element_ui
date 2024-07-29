part of 'tabs.dart';

class ElTab extends StatelessWidget {
  const ElTab({super.key});

  @override
  Widget build(BuildContext context) {
    final $data = _TabInheritedWidget.of(context);
    final $indexData = ElChildIndexData.of(context);
    return TapBuilder(builder: (context) {
      return HoverBuilder(builder: (context) {
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 200,
          ),
          decoration: BoxDecoration(
            color: $data.modelValue.value == $indexData.index
                ? Colors.white
                : null,
          ),
          child: const Row(
            children: [
              ElIcon(ElIcons.eleme),
              Gap(6),
              ElText('标签页'),
            ],
          ),
        );
      });
    });
  }
}
