part of flutter_element_ui;

/// 每一层级距离上一级的间距
const double _defaultGap = 20;

class ElMenuModel {
  String title;
  IconData? icon;
  List<ElMenuModel>? children;

  ElMenuModel({
    required this.title,
    this.icon,
    this.children,
  });
}

class _ElMenuData extends InheritedWidget {
  const _ElMenuData({
    required super.child,
    required this.background,
  });

  final Color background;

  static _ElMenuData of(BuildContext context) {
    final _ElMenuData? result = context.dependOnInheritedWidgetOfExactType<_ElMenuData>();
    return result!;
  }

  @override
  bool updateShouldNotify(_ElMenuData old) {
    return true;
  }
}

/// Element UI 菜单栏组件
class ElMenu extends StatefulWidget {
  const ElMenu(
    this.menuList, {
    super.key,
    this.width = 250,
    this.background,
  });

  final List<ElMenuModel> menuList;
  final double width;
  final Color? background;

  @override
  State<ElMenu> createState() => _ElMenuState();
}

class _ElMenuState extends State<ElMenu> {
  Color get background => widget.background ?? ElApp.of(context).theme.menuBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      decoration: BoxDecoration(
        color: background,
      ),
      child: _ElMenuData(
        background: background,
        child: SingleChildScrollView(
          child: _ElMenuWidget(
            menuList: widget.menuList,
            gap: _defaultGap,
          ),
        ),
      ),
    );
  }
}

class _ElMenuWidget extends StatefulWidget {
  const _ElMenuWidget({
    required this.menuList,
    required this.gap,
  });

  final List<ElMenuModel> menuList;

  /// 间距，每展开一层，子元素的间距越深
  final double gap;

  @override
  State<_ElMenuWidget> createState() => _ElMenuWidgetState();
}

class _ElMenuWidgetState extends State<_ElMenuWidget> {
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
  bool _onHover = false;

  Color get textWhite => ElApp.of(context).darkTheme.textColor;

  Color get textBlack => ElApp.of(context).theme.textColor;

  Color get parentBgColor => _ElMenuData.of(context).background;

  Color get textColor => parentBgColor.isDark ? textWhite : textBlack;

  Color get hoverColor => parentBgColor.hsp < 50 ? parentBgColor.brighten(15) : parentBgColor.darken(15);

  bool get hasChild => widget.menuItem.children != null && widget.menuItem.children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildItem(),
        if (hasChild) buildChildMenu(),
      ],
    );
  }

  Widget buildItem() {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          _onHover = true;
        });
      },
      onExit: (e) {
        setState(() {
          _onHover = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (hasChild) {
            setState(() {
              _expand = !_expand;
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: _onHover ? hoverColor : parentBgColor,
          ),
          child: Center(
            child: Row(
              children: [
                SizedBox(width: widget.gap),
                if (widget.menuItem.icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      widget.menuItem.icon,
                      color: textColor,
                      size: 18,
                    ),
                  ),
                Text(
                  widget.menuItem.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
                const Expanded(child: SizedBox()),
                if (hasChild)
                  SizedBox(
                    width: 40,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _expand ? 0.5 : 0,
                      child: ElIcon.svg(
                        ElIcons.arrowDown,
                        color: textColor,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChildMenu() {
    return AnimatedCrossFade(
      firstChild: Container(height: 0.0),
      secondChild: _ElMenuWidget(
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
