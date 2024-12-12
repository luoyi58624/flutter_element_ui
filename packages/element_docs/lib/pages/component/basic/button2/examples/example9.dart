import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example9 extends StatelessWidget {
  const Example9({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: ['您可以通过继承 ElButton 来实现更灵活的样式，例如渐变按钮'],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [_Example()],
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return CustomButton(
      onPressed: () {
        count.value++;
      },
      child: 'count: ${count.value}',
    );
  }
}

/// 继承 ElButton
class CustomButton extends ElButton2 {
  const CustomButton({
    super.key,
    required super.child,
    super.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends ElButton2State<CustomButton> {
  /// 自定义按钮的颜色集合，这里我们固定按钮颜色为白色，由于我们要创建渐变按钮，
  /// 所以不需要设置背景颜色、边框颜色
  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    return (
      bgColor: null,
      textColor: Colors.white,
      borderColor: null,
    );
  }

  /// 构建按钮的 [BoxDecoration] 装饰
  @override
  BoxDecoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      // 应用按钮圆角，sizePreset 是计算好的自适应尺寸预设
      borderRadius: BorderRadius.circular(sizePreset.radius!),
      // 创建渐变色，这里我们监听点击事件来改变渐变颜色
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: context.hasTap
            ? [Colors.purple, Colors.blue]
            : [Colors.pink, Colors.green],
      ),
    );
  }

  /// 这里是对按钮进行一个高斯模糊
  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(sizePreset.radius!),
      child: super.buildButtonWrapper(
        context,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: child,
        ),
      ),
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return CustomButton(
      onPressed: () {
        count.value++;
      },
      child: 'count: \${count.value}',
    );
  }
}

/// 继承 ElButton
class CustomButton extends ElButton2 {
  const CustomButton({
    super.key,
    required super.child,
    super.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends ElButton2State<CustomButton> {
  /// 自定义按钮的颜色集合，这里我们固定按钮颜色为白色，由于我们要创建渐变按钮，
  /// 所以不需要设置背景颜色、边框颜色
  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    return (
      bgColor: null,
      textColor: Colors.white,
      borderColor: null,
    );
  }

  /// 构建按钮的 [BoxDecoration] 装饰
  @override
  BoxDecoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      // 应用按钮圆角，sizePreset 是计算好的自适应尺寸预设
      borderRadius: BorderRadius.circular(sizePreset.radius!),
      // 创建渐变色，这里我们监听点击事件来改变渐变颜色
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: context.hasTap
            ? [Colors.purple, Colors.blue]
            : [Colors.pink, Colors.green],
      ),
    );
  }

  /// 这里是对按钮进行一个高斯模糊
  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(sizePreset.radius!),
      child: super.buildButtonWrapper(
        context,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: child,
        ),
      ),
    );
  }
}''';
