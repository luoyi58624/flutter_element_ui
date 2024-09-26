part of 'index.dart';

class _ElNavMenuState extends State<ElNavMenu> {
  /// 激活的菜单层级链
  List<String> activeKeyList = [];

  /// 以路由地址作为菜单key，使用此变量前必须用 router 构造函数
  String get routeKey {
    assert(widget.router != null);
    return widget.router!.routerDelegate.currentConfiguration.uri.path;
  }

  @override
  void initState() {
    super.initState();
    if (widget.router != null) {
      setActiveKey(routeKey);
      widget.router!.routerDelegate.addListener(_routerListen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.router != null) {
      widget.router!.routerDelegate.removeListener(_routerListen);
    }
  }

  @override
  void didUpdateWidget(covariant ElNavMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.router != oldWidget.router) {
      if (oldWidget.router != null) {
        oldWidget.router!.routerDelegate.removeListener(_routerListen);
      }
      if (widget.router != null) {
        widget.router!.routerDelegate.addListener(_routerListen);
      }
    }
  }

  void _routerListen() {
    final path = routeKey;
    if (path.startsWith(widget.rootRouterPath)) {
      if (activeKeyList.isEmpty || activeKeyList.last != path) {
        setState(() {
          setActiveKey(path);
        });
      }
    }
  }

  /// 设置激活的菜单key
  void setActiveKey(String key) {
    activeKeyList = _getKeys(widget.menuList, key, []).$2;
  }

  /// 使用递归找到当前 key，并返回完整的的菜单层级链
  (bool, List<String>) _getKeys(
    List<ElMenuModel> menuList,
    String key,
    List<String> parent,
  ) {
    bool flag = false;
    for (final $menu in menuList) {
      if ($menu.children.isEmpty) {
        if ($menu.key == key) {
          parent.add($menu.key);
          flag = true;
          break;
        } else if ($menu == menuList.last) {
          parent.removeLast();
        }
      } else {
        parent.add($menu.key);
        final result = _getKeys($menu.children, key, parent);
        if (result.$1) {
          flag = true;
          break;
        }
      }
    }
    return (flag, parent);
  }

  @override
  Widget build(BuildContext context) {
    final $bgColor = widget.bgColor ?? context.elTheme.asideTheme.color;
    if (widget.router == null) setActiveKey(widget.activeKey!);
    return AnimatedContainer(
      duration: context.elThemeDuration ?? Duration.zero,
      color: $bgColor,
      child: SizedBox(
        width: widget.width,
        child: _MenuNavigationInheritedWidget(
          activeKeyList: activeKeyList,
          bgColor: $bgColor,
          iconSize: widget.iconSize,
          gap: widget.gap,
          router: widget.router,
          onChange: widget.onChange,
          child: SingleChildScrollView(
            child: _Menu(widget.menuList, widget.gap),
          ),
        ),
      ),
    );
  }
}

class _MenuNavigationInheritedWidget extends InheritedWidget {
  const _MenuNavigationInheritedWidget({
    required super.child,
    required this.activeKeyList,
    required this.bgColor,
    required this.iconSize,
    required this.gap,
    this.router,
    required this.onChange,
  });

  final List<String> activeKeyList;
  final Color bgColor;
  final double iconSize;
  final double gap;
  final RouterConfig? router;

  final void Function(ElMenuModel menu)? onChange;

  static _MenuNavigationInheritedWidget of(BuildContext context) {
    final _MenuNavigationInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_MenuNavigationInheritedWidget>();
    return result!;
  }

  @override
  bool updateShouldNotify(_MenuNavigationInheritedWidget old) => false;
}

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
  late _MenuNavigationInheritedWidget $data;
  late bool hasChild;
  late bool isActive;

  @override
  Widget build(BuildContext context) {
    $data = _MenuNavigationInheritedWidget.of(context);
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

  Widget buildItem(_MenuNavigationInheritedWidget $data) {
    Color bgColor = $data.bgColor;
    Color menuItemColor = isActive
        ? context.elTheme.navigationMenuTheme.activeTextColor
        : bgColor.elTextColor(context);
    Widget result = GestureDetector(
      onTap: () {
        if (hasChild) {
          setState(() {
            isManual = true;
            expanded = !expanded;
          });
          ElUtil.nextTick(() async {
            isManual = false;
          });
        } else {
          if ($data.onChange != null) {
            $data.onChange!(widget.menuItem);
          }
        }
      },
      child: Builder(builder: (context) {
        return AnimatedColoredBox(
          duration:
              context.elThemeDuration ?? const Duration(milliseconds: 100),
          curve: context.elThemeCurve ?? Curves.easeOut,
          color: bgColor.on(HoverBuilder.of(context),
              scale: bgColor.isDark ? 16 : 10),
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
                        size:
                            _MenuNavigationInheritedWidget.of(context).iconSize,
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
      return HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (context) => result,
      );
    }
  }
}
