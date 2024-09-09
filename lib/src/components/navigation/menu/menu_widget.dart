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

class _MenuItem extends StatefulWidget {
  const _MenuItem(this.menuItem, this.gap);

  final ElMenuModel menuItem;
  final double gap;

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool expanded = false;

  // 是否手动操作了折叠开关，因为在build中，如果当前菜单被激活，会自动展开折叠菜单，
  // 所以，当手动关闭折叠菜单时需要在短时间内禁止自动展开菜单
  bool isManual = false;
  late _ElMenuData $data;
  late bool hasChild;
  late bool isActive;

  @override
  Widget build(BuildContext context) {
    $data = _ElMenuData.of(context);
    hasChild = widget.menuItem.children.isNotEmpty;
    isActive = $data.activeKeyList.contains(widget.menuItem.key);
    if (isActive && !expanded && !isManual) expanded = true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildItem($data),
        if (hasChild)
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: _Menu(
              widget.menuItem.children,
              widget.gap + $data.gap,
            ),
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: 250.ms,
          )
      ],
    );
  }

  Widget buildItem(_ElMenuData $data) {
    Color bgColor = $data.bgColor;
    Color menuItemColor = isActive
        ? context.elTheme.navigationMenuStyle.activeTextColor
        : bgColor.elTextColor(context);
    Widget result = GestureDetector(
      onTap: () {
        if (hasChild) {
          setState(() {
            isManual = true;
            expanded = !expanded;
          });
          FlutterUtil.nextTick(() async {
            isManual = false;
          });
        } else {
          if ($data.onChange != null) {
            $data.onChange!(widget.menuItem);
          }
        }
      },
      child: Builder(builder: (context) {
        return ColoredBox(
          color: bgColor.on(ElHoverBuilder.of(context), scale: 6),
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
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
                  Expanded(
                    child: ElText(
                      widget.menuItem.title,
                      style: TextStyle(
                        color: menuItemColor,
                        fontSize: 14,
                        fontWeight: ElFont.medium,
                      ),
                      // maxLines: 1,
                      // overflow: TextOverflow.clip,
                    ),
                  ),
                  if (hasChild)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 40,
                        margin: const EdgeInsets.only(left: 8),
                        child: AnimatedRotation(
                          duration: 200.ms,
                          turns: expanded ? 0.5 : 0,
                          child: ElIcon(
                            ElIcons.arrowDown,
                            color: menuItemColor,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
    if (!hasChild && $data.router != null) {
      return ElLink(
        href: widget.menuItem.key,
        cursor: MouseCursor.defer,
        child: result,
      );
    } else {
      return ElHoverBuilder(
        builder: (context) => result,
      );
    }
  }
}
