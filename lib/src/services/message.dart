part of '../service.dart';

const double _messageHeight = 36;
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
    String? type,
  }) {
    final id = uuidStr;
    final length = _messageMap.length;
    final overlayEntry = OverlayEntry(
      builder: (context) => _Message(
        id,
        length * 50 + 20,
        content,
        duration,
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
  const _Message(this.id, this.top, this.content, this.duration);

  final String id;
  final double top;
  final dynamic content;
  final int duration;

  @override
  State<_Message> createState() => _MessageState();
}

class _MessageState extends State<_Message>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late final OverlayEntry overlayEntry;
  Animation<double>? _positionAnimation;
  Animation<double>? _opacityAnimation;

  double opacity = 0;

  Timer? _removeTimer;

  @override
  void initState() {
    super.initState();
    _removeTimer = (() => $el.removeMessage(widget.id)).delay(widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      child: GestureDetector(
        onTap: $el.removeToast,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: context.isDark
                ? const Color.fromRGBO(82, 82, 82, 0.85)
                : const Color.fromRGBO(0, 0, 0, 0.25),
            borderRadius: context.elConfig.radius,
          ),
          child: Text(
            '${widget.content}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
