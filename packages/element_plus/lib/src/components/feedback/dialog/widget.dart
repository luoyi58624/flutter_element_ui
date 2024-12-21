part of 'index.dart';

class _DialogWidget extends StatefulWidget {
  const _DialogWidget({
    required this.overlayContext,
    required this.themeData,
  });

  final BuildContext overlayContext;
  final ElDialogThemeData themeData;

  @override
  State<_DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<_DialogWidget> {
  late final AnimationController controller = AnimationController(
    vsync: vsync,
    duration: widget.themeData.animationDuration,
  );
  late final Animation<double> positionAnimation = Tween<double>(
    begin: -20,
    end: 0,
  ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

  late Animation<double> opacityAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(controller);

  @override
  void initState() {
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // nextTick(() {
    //   i(widget.overlayContext.size);
    // });
    // Transform(
    //   transform: ,
    // );
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        color: context.elTheme.primary,
        borderRadius: context.commonSizePreset.cardRadius,
      ),
    );
  }
}
