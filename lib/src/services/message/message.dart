import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:gap/gap.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../../components/basic/icon.dart';
import '../../components/data/badge.dart';
import '../../components/others/hover.dart';
import '../../core.dart';
import '../../utils/assert.dart';
import '../../utils/font.dart';
import '../../utils/icons.dart';
import '../../utils/util.dart';

part 'core.dart';

part 'widget.dart';

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
  final int id;

  /// 消息类型
  final String type;

  /// 消息内容
  final String content;

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

  /// 不允许外部实例化它，只能通过 [$el.showMessage] 创建
  ElMessage._(
    this.id,
    this.type,
    this.content,
    this.showClose,
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
  /// * context 上下文对象，使用全局 context 和局部 context 的区别在于它们所在的层级不一样
  /// * content 消息内容
  /// * type 主题类型
  /// * icon 自定义图标，如果 content 是 [Widget]，此属性无效
  /// * duration 持续时间，单位毫秒
  /// * showClose 是否显示关闭按钮
  /// * offset 第一条消息距离顶部窗口的距离
  /// * grouping 是否合并内容相同的消息，注意：type 也必须相同
  /// * builder 自定义构建消息内容
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
    ElAssert.themeTypeRequired(type, 'ElMessage');
    final style = $el.config.messageStyle;

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
        builder ?? style.builder ?? _defaultBuilder,
      ),
    );

    // 创建消息模型对象并添加到消息列表
    final model = ElMessage._(id, type, content, showClose ?? style.showClose,
        overlayEntry, false, Obs(0));

    _messageList.add(model);

    // 插入浮层元素
    Overlay.of(context).insert(overlayEntry);
    return model;
  }
}
