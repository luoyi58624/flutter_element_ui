part of flutter_element_ui;

/// 嵌套子菜单距离上一层级的间距
const double _defaultGap = 20;

class ElMenuModel {
  /// 菜单名字
  String title;

  /// 菜单图标
  ElIcon? icon;

  /// 菜单对应的路由地址
  String? path;

  /// 子菜单
  List<ElMenuModel>? children;

  ElMenuModel({
    required this.title,
    this.icon,
    this.path,
    this.children,
  });
}

class _ElMenuData extends InheritedWidget {
  const _ElMenuData({
    required super.child,
    required this.background,
    required this.activePath,
    required this.onChange,
  });

  final Color background;
  final String? activePath;
  final void Function(ElMenuModel menu)? onChange;

  static _ElMenuData of(BuildContext context) {
    final _ElMenuData? result = context.dependOnInheritedWidgetOfExactType<_ElMenuData>();
    return result!;
  }

  @override
  bool updateShouldNotify(_ElMenuData old) {
    return true;
  }
}

/// Element UI 导航菜单组件
class ElMenu extends StatefulWidget {
  const ElMenu(
    this.menuList, {
    super.key,
    this.width = 240,
    this.background,
    this.activePath,
    this.onChange,
  });

  final List<ElMenuModel> menuList;
  final double width;
  final Color? background;

  /// 激活的路由地址
  final String? activePath;

  final void Function(ElMenuModel menu)? onChange;

  @override
  State<ElMenu> createState() => _ElMenuState();
}

class _ElMenuState extends State<ElMenu> {
  Color get background => widget.background ?? ElAppData.of(context).currentTheme.menuBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: background,
      ),
      child: _ElMenuData(
        background: background,
        activePath: widget.activePath,
        onChange: widget.onChange,
        child: SingleChildScrollView(
          child: _MenuWidget(
            menuList: widget.menuList,
            gap: _defaultGap,
          ),
        ),
      ),
    );
  }
}

class _MenuWidget extends StatefulWidget {
  const _MenuWidget({
    required this.menuList,
    required this.gap,
  });

  final List<ElMenuModel> menuList;

  /// 间距，每展开一层，子元素的间距越深
  final double gap;

  @override
  State<_MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<_MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.menuList
          .map(
            (e) => _MenuItemWidget(
              menuItem: e,
              gap: widget.gap,
            ),
          )
          .toList(),
    );
  }
}

class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget({
    required this.menuItem,
    required this.gap,
  });

  final ElMenuModel menuItem;
  final double gap;

  @override
  State<_MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  bool _expand = false;

  bool get hasChild => widget.menuItem.children != null && widget.menuItem.children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (hasChild) {
              setState(() {
                _expand = !_expand;
              });
            } else {
              if (_ElMenuData.of(context).onChange != null) _ElMenuData.of(context).onChange!(widget.menuItem);
            }
          },
          child: _MenuItemContentWidget(
            menuItem: widget.menuItem,
            hasChild: hasChild,
            expand: _expand,
            gap: widget.gap,
          ),
        ),
        if (hasChild) buildChildMenu(),
      ],
    );
  }

  Widget buildChildMenu() {
    return AnimatedCrossFade(
      firstChild: Container(height: 0.0),
      secondChild: _MenuWidget(
        menuList: widget.menuItem.children!,
        gap: widget.gap + _defaultGap,
      ),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: _expand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class _MenuItemContentWidget extends StatefulWidget {
  const _MenuItemContentWidget({
    required this.menuItem,
    required this.hasChild,
    required this.expand,
    required this.gap,
  });

  final ElMenuModel menuItem;
  final bool hasChild;
  final bool expand;
  final double gap;

  @override
  State<_MenuItemContentWidget> createState() => _MenuItemContentWidgetState();
}

class _MenuItemContentWidgetState extends State<_MenuItemContentWidget> with ElMouseMixin, _ElThemeMixin {
  Color get parentBgColor => _ElMenuData.of(context).background;

  String? get activePath => _ElMenuData.of(context).activePath;

  String? get currentPath => widget.menuItem.path;

  Color get _textColor => parentBgColor.isDark ? $textWhiteColor : $textBlackColor;

  Color get menuItemColor {
    if (currentPath == '/') {
      return activePath == '/' ? $menuActiveColor : _textColor;
    } else {
      if (activePath != null && currentPath != null && activePath!.contains(currentPath!)) {
        return $menuActiveColor;
      }
    }
    return _textColor;
  }

  Color get hoverColor => parentBgColor.hsp < 50 ? parentBgColor.brighten(15) : parentBgColor.darken(15);

  @override
  Widget build(BuildContext context) {
    return buildMouseWidget(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: onHover ? hoverColor : parentBgColor,
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: widget.gap),
              if (widget.menuItem.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElDefaultIconStyle(
                    color: menuItemColor,
                    child: widget.menuItem.icon!,
                  ),
                ),
              Text(
                widget.menuItem.title,
                style: TextStyle(
                  color: menuItemColor,
                  fontSize: 14,
                ),
              ),
              const Expanded(child: SizedBox()),
              if (widget.hasChild)
                SizedBox(
                  width: 40,
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: widget.expand ? 0.5 : 0,
                    child: ElIcon.svg(
                      ElIcons.arrowDown,
                      color: menuItemColor,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
