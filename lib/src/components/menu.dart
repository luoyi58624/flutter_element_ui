part of flutter_element_ui;

const double _gapValue = 20;

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
    this.modelList, {
    super.key,
    this.width = 250,
    this.background,
  });

  final List<ElMenuModel> modelList;
  final double width;
  final Color? background;

  @override
  State<ElMenu> createState() => _ElMenuState();
}

class _ElMenuState extends State<ElMenu> {
  Color get background => widget.background ?? ElApp.of(context).themeData.menuBackground;

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
            modelList: widget.modelList,
            gap: _gapValue,
          ),
        ),
      ),
    );
  }
}

class _ElMenuWidget extends StatefulWidget {
  const _ElMenuWidget({
    required this.modelList,
    required this.gap,
  });

  final List<ElMenuModel> modelList;

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
      children: widget.modelList
          .map(
            (e) => _MenuItemWidget(
              model: e,
              gap: widget.gap,
            ),
          )
          .toList(),
    );
  }
}

class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget({
    required this.model,
    required this.gap,
  });

  final ElMenuModel model;
  final double gap;

  @override
  State<_MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  bool _expand = false;
  bool _onHover = false;
  bool _onTap = false;

  Color get textBlack => ElApp.of(context).themeData.textBlack;

  Color get textWhite => ElApp.of(context).themeData.textWhite;

  Color get parentBgColor => _ElMenuData.of(context).background;

  Color get textColor => parentBgColor.isDark ? textWhite : textBlack;

  Color get hoverColor => parentBgColor.isDark ? parentBgColor.brighten(10) : parentBgColor.darken(10);

  Color get tapColor => parentBgColor.isDark ? parentBgColor.brighten(15) : parentBgColor.darken(15);

  bool get hasChild => widget.model.children != null && widget.model.children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildItem(),
        if (hasChild)
          AnimatedCrossFade(
            firstChild: Container(height: 0.0),
            secondChild: _ElMenuWidget(
              modelList: widget.model.children!,
              gap: widget.gap + _gapValue,
            ),
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: _expand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
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
        onTapDown: (e) {
          setState(() {
            _onTap = true;
          });
        },
        onTapCancel: () {
          setState(() {
            _onTap = false;
          });
        },
        onTap: () {
          setState(() {
            _onTap = false;
          });
          if (hasChild) {
            setState(() {
              _expand = !_expand;
            });
          }
        },
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: _onTap
                ? tapColor
                : _onHover
                    ? hoverColor
                    : parentBgColor,
          ),
          child: Center(
            child: Row(
              children: [
                SizedBox(width: widget.gap),
                if (widget.model.icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      widget.model.icon,
                      color: textColor,
                      size: 18,
                    ),
                  ),
                Text(
                  widget.model.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const Expanded(child: SizedBox()),
                if (hasChild)
                  SizedBox(
                    width: 40,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _expand ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: textColor,
                        size: 18,
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
}
