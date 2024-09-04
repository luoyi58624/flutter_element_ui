import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

bool _initialize = false;
Highlighter? _lightCode;
Highlighter? _darkCode;

class CodeExampleWidget extends HookWidget {
  const CodeExampleWidget({
    super.key,
    required this.child,
    required this.code,
  });

  final Widget child;
  final String code;

  @override
  Widget build(BuildContext context) {
    final $code = useState<TextSpan>(const TextSpan());
    final isExpanded = useState(false);
    if (_initialize == false || _lightCode == null || _darkCode == null) {
      FlutterUtil.nextTick(() async {
        await Highlighter.initialize(['dart']);
        _initialize = true;
        var lightCodeTheme = await HighlighterTheme.loadFromAssets(
          [
            'packages/syntax_highlight/themes/light_vs.json',
            'packages/syntax_highlight/themes/light_plus.json',
          ],
          const TextStyle(color: Color(0xFF000088)),
        );
        var darkCodeTheme = await HighlighterTheme.loadFromAssets(
          [
            'assets/code_themes/dark_vs.json',
            'assets/code_themes/dark_plus.json',
          ],
          const TextStyle(color: Color(0xFFD19A66)),
        );
        _lightCode = Highlighter(language: 'dart', theme: lightCodeTheme);
        _darkCode = Highlighter(language: 'dart', theme: darkCodeTheme);
        if (context.mounted) {
          $code.value =
              (context.isDark ? _darkCode : _lightCode)!.highlight(code);
        }
      });
    } else {
      $code.value = (context.isDark ? _darkCode : _lightCode)!.highlight(code);
    }
    return AnimatedContainer(
      duration: el.config.themeDuration,
      decoration: BoxDecoration(
        borderRadius: el.config.cardRadius,
        border: Border.all(
          color: context.elTheme.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: child,
          ),
          const ElDivider(),
          SizedBox(
            height: 36,
            child: Row(
              children: [
                const Spacer(),
                ElButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    el.message.success('复制成功');
                  },
                  link: true,
                  child: Icon(
                    Icons.copy,
                    size: 16,
                    color: context.elTheme.iconColor,
                  ),
                ),
                const Gap(4),
                ElButton(
                  onPressed: () {
                    isExpanded.value = !isExpanded.value;
                  },
                  link: true,
                  child: Icon(
                    Icons.code,
                    size: 20,
                    color: isExpanded.value
                        ? context.elTheme.primary
                        : context.elTheme.iconColor,
                  ),
                ),
                const Gap(8),
              ],
            ),
          ),
          ElCollapseTransition(
            isExpanded.value,
            child: AnimatedContainer(
              duration: el.config.themeDuration,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.elTheme.bgColor.deepen(3),
                borderRadius: BorderRadius.only(
                  bottomLeft: el.config.cardRadius.bottomLeft,
                  bottomRight: el.config.cardRadius.bottomRight,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ObsBuilder(builder: (context) {
                  Widget result = Container(
                    padding: const EdgeInsets.all(16),
                    child: ElText(
                      $code.value,
                      softWrap: false,
                      style: const TextStyle(
                        fontFamily: 'Consolas',
                        fontSize: 14,
                      ),
                    ),
                  );
                  if (GlobalState.enableGlobalTextSelected.value) {
                    if (RouterUtil.isMobile.value == true) {
                      return SelectionArea(child: result);
                    }
                    return result;
                  } else {
                    return SelectionArea(child: result);
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
