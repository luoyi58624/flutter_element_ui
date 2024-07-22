import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:gap/gap.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../components/basic/icon.dart';
import '../components/others/hover.dart';
import '../service.dart';
import '../utils/font.dart';
import '../utils/icons.dart';

/// 第一条消息偏移
const double _messageFirstTop = 20;
const double _messageHeight = 40;
const double _messageTop = _messageHeight + 8;
const int _duration = 300;

class _MessageModel {
  final int id;

  /// 保存浮层实例对象，当到达结束时间通过此对象移除浮层
  final OverlayEntry overlayEntry;

  /// 当前消息的位置，当消息被移除时，需要通知其他消息改变当前位置
  final Obs<double> top;

  /// 因为移除前需要执行隐藏动画，此变量告知这条消息即将被移除
  bool willRemove;

  _MessageModel(this.id, this.overlayEntry, this.top, this.willRemove);
}

mixin ElMessageService {
  /// 消息id
  int _id = 0;

  /// 消息列表
  final List<_MessageModel> _messageList = [];

  /// 记录被移除的消息当前位置，hover悬停到目标消息会暂时移除侦听器，
  /// 所以一定会造成消息堆叠，此变量的作用是防止后面移除的消息更新前面已堆叠的消息位置。
  double _lastRemoveTop = 0;

  /// 在页面上显示消息提示
  /// * duration 持续时间，单位毫秒
  /// * type 主题类型
  /// * showClose 是否显示关闭按钮
  void showMessage(
    BuildContext context,
    dynamic content, {
    int duration = 3000,
    String type = 'info',
    bool showClose = true,
  }) {
    final id = _id++;
    late final double top;
    final length = _messageList.length;
    if (length == 0) {
      top = _messageFirstTop;
    } else {
      final lastData = _messageList.last;
      if (lastData.willRemove) {
        top = _messageFirstTop;
      } else {
        top = lastData.top.value + _messageTop;
      }
    }
    final overlayEntry = OverlayEntry(
      builder: (context) => _Message(id, content, duration, type, showClose),
    );
    _messageList.add(_MessageModel(id, overlayEntry, Obs(top), false));
    Overlay.of(context).insert(overlayEntry);
  }
}

class _Message extends StatefulWidget {
  const _Message(
    this.id,
    this.content,
    this.duration,
    this.type,
    this.showClose,
  );

  final int id;
  final dynamic content;
  final int duration;
  final String type;
  final bool showClose;

  @override
  State<_Message> createState() => _MessageState();
}

class _MessageState extends State<_Message>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> offsetAnimation;
  late Animation<double> opacityAnimation;
  late _MessageModel model;
  Timer? _removeTimer;

  @override
  void initState() {
    super.initState();
    model = $el._messageList.firstWhere((e) => e.id == widget.id);
    controller = AnimationController(vsync: this, duration: _duration.ms);
    offsetAnimation = Tween<double>(begin: -_messageHeight, end: 0).animate(
        CurvedAnimation(parent: controller, curve: const Cubic(0, 0, 0.2, 1)));
    opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward();
    _removeTimer = removeMessage.delay(widget.duration);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void removeMessage() async {
    model.willRemove = true;
    $el._lastRemoveTop = model.top.value;
    controller.reverse();
    updatePosition();
    await (_duration / 1000).delay();
    model.overlayEntry.remove();
    $el._messageList.remove(model);
  }

  void updatePosition() {
    for (final model in $el._messageList) {
      if (model.id != widget.id && model.top.value > $el._lastRemoveTop) {
        model.top.value = max(_messageFirstTop, model.top.value - _messageTop);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.themeTypeColors[widget.type]!;
    return ObsBuilder(builder: (context) {
      return AnimatedPositioned(
        duration: _duration.ms,
        top: model.top.value,
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
                      if (_removeTimer == null && model.willRemove == false) {
                        _removeTimer = removeMessage.delay(widget.duration);
                      }
                    },
                    builder: (isHover) => Container(
                      height: _messageHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: themeColor.themeLightBg(context),
                        borderRadius: context.elConfig.cardRadius,
                        border: Border.all(
                            color: themeColor.themeLightBorder(context)),
                      ),
                      child: Row(
                        children: [
                          if (widget.type == 'success')
                            ElIcon(
                              ElIcons.successFilled,
                              color: themeColor,
                            ),
                          if (widget.type == 'info')
                            ElIcon(
                              ElIcons.infoFilled,
                              color: themeColor,
                            ),
                          if (widget.type == 'warning')
                            ElIcon(
                              ElIcons.warningFilled,
                              color: themeColor,
                            ),
                          if (widget.type == 'error')
                            ElIcon(
                              ElIcons.circleCloseFilled,
                              color: themeColor,
                            ),
                          const Gap(8),
                          SelectableText(
                            '${widget.content}',
                            style: TextStyle(
                              color: themeColor,
                              fontWeight: ElFont.medium,
                            ),
                          ),
                          const Gap(16),
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
                                onlyCursor: true,
                                builder: (isHover) {
                                  return ElIcon(
                                    ElIcons.close,
                                    color: context.isDark
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade400,
                                  );
                                },
                              ),
                            ),
                        ],
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
