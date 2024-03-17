part of flutter_element_ui;

abstract class _ButtonItem extends StatefulWidget {
  const _ButtonItem({
    required super.key,
  }) : assert(key is ValueKey<int>, '请传递包含当前按钮索引的ValueKey');

  @override
  State<_ButtonItem> createState();
}

abstract class _ButtonItemState<T extends _ButtonItem> extends State<T> {
  /// 按钮当前索引的key
  late int currentIndex = (widget.key as ValueKey<int>).value;

  /// 按钮组数据
  _ButtonGroupData get buttonGroupData;

  /// 按钮组的长度
  int get childrenLength;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  /// 计算默认样式的按钮组边框
  Border? caleDefaultButtonGroupBorder(Color borderColor) {
    BorderSide borderSide = BorderSide(color: borderColor);
    if (childrenLength == 2) {
      if (currentIndex == 0) {
        return buttonGroupData.onEnterIndex == currentIndex
            ? Border.all(color: borderColor)
            : Border(top: borderSide, left: borderSide, bottom: borderSide);
      } else {
        return buttonGroupData.onEnterIndex == currentIndex
            ? Border.all(color: borderColor)
            : Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    } else {
      // 计算第一个按钮的边缘情况，当鼠标进入第一个按钮后面一个的按钮，那么第一个按钮取消右边框，因为后面那一个按钮需要绘制所有边框
      if (currentIndex == 0) {
        if (buttonGroupData.onEnterIndex == 1) {
          return Border(top: borderSide, left: borderSide, bottom: borderSide);
        } else {
          return Border.all(color: borderColor);
        }
      }
      // 计算最后一个按钮的边缘情况，当鼠标进入最后一个按钮，返回全边框，否则不绘制左边框，因为前一个按钮已经绘制了右边框
      else if (currentIndex == childrenLength - 1) {
        if (buttonGroupData.onEnterIndex == childrenLength - 1) {
          return Border.all(color: borderColor);
        } else {
          return Border(top: borderSide, right: borderSide, bottom: borderSide);
        }
      }
      // 计算中间按钮的边缘情况，默认返回绘制上边框、下边框、右边框
      else {
        if (buttonGroupData.onEnterIndex == currentIndex) {
          return Border.all(color: borderColor);
        }
        // 如果最后一个按钮被选中，那么前一个按钮就无需绘制右边框
        if (buttonGroupData.onEnterIndex == childrenLength - 1) {
          if (currentIndex == childrenLength - 2) {
            return Border(top: borderSide, bottom: borderSide);
          }
        }
        return Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    }
  }

  /// 计算拥有主题类型的按钮组的边框
  Border? caleTypeButtonGroupBorder() {
    if (buttonGroupData.buttonGroupType == _ButtonGroupType.base) {
      BorderSide borderSide = BorderSide(color: ElApp.of(context).darkTheme.textColor, width: 0.5);
      if (childrenLength == 2) {
        if (currentIndex == 0) {
          return Border(right: borderSide);
        }
      } else {
        if (currentIndex != childrenLength - 1) {
          return Border(right: borderSide);
        }
      }
    } else {
      BorderSide borderSide = BorderSide(color: ElApp.of(context).darkTheme.defaultBorderColor);
      if (childrenLength == 2) {
        if (currentIndex == 0) {
          return Border(top: borderSide, left: borderSide, bottom: borderSide);
        } else {
          return Border(top: borderSide, right: borderSide, bottom: borderSide);
        }
      } else {
        return Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    }

    return null;
  }

  /// 计算按钮组的边框圆角
  BorderRadius caleButtonGroupBorderRadius(double radius) {
    late BorderRadius borderRadius;
    if (childrenLength == 2) {
      if (currentIndex == 0) {
        borderRadius = BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
      } else {
        borderRadius = BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));
      }
    } else {
      if (currentIndex == 0) {
        borderRadius = BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
      } else if (currentIndex == childrenLength - 1) {
        borderRadius = BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));
      } else {
        borderRadius = BorderRadius.zero;
      }
    }
    return borderRadius;
  }
}

/// 按钮组的按钮项，你必须设置当前下标key，用于定位当前按钮所在的位置。
///
/// 例：
/// ```dart
/// const ElButtonGroup(
///   children: [
///     ElButtonItem(
///       key: ValueKey(0), // 下标位置
///       'Item 1',
///     ),
///     ElButtonItem(
///        key: ValueKey(1),
///       'Item 2',
///     ),
///   ],
/// ),
class ElButtonItem extends _ButtonItem {
  const ElButtonItem(
    this.text, {
    required super.key,
    this.leftIcon,
    this.rightIcon,
    this.disabled = false,
  });

  /// 按钮文字
  final String? text;

  /// 普通按钮左图标
  final IconData? leftIcon;

  /// 普通按钮右图标
  final IconData? rightIcon;

  /// 禁用按钮
  final bool disabled;

  @override
  State<ElButtonItem> createState() => _ElButtonItemState();
}

class _ElButtonItemState extends _ButtonItemState<ElButtonItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  _ButtonGroupData get buttonGroupData => _ElButtonGroupData.of(context);

  @override
  int get childrenLength => _ElButtonGroupData.of(context).children.length;
}

class ElIconButtonItem extends StatefulWidget {
  const ElIconButtonItem(
    this.icon, {
    required super.key,
  }) : assert(key is ValueKey<int>, '请传递包含当前按钮索引的ValueKey');

  /// 按钮图标
  final ElIcon? icon;

  @override
  State<ElIconButtonItem> createState() => _ElIconButtonItemState();
}

class _ElIconButtonItemState extends State<ElIconButtonItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
