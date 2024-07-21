part of '../service.dart';

const double _messageHeight = 40;
const int _duration = 400;
mixin _MessageService {
  /// 消息列表
  final Map<String, OverlayEntry> _messageMap = {};

  /// 在页面上显示消息提示
  /// * duration 持续时间，单位毫秒
  /// * type 主题类型
  String showMessage(
    BuildContext context,
    dynamic content, {
    int duration = 3000,
    String type = 'info',
  }) {
    final id = uuidStr;
    final length = _messageMap.length;
    final overlayEntry = OverlayEntry(
      builder: (context) => _Message(
        id,
        length * (_messageHeight + 8) + 20,
        content,
        duration,
        type,
      ),
    );
    _messageMap[id] = overlayEntry;
    Overlay.of(context).insert(overlayEntry);
    return id;
  }

  void removeMessage(String id) {
    if (_messageMap.containsKey(id)) {
      _messageMap[id]!.remove();
      _messageMap.remove(id);
    }
  }
}

class _Message extends StatefulWidget {
  const _Message(this.id, this.top, this.content, this.duration, this.type);

  final String id;
  final double top;
  final dynamic content;
  final int duration;
  final String type;

  @override
  State<_Message> createState() => _MessageState();
}

class _MessageState extends State<_Message>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late final OverlayEntry overlayEntry;
  late Animation<double> positionAnimation;
  late Animation<double> opacityAnimation;

  double opacity = 0;

  Timer? _removeTimer;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: _duration.ms);
    positionAnimation = Tween<double>(begin: -_messageHeight, end: 0).animate(
        CurvedAnimation(parent: controller, curve: const Cubic(0, 0, 0.2, 1)));
    opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward();
    _removeTimer = (() async {
      controller.reverse();
      await (_duration / 1000).delay();
      $el.removeMessage(widget.id);
    }).delay(widget.duration);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.themeTypeColors[widget.type]!;
    return Positioned(
      top: widget.top,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, positionAnimation.value),
              child: Opacity(
                opacity: opacityAnimation.value,
                child: GestureDetector(
                  onTap: $el.removeToast,
                  child: UnconstrainedBox(
                    child: Container(
                      height: _messageHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: themeColor.elThemeLightBg(context),
                        borderRadius: context.elConfig.cardRadius,
                      ),
                      child: Text(
                        '${widget.content}',
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: ElFont.medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
