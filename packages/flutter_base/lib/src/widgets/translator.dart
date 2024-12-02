import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:translator/translator.dart';

final _translator = GoogleTranslator();

/// 翻译文本小部件
class TranslatorText extends StatefulWidget {
  const TranslatorText({super.key, required this.child});

  final ElText child;

  /// 当前应用的默认语言
  static String defaultLanguage = 'zh-cn';

  /// 支持的语言列表
  static Map<String, String> supportLanguages = {
    '简体中文': 'zh-cn',
    'English': 'en',
  };

  /// 选中的当前语言 value
  static Obs<String> language = Obs(supportLanguages['简体中文']!);

  @override
  State<TranslatorText> createState() => _TranslatorTextState();
}

class _TranslatorTextState extends State<TranslatorText> {
  String? textData;

  bool get isString => widget.child.data is String;

  void execTranslator() async {
    if (TranslatorText.language.value == TranslatorText.defaultLanguage) {
      textData = widget.child.data;
    } else {
      final res = await _translator.translate(
        widget.child.data,
        from: TranslatorText.defaultLanguage,
        to: TranslatorText.language.value,
      );
      if (mounted) {
        setState(() {
          textData = res.text;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (isString) execTranslator();
  }

  @override
  Widget build(BuildContext context) {
    execTranslator();
    if (isString) {
      return ElText(textData ?? widget.child.data, style: widget.child.style);
    } else {
      return ElText(widget.child.data, style: widget.child.style);
    }
  }
}
