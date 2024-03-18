part of flutter_element_ui;

class ElLoading extends StatelessWidget {
  const ElLoading({super.key, required this.size, required this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return _LoadingWidget(
      child: ElIcon.svg(
        ElIcons.loading,
        size: size,
        color: color,
      ),
    );
  }
}
