import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../../../utils/font.dart';
import '../../data/badge/index.dart';

part 'widget.dart';

part 'style.dart';

part '../../../generates/components/feedback/message/index.g.dart';

/// 自定义消息构建
typedef ElMessageBuilder = Widget Function(
  BuildContext context,
  ElMessageModel message,
);

/// 消息默认高度
const double _messageHeight = 40;

/// 消息之间的间距
const double _messageGap = 8;

mixin ElMessageService {
  /// Element UI 消息实例对象，它会在屏幕中上方显示一连串的消息，并支持合并相同类型的消息
  final ElMessageServiceInstance message = ElMessageServiceInstance();
}

class ElMessageServiceInstance {
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
