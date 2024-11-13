part of 'index.dart';

class _Toast extends StatelessWidget {
  const _Toast(this.content);

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: el.toast.remove,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: context.isDark
                ? const Color.fromRGBO(82, 82, 82, 0.85)
                : const Color.fromRGBO(0, 0, 0, 0.65),
            borderRadius: BorderRadius.circular(6),
          ),
          child: ElText(
            '$content',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ).animate().fade(),
      ),
    );
  }
}

class _ThemeToast extends StatelessWidget {
  const _ThemeToast(this.content, this.type);

  final dynamic content;
  final String type;

  /// 定义 toast 离底部的距离，暂时不可配置
  final double bottomOffset = 80;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
        vertical: bottomPadding >= bottomOffset
            ? bottomPadding + bottomOffset / 4
            : bottomOffset,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: el.toast.remove,
          child: UnconstrainedBox(
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(200.0),
              clipBehavior: Clip.antiAlias,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: context.elThemeColors[type]),
                  child: ElText(
                    '$content',
                    style: const TextStyle(color: Colors.white),
                  )),
            ).animate().fade(),
          ),
        ),
      ),
    );
  }
}
