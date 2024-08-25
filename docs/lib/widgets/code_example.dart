import 'package:docs/global.dart';
import 'package:flutter/material.dart';
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

    if (_initialize == false || _lightCode == null || _darkCode == null) {
      FlutterUtil.nextTick(() async {
        await Highlighter.initialize(['dart']);
        _initialize = true;
        var lightCodetheme = await HighlighterTheme.loadFromAssets(
          [
            'packages/syntax_highlight/themes/light_vs.json',
            'packages/syntax_highlight/themes/light_plus.json',
          ],
          const TextStyle(color: Color(0xFF000088)),
        );
        var darkCodetheme = await HighlighterTheme.loadFromAssets(
          [
            'assets/code_themes/dark_vs.json',
            'assets/code_themes/dark_plus.json',
            // 'packages/syntax_highlight/themes/dark_vs.json',
            // 'packages/syntax_highlight/themes/dark_plus.json',
          ],
          const TextStyle(color: Color(0xFFD19A66)),
        );
        _lightCode = Highlighter(language: 'dart', theme: lightCodetheme);
        _darkCode = Highlighter(language: 'dart', theme: darkCodetheme);
        if (context.mounted) {
          $code.value =
              (context.isDark ? _darkCode : _lightCode)!.highlight(code);
        }
      });
    } else {
      $code.value = (context.isDark ? _darkCode : _lightCode)!.highlight(code);
    }
    return Container(
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
          TextSelectionTheme(
            data: TextSelectionThemeData(
              selectionColor: context.isDark
                  ? const Color.fromRGBO(51, 103, 209, 0.6)
                  : const Color.fromRGBO(51, 103, 209, 0.3),
            ),
            child: Container(
              color: context.elTheme.bgColor,
              padding: const EdgeInsets.all(16),
              child: ElText(
                $code.value,
                style: const TextStyle(
                  fontFamily: 'Consolas',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: CodeEditor(
          //     controller: CodeLineEditingController.fromText('Hello Reqable'),
          //   ),
          // ),
          // ElCollapse(isCollapse, children: children)
        ],
      ),
    );
  }
}
