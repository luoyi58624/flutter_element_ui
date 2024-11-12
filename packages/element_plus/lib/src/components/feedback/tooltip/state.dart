part of 'index.dart';

class _ElTooltipState extends State<ElTooltip> {
  final showOverlay = Obs(false);

  /// 监听 build 函数的更新，同步构建 Overlay 组件
  final buildCount = Obs(0);
  final LayerLink layerLink = LayerLink();
  final GlobalKey contentKey = GlobalKey();
  late final OverlayEntry overlayEntry;
  Timer? delayHideOverlay;
  Size? contentSize;

  Color get bgColor => widget.bgColor ?? context.elTheme.tooltipTheme.color;

  /// 将 Overlay 组件永久插入小部件树中，这样做可以保留内部状态
  late final Widget _overlayWidget = ObsBuilder(
      watch: [buildCount],
      builder: (_) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(Offset.zero);
        bool isUp = offset.dy > 100;
        nextTick(() {
          _setContentSize();
          // i(_contentSize, 'build');
        });
        return Offstage(
          offstage: !showOverlay.value,
          child: UnconstrainedBox(
            child: CompositedTransformFollower(
              link: layerLink,
              targetAnchor: isUp ? Alignment.topCenter : Alignment.bottomCenter,
              followerAnchor:
                  isUp ? Alignment.bottomCenter : Alignment.topCenter,
              child: Column(
                children: [
                  if (!isUp)
                    ElTriangle(direction: AxisDirection.up, color: bgColor),
                  MouseRegion(
                    onEnter: (e) {
                      if (delayHideOverlay != null) {
                        delayHideOverlay!.cancel();
                        delayHideOverlay = null;
                      }
                    },
                    onExit: (e) {
                      delayHideOverlay = setTimeout(_hideOverlay, 100);
                    },
                    child: _buildContentWidget(bgColor),
                  ),
                  if (isUp)
                    ElTriangle(direction: AxisDirection.down, color: bgColor),
                ],
              ),
            ),
          ),
        );
      });

  @override
  void initState() {
    super.initState();
    nextTick(() async {
      overlayEntry = OverlayEntry(builder: (_) {
        return _overlayWidget;
      });
      Overlay.of(context, rootOverlay: true).insert(overlayEntry);
    });
  }

  @override
  void dispose() {
    super.dispose();
    overlayEntry.remove();
  }

  void _hideOverlay() {
    showOverlay.value = false;
    delayHideOverlay = null;
  }

  void _setContentSize() {
    final RenderBox contentBox =
        contentKey.currentContext!.findRenderObject()! as RenderBox;
    contentSize = contentBox.size;
  }

  Widget _buildContentWidget(Color bgColor) {
    late Widget result;
    bool isTextWidget = true;
    if (ElUtil.isBaseType(widget.content)) {
      result = ElText(
        widget.content,
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
        ),
      );
    } else {
      result = widget.content;
      if (!(widget.content is ElText ||
          widget.content is Text ||
          widget.content is RichText)) {
        isTextWidget = false;
      }
    }
    result = Container(
      key: contentKey,
      padding: isTextWidget ? const EdgeInsets.fromLTRB(12, 6, 12, 8) : null,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: context.elConfig.radius,
      ),
      child: ElDefaultTextStyle(
        style: TextStyle(
          color: bgColor.elTextColor(context),
          fontSize: 12,
        ),
        child: result,
      ),
    );
    if (widget.selected) result = SelectionArea(child: result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      buildCount.value++;
    });
    return ElHover(
      
      onEnter: (e) {
        if (delayHideOverlay == null) {
          showOverlay.value = true;
        } else {
          delayHideOverlay!.cancel();
          delayHideOverlay = null;
        }
      },
      onExit: (e) {
        delayHideOverlay = setTimeout(_hideOverlay, 100);
      },
      builder: (context) => CompositedTransformTarget(
        link: layerLink,
        child: widget.child,
      ),
    );
  }
}
