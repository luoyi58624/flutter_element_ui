part of flutter_element_ui;

class ElButton extends StatefulWidget {
  const ElButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.type,
    this.plain = false,
    this.round = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final ElThemeType? type;
  final bool plain;
  final bool round;

  @override
  State<ElButton> createState() => _ElButtonState();
}

class _ElButtonState extends State<ElButton> {
  bool _onHover = false;
  bool _onTap = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.onPressed != null
          ? (e) {
              setState(() {
                _onHover = true;
              });
            }
          : null,
      onExit: widget.onPressed != null
          ? (e) {
              setState(() {
                _onHover = false;
              });
            }
          : null,
      cursor: widget.onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTapDown: widget.onPressed != null
            ? (e) {
                setState(() {
                  _onTap = true;
                });
              }
            : null,
        onTapCancel: widget.onPressed != null
            ? () {
                setState(() {
                  _onTap = false;
                });
              }
            : null,
        onTap: widget.onPressed != null
            ? () {
                setState(() {
                  _onTap = false;
                });
                widget.onPressed!();
              }
            : null,
        child: widget.type == null ? _defaultButton : _themeButton,
      ),
    );
  }

  double get roundValue => widget.round ? 20 : 6;

  Widget get _defaultButton {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color? backgroundColor;
    Color borderColor = ElApp.of(context).theme.defaultBorderColor;
    if (widget.onPressed == null) {
      borderColor = borderColor.withOpacity(0.6);
      textColor = textColor.withAlpha(120);
    } else {
      backgroundColor = _onHover ? primaryColor.withOpacity(0.1) : null;
      borderColor = _onTap
          ? primaryColor
          : _onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(roundValue),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: textColor),
        child: Text(widget.text),
      ),
    );
  }

  Widget get _themeButton {
    Color backgroundColor = ElApp.of(context).themeColors[widget.type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    Border? border;
    if (widget.onPressed == null) {
      backgroundColor = backgroundColor.withOpacity(0.6);
    } else if (widget.plain) {
      textColor = _onTap || _onHover ? textColor : backgroundColor;
      border = Border.all(color: backgroundColor.withOpacity(0.5));
      backgroundColor = _onTap
          ? _ColorUtil.darken(backgroundColor, 15)
          : _onHover
              ? backgroundColor
              : backgroundColor.withAlpha(25);
    } else {
      textColor = const Color(0xffffffff);
      backgroundColor = _onTap
          ? _ColorUtil.getLightnessColor(backgroundColor, 0.85)
          : _onHover
              ? backgroundColor.withOpacity(0.8)
              : backgroundColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: BorderRadius.circular(roundValue),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: textColor),
        child: Text(widget.text),
      ),
    );
  }
}
