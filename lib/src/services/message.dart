import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:gap/gap.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../components/basic/icon.dart';
import '../components/data/badge.dart';
import '../components/others/hover.dart';
import '../service.dart';
import '../utils/assert.dart';
import '../utils/font.dart';
import '../utils/icons.dart';
import '../utils/util.dart';

/// 自定义消息构建
typedef ElMessageBuilder = Widget Function(
  BuildContext context,
  ElMessage message,
);

/// 消息默认高度
const double _messageHeight = 40;

/// 消息之间的间距
const double _messageGap = 8;

/// Element UI 消息实例对象
class ElMessage {
  /// 消息id
  final int _id;

  /// 消息类型
  final String type;

  /// 消息内容
  final String content;

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

  /// 不允许外部实例化它，只能通过 [$el.showMessage] 创建
  ElMessage._(
    this._id,
    this.type,
    this.content,
    this._overlayEntry,
    this._willRemove,
    this._groupCount,
  );
}

mixin ElMessageService {
  /// 消息id
  int _id = 0;

  /// 消息列表
  final List<ElMessage> _messageList = [];

  /// 记录当前连续消息组的第一条消息的偏移值
  double? _firstTopOffset;

  /// 在页面上显示消息提示
  /// * content 消息内容，必传
  /// * type 主题类型
  /// * icon 自定义图标，如果 content 是 [Widget]，此属性无效
  /// * duration 持续时间，单位毫秒
  /// * showClose 是否显示关闭按钮
  /// * offset 第一条消息距离顶部窗口的距离
  /// * grouping 是否合并内容相同的消息，注意：type 也必须相同
  /// * builder 自定义构建消息内容，支持全局配置
  ElMessage showMessage(
    BuildContext context,
    String content, {
    String type = 'info',
    Widget? icon,
    int? duration,
    bool? showClose,
    double? offset,
    bool? grouping,
    ElMessageBuilder? builder,
  }) {
    ElAssert.themeTypeRequired(type);
    final style = context.elConfig.messageStyle;

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
        duration ?? style.messageDuration,
        style.animationDuration,
        showClose ?? style.showClose,
        builder ?? style.builder,
      ),
    );

    // 创建消息模型对象并添加到消息列表
    final model = ElMessage._(id, type, content, overlayEntry, false, Obs(0));

    _messageList.add(model);

    // 插入浮层元素
    Overlay.of(context).insert(overlayEntry);
    return model;
  }
}

class _Message extends StatefulWidget {
  const _Message(
    this.id,
    this.messageDuration,
    this.animationDuration,
    this.showClose, [
    this.builder,
  ]);

  final int id;
  final int messageDuration;
  final int animationDuration;
  final bool showClose;
  final ElMessageBuilder? builder;

  @override
  State<_Message> createState() => _MessageState();
}

class _MessageState extends State<_Message>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> offsetAnimation;
  late final Animation<double> opacityAnimation;
  late final ElMessage model;
  Timer? _removeTimer;
  GlobalKey messageKey = GlobalKey();

  /// 计算当前消息在页面中的位置
  double get topOffset {
    double result = $el._firstTopOffset!;
    for (final current in $el._messageList) {
      if (current._id == widget.id) break;
      result += current._messageSize.value.height + _messageGap;
    }
    return result;
  }

  /// 适配响应式
  double get maxWidth => context.xs
      ? 250
      : context.sm
          ? 320
          : 450;

  /// 为了自适应宽度文字必须通过 [ConstrainedBox] 包裹，否则在 [Row] 当中无法换行
  double get maxTextWidth => widget.showClose ? maxWidth - 100 : maxWidth - 80;

  @override
  void initState() {
    super.initState();
    // 通过id拿到消息列表中的对象
    model = $el._messageList.firstWhere((e) => e._id == widget.id);
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
    model._groupCount.addListener(() {
      _removeTimer!.cancel();
      _removeTimer = null;
      setRemoveTimer();
    });
    model.removeMessage = removeMessage;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 设置移除消息计时器
  void setRemoveTimer() {
    _removeTimer ??= removeMessage.delay(widget.messageDuration);
  }

  /// 移除消息
  void removeMessage() async {
    if (model._willRemove == true) return;
    // 标记此消息将被移除
    model._willRemove = true;
    // 执行移除动画
    controller.reverse();
    // 动画执行完毕后从列表中移除消息对象
    await widget.animationDuration.ms.delay();
    model._overlayEntry.remove();
    $el._messageList.remove(model);
    // 如果所有消息都被弹出，则重置第一条消息的顶部位置
    if ($el._messageList.isEmpty) $el._firstTopOffset = null;
  }

  Widget get messageIcon {
    if (model.type == 'primary') return const ElIcon(ElIcons.elemeFilled);
    if (model.type == 'success') return const ElIcon(ElIcons.successFilled);
    if (model.type == 'warning') return const ElIcon(ElIcons.warningFilled);
    if (model.type == 'error') return const ElIcon(ElIcons.circleCloseFilled);
    return const ElIcon(ElIcons.infoFilled);
  }

  Widget buildContentWidget(Color themeColor) {
    return Container(
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
        borderRadius: context.elConfig.cardRadius,
        border: Border.all(color: themeColor.themeLightBorder(context)),
      ),
      child: ElIconTheme(
        color: themeColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            messageIcon,
            const Gap(10),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxTextWidth,
              ),
              child: SelectableText(
                model.content,
                style: TextStyle(
                  color: themeColor,
                  fontWeight: ElFont.medium,
                ),
              ),
            ),
            if (widget.showClose) const Gap(10),
            if (widget.showClose)
              GestureDetector(
                onTap: () {
                  if (_removeTimer != null) {
                    _removeTimer!.cancel();
                    _removeTimer = null;
                  }
                  removeMessage();
                },
                child: ElHover(
                  cursor: SystemMouseCursors.click,
                  builder: (isHover) {
                    return ElIcon(
                      ElIcons.close,
                      color: isHover
                          ? themeColor
                          : context.isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 设置当前消息的元素尺寸
    ElUtil.nextTick(() {
      model._messageSize.value = messageKey.currentContext!.size!;
    });
    final themeColor = context.themeTypeColors[model.type]!;
    return ObsBuilder(builder: (context) {
      return AnimatedPositioned(
        duration: widget.animationDuration.ms,
        top: topOffset,
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
                  child: ElHover(
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
                    builder: (isHover) => SizedBox(
                      key: messageKey,
                      child: ObsBuilder(
                        builder: (context) {
                          return ElBadge(
                            badge: model._groupCount.value,
                            child: widget.builder != null
                                ? widget.builder!(context, model)
                                : buildContentWidget(themeColor),
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

extension _MessageColorExtension on Color {
  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => light9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => light8(context);
}
