part of 'index.dart';

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

  /// 移除消息函数，当 [_MessageWidget] 初始化时会设置它
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
