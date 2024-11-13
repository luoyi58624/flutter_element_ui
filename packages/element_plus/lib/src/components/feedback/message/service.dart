part of 'index.dart';

/// Element UI 消息服务
class ElMessageService {
  /// 记录消息 id
  int _id = 0;

  /// 消息列表
  final List<ElMessageModel> _messageList = [];

  /// 记录当前连续消息组的第一条消息的偏移值
  double? _firstTopOffset;

  /// 在页面上显示一条消息
  /// * content 消息内容
  /// * context 默认使用全局context，如果你需要让它作用于局部页面，请传递当前context
  /// * type 主题类型
  /// * icon 自定义消息图标，如果 content 是 [Widget]，则此属性无效
  /// * closeDuration 持续时间，单位毫秒
  /// * showClose 是否显示关闭按钮
  /// * offset 第一条消息距离顶部窗口的距离
  /// * grouping 是否合并内容相同的消息，注意：type 也必须相同
  /// * builder 自定义构建消息内容
  ElMessageModel show(
    String content, {
    BuildContext? context,
    String type = El.info,
    Widget? icon,
    Duration? closeDuration,
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
      builder: (context) => _MessageWidget(
        id,
        closeDuration ?? style.closeDuration,
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
    Duration? closeDuration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: El.primary,
      icon: icon,
      closeDuration: closeDuration,
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
    Duration? closeDuration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'success',
      icon: icon,
      closeDuration: closeDuration,
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
    Duration? closeDuration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'info',
      icon: icon,
      closeDuration: closeDuration,
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
    Duration? closeDuration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'warning',
      icon: icon,
      closeDuration: closeDuration,
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
    Duration? closeDuration,
    bool? showClose,
    double? offset,
    bool? grouping,
  }) {
    return show(
      content,
      context: context,
      type: 'error',
      icon: icon,
      closeDuration: closeDuration,
      showClose: showClose,
      offset: offset,
      grouping: grouping,
    );
  }
}
