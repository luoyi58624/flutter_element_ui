import 'dart:async';

import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

import '../components/data/badge/index.dart';
import '../themes/components/basic/icon.dart';
import '../utils/font.dart';

/// 消息默认高度
const double _messageHeight = 40;

/// 消息之间的间距
const double _messageGap = 8;

mixin MessageService {
  /// Element UI 消息实例对象，它会在屏幕中上方显示一连串的消息，并支持合并相同类型的消息
  MessageServiceInstance get message => _message;
}

final MessageServiceInstance _message = MessageServiceInstance();

class MessageServiceInstance {
  /// 消息id
  int _id = 0;

  /// 消息列表
  final List<ElMessageModel> _messageList = [];

  /// 记录当前连续消息组的第一条消息的偏移值
  double? _firstTopOffset;

  /// 在页面上显示消息提示
  /// * context 默认使用全局context，如果你需要让它作用于局部页面，请传递当前context
  /// * content 消息内容
  /// * type 主题类型
  /// * icon 自定义消息图标，如果 content 是 [Widget]，则此属性无效
  /// * duration 持续时间，单位毫秒
  /// * showClose 是否显示关闭按钮
  /// * offset 第一条消息距离顶部窗口的距离
  /// * grouping 是否合并内容相同的消息，注意：type 也必须相同
  /// * builder 自定义构建消息内容
  ElMessageModel show(
    String content, {
    BuildContext? context,
    String type = 'info',
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
    ElMessageBuilder? builder,
  }) {
    ElAssert.themeTypeRequired(type, 'ElMessageModel');
    final style = (context ?? el.context).elTheme.messageTheme;

    // 如果设置了分组属性，则只需更新响应式变量即可
    if (grouping ?? style.grouping) {
      for (final model in _messageList) {
        if (model.type == type &&
            model.content == content &&
            model._willRemove == false) {
          model._groupCount.value++;
          return model;
        }
      }
    }

    final id = _id++;
    _firstTopOffset ??= offset ?? style.offset;

    // 构建浮层对象
    final overlayEntry = OverlayEntry(
      builder: (context) => _Message(
        id,
        duration ?? style.closeDuration,
        style.animationDuration,
        builder ?? style.builder ?? _defaultBuilder,
      ),
    );

    // 创建消息模型对象并添加到消息列表
    final model = ElMessageModel._(id, type, content, icon,
        showClose ?? style.showClose, overlayEntry, false, Obs(0));

    _messageList.add(model);

    // 插入浮层元素
    Overlay.of(context ?? el.context).insert(overlayEntry);
    return model;
  }

  /// primary 主题消息
  ElMessageModel primary(
    String content, {
    BuildContext? context,
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'primary',
      icon: icon,
      duration: duration,
      showClose: showClose,
      offset: offset,
      grouping: grouping,
    );
  }

  /// success 主题消息
  ElMessageModel success(
    String content, {
    BuildContext? context,
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'success',
      icon: icon,
      duration: duration,
      showClose: showClose,
      offset: offset,
      grouping: grouping,
    );
  }

  /// info 主题消息
  ElMessageModel info(
    String content, {
    BuildContext? context,
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'info',
      icon: icon,
      duration: duration,
      showClose: showClose,
      offset: offset,
      grouping: grouping,
    );
  }

  /// warning 主题消息
  ElMessageModel warning(
    String content, {
    BuildContext? context,
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'warning',
      icon: icon,
      duration: duration,
      showClose: showClose,
      offset: offset,
      grouping: grouping,
    );
  }

  /// error 主题消息
  ElMessageModel error(
    String content, {
    BuildContext? context,
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'error',
      icon: icon,
      duration: duration,
      showClose: showClose,
      offset: offset,
      grouping: grouping,
    );
  }
}

/// Element UI 消息实例对象
class ElMessageModel {
  /// 消息id
  final int id;

  /// 消息类型
  final String type;

  /// 消息内容
  final String content;

  /// 消息图标
  final Widget? icon;

  /// 是否显示关闭按钮
  final bool showClose;

  /// 保存浮层实例对象，当到达结束时间通过此对象移除浮层
  final OverlayEntry _overlayEntry;

  /// 因为移除前需要执行隐藏动画，此变量告知这条消息即将被移除
  bool _willRemove;

  /// 如果开启了合并消息，出现 (相同内容 & 相同类型) 的消息该值会自增
  final Obs<int> _groupCount;

  /// 当前消息元素大小
  final Obs<Size> _messageSize = Obs(Size.zero);

  /// 移除消息函数
  late VoidCallback removeMessage;

  /// 不允许外部实例化它，只能通过 [el.message] 创建
  ElMessageModel._(
    this.id,
    this.type,
    this.content,
    this.icon,
    this.showClose,
    this._overlayEntry,
    this._willRemove,
    this._groupCount,
  );
}

/// 消息提示队列显示、隐藏、以及交互小部件
class _Message extends StatefulWidget {
  const _Message(
    this.id,
    this.messageDuration,
    this.animationDuration,
    this.builder,
  );

  final int id;
  final int messageDuration;
  final int animationDuration;
  final ElMessageBuilder builder;

  @override
  State<_Message> createState() => _MessageState();
}

