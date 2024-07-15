part of 'menu.dart';

/// 用于递归循环构建嵌套菜单小部件
class _Menu extends StatelessWidget {
  const _Menu(this.menuList, this.gap);

  final List<ElMenuModel> menuList;

  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: menuList.map((e) => _MenuItem(e, gap)).toList(),
    );
  }
}

class _MenuItem extends HookWidget {
  const _MenuItem(this.menuItem, this.gap);

  final ElMenuModel menuItem;
  final double gap;

  bool get hasChild =>
      menuItem.children != null && menuItem.children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (hasChild) {
      assert(menuItem.collapse != null, 'ElMenu存在子菜单，请设置 collapse 状态变量');
    }
    final $data = _ElMenuData.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (hasChild) {
              menuItem.collapse!.value = !menuItem.collapse!.value;
            } else {
              if ($data.onChange != null) {
                $data.onChange!(menuItem);
              }
            }
          },
          child: _MenuItemContentWidget(
            menuItem: menuItem,
            hasChild: hasChild,
            gap: gap,
          ),
        ),
        if (hasChild && !$data.collapse)
          ValueListenableBuilder(
            valueListenable: menuItem.collapse!,
            builder: (context, value, child) {
              return AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity, height: 0),
                secondChild: _Menu(
                  menuItem.children!,
                  gap + $data.gap,
                ),
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration:
                    Duration(milliseconds: context.elConfig.collapseDuration),
              );
            },
          ),
      ],
    );
  }
}

class _MenuItemContentWidget extends StatefulWidget {
  const _MenuItemContentWidget({
    required this.menuItem,
    required this.hasChild,
    required this.gap,
  });

  final ElMenuModel menuItem;
  final bool hasChild;
  final double gap;

  @override
  State<_MenuItemContentWidget> createState() => _MenuItemContentWidgetState();
}

class _MenuItemContentWidgetState extends State<_MenuItemContentWidget> {
  Color get parentBgColor => _ElMenuData.of(context).bgColor;

  String? get activePath => _ElMenuData.of(context).activePath;

  String? get currentPath => widget.menuItem.path;

  Color get _textColor => parentBgColor.elTextColor(context);

  Color get menuItemColor {
    if (currentPath == '/') {
      return activePath == '/' ? context.elTheme.menuActiveColor : _textColor;
    } else {
      if (activePath != null &&
          currentPath != null &&
          activePath!.contains(currentPath!)) {
        return context.elTheme.menuActiveColor;
      }
    }
    return _textColor;
  }

  Color get hoverColor => parentBgColor.hsp < 50
      ? parentBgColor.brighten(16)
      : parentBgColor.darken(8);

  @override
  Widget build(BuildContext context) {
    return ElHover(
      builder: (isHover) => AnimatedContainer(
        duration: Duration(milliseconds: context.elConfig.bgTransition),
        curve: Curves.easeOut,
        height: 56,
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isHover ? hoverColor : parentBgColor,
        ),
        child: Row(
          children: [
            SizedBox(width: widget.gap),
            if (widget.menuItem.icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElIcon(
                  widget.menuItem.icon!,
                  color: menuItemColor,
                  size: _ElMenuData.of(context).iconSize,
                ),
              ),
            if (!_ElMenuData.of(context).collapse)
              Expanded(
                child: ElText(
                  widget.menuItem.title,
                  style: TextStyle(
                    color: menuItemColor,
                    fontSize: 14,
                  ),
                  // maxLines: 1,
                  // overflow: TextOverflow.clip,
                ),
              ),
            if (widget.hasChild && !_ElMenuData.of(context).collapse)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40,
                  margin: const EdgeInsets.only(left: 8),
                  child: ValueListenableBuilder(
                    valueListenable: widget.menuItem.collapse!,
                    builder: (context, value, child) {
                      return AnimatedRotation(
                        duration: Duration(
                            milliseconds:
                                max(context.elConfig.collapseDuration - 50, 0)),
                        turns: widget.menuItem.collapse!.value ? 0.5 : 0,
                        child: ElIcon(
                          ElIcons.arrowDown,
                          color: menuItemColor,
                          size: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
