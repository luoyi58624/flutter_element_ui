part of flutter_element_ui;

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget({
    super.key,
    required this.child,
    this.loading = true,
  });

  final Widget child;
  final bool loading;

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    if (widget.loading) start();
  }

  @override
  void didUpdateWidget(covariant _LoadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading) {
      start();
    } else {
      stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void start() {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  void stop() {
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: _controller,
      child: widget.child,
    );
  }
}