class _MessageState extends State<_Message>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> offsetAnimation;
  late final Animation<double> opacityAnimation;
  late final ElMessageModel message;
  Timer? _removeTimer;
  GlobalKey messageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 通过id拿到消息列表中的对象
    message = el.message._messageList.firstWhere((e) => e.id == widget.id);
    // 初始化动画
    controller =
        AnimationController(vsync: this, duration: widget.animationDuration.ms);
    offsetAnimation = Tween<double>(begin: -_messageHeight, end: 0).animate(
        CurvedAnimation(parent: controller, curve: const Cubic(0, 0, 0.2, 1)));
    opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward();
    // 设置移除消息计时器
    setRemoveTimer();
    // 监听分组消息，如果发生变化重置计时器
    message._groupCount.addListener(() {
      _removeTimer!.cancel();
      _removeTimer = null;
      setRemoveTimer();
    });
    message.removeMessage = removeMessage;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 计算当前消息在页面中的位置
  double get topOffset {
    double result = el.message._firstTopOffset!;
    for (final current in el.message._messageList) {
      if (current.id == widget.id) break;
      result += current._messageSize.value.height + _messageGap;
    }
    return result;
  }

  /// 设置移除消息计时器
  void setRemoveTimer() {
    _removeTimer ??= setTimeout(removeMessage, widget.messageDuration);
  }

  /// 移除消息
  void removeMessage() async {
    if (!mounted || message._willRemove == true) return;
    // 标记此消息将被移除
    message._willRemove = true;
    // 执行移除动画
    controller.reverse();
    // 动画执行完毕后从列表中移除消息对象
    await widget.animationDuration.ms.delay();
    message._overlayEntry.remove();
    el.message._messageList.remove(message);
    // 如果所有消息都被弹出，则重置第一条消息的顶部位置
    if (el.message._messageList.isEmpty) el.message._firstTopOffset = null;
  }

  @override
  Widget build(BuildContext context) {
    // 绑定窗口尺寸变化监听，这样可以触发重新计算消息偏移布局
    MediaQuery.maybeSizeOf(context);

    // 设置当前消息的元素尺寸
    nextTick(() {
      message._messageSize.value = messageKey.currentContext!.size!;
    });

    return ObsBuilder(builder: (context) {
      return AnimatedPositioned(
        duration: widget.animationDuration.ms,
        top: MediaQuery.paddingOf(context).top + topOffset,
        left: 0,
        right: 0,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, offsetAnimation.value),
              child: Opacity(
                opacity: opacityAnimation.value,
                child: UnconstrainedBox(
                  child: HoverBuilder(
                    onlyCursor: true,
                    onEnter: (e) {
                      if (_removeTimer != null) {
                        _removeTimer!.cancel();
                        _removeTimer = null;
                      }
                    },
                    onExit: (e) {
                      setRemoveTimer();
                    },
                    builder: (context) => SizedBox(
                      key: messageKey,
                      child: ObsBuilder(
                        builder: (context) {
                          return ElBadge(
                            badge: message._groupCount.value,
                            child: widget.builder(context, message),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

/// 构建默认风格样式的消息小部件
ElMessageBuilder _defaultBuilder =
    (context, message) => _DefaultMessage(message);

/// Element UI 默认样式消息组件
class _DefaultMessage extends StatelessWidget {
  const _DefaultMessage(this.message);

  final ElMessageModel message;

  Widget get messageIcon {
    if (message.type == 'primary') return const ElIcon(ElIcons.platformEleme);
    if (message.type == 'success') return const ElIcon(ElIcons.success);
    if (message.type == 'warning') return const ElIcon(ElIcons.warning);
    if (message.type == 'error') return const ElIcon(ElIcons.error);
    return const ElIcon(ElIcons.info);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.elThemeColors[message.type]!;
    double maxWidth = context.xs
        ? 250
        : context.sm
            ? 320
            : 450;
    double maxTextWidth = message.showClose ? maxWidth - 100 : maxWidth - 80;
    return SelectionArea(
      child: AnimatedContainer(
        duration: context.elConfig.themeDuration,
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          minHeight: _messageHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: themeColor.themeLightBg(context),
          borderRadius: context.elTheme.cardTheme.radius,
          border: Border.all(color: themeColor.themeLightBorder(context)),
        ),
        child: ElIconTheme(
          data: ElIconThemeData(color: themeColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              message.icon ?? messageIcon,
              const Gap(10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxTextWidth,
                ),
                child: ElText(
                  message.content,
                  style: TextStyle(
                    color: context.isDark
                        ? context.darkTheme.textColor
                        : themeColor,
                    fontWeight: ElFont.medium,
                  ),
                ),
              ),
              if (message.showClose) const Gap(10),
              if (message.showClose)
                GestureDetector(
                  onTap: () {
                    message.removeMessage();
                  },
                  child: HoverBuilder(
                    cursor: SystemMouseCursors.click,
                    builder: (context) {
                      return ElIcon(
                        ElIcons.close,
                        color: HoverBuilder.of(context)
                            ? themeColor
                            : context.isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade400,
                        size: 1.25.rem(context),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _MessageColorExtension on Color {
  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight8(context);
}
