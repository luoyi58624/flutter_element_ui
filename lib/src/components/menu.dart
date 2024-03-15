part of flutter_element_ui;

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
          child: _ElMenuWidget(modelList: widget.modelList),
        ),
      ),
    );
  }
}

class _ElMenuWidget extends StatefulWidget {
  const _ElMenuWidget({
    required this.modelList,
  });

  final List<ElMenuModel> modelList;

  @override
  State<_ElMenuWidget> createState() => _ElMenuWidgetState();
}

class _ElMenuWidgetState extends State<_ElMenuWidget> {
  bool _expand = false;

  void setExpand(bool value) {
    setState(() {
      _expand = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.modelList.map((e) => buildItem(e)).toList(),
    );
  }

  Widget buildItem(ElMenuModel model) {
    bool hasChild = model.children != null && model.children!.isNotEmpty;
    return Column(
      children: [
        _MenuItemWidget(
          model: model,
          expand: _expand,
          setExpand: setExpand,
        ),
        if (hasChild && _expand)
          _ElMenuWidget(
            modelList: model.children!,
          )
      ],
    );
  }
}

class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget({
    required this.model,
    required this.expand,
    required this.setExpand,
  });

  final ElMenuModel model;
  final bool expand;
  final void Function(bool value) setExpand;

  @override
  State<_MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  bool _onHover = false;

  Color get textBlack => ElApp.of(context).themeData.textBlack;

  Color get textWhite => ElApp.of(context).themeData.textWhite;

  Color get parentBgColor => _ElMenuData.of(context).background;

  Color get textColor => parentBgColor.isDark ? textWhite : textBlack;

  Color get hoverColor => parentBgColor.isDark ? parentBgColor.brighten(15) : parentBgColor.darken(15);

  bool get hasChild => widget.model.children != null && widget.model.children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
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
            widget.setExpand(!widget.expand);
          }
        },
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: _onHover ? hoverColor : parentBgColor,
          ),
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                  child: widget.model.icon == null
                      ? null
                      : Icon(
                          widget.model.icon,
                          color: textColor,
                          size: 20,
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
                    width: 44,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: widget.expand ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: textColor,
                        size: 20,
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
