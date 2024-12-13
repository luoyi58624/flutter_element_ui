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
          content: [
            'ElButton 提供的参数只适用于大部分常用场景，您可以通过继承 ElButton 来实现更灵活的样式，'
                '例如下面这个例子便是通过继承 ElButton 来实现的渐变按钮'
          ],
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
    final loading = useState(false);
    openLoading() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    return Row(
      spacing: 8,
      children: [
        CustomButton(
          onPressed: openLoading,
          loading: loading.value,
          child: '开启 loading',
        ),
        CustomButton(
          onPressed: () {
            count.value++;
          },
          child: 'count: ${count.value}',
        ),
      ],
    );
  }
}

class CustomButton extends ElButton2 {
  const CustomButton({
    super.key,
    required super.child,
    super.loading,
    super.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends ElButton2State<CustomButton> {
  @override
  Duration get decorationDuration => const Duration(milliseconds: 200);

  @override
  Curve get decorationCurve => Curves.easeOut;

  /// 使用自定义 loading 构造器，这里使用链接按钮默认的 loading
  @override
  WidgetBuilder? get loadingBuilder => ElLinkButton.defaultLoadingBuilder;

  /// 自定义按钮的颜色集合，由于我们要创建渐变按钮，所以不需要背景颜色、边框颜色
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
      color: widget.loading ? colorRecord.bgColor : null,
      borderRadius: borderRadius,
      // 创建渐变色，loading 状态会移除渐变色使用默认背景
      gradient: widget.loading
          ? null
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // 这里我们监听悬停、点击事件来改变渐变颜色
              colors: context.hasHover || context.hasTap
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
    final loading = useState(false);
    openLoading() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    return Row(
      spacing: 8,
      children: [
        CustomButton(
          onPressed: openLoading,
          loading: loading.value,
          child: '开启 loading',
        ),
        CustomButton(
          onPressed: () {
            count.value++;
          },
          child: 'count: \${count.value}',
        ),
      ],
    );
  }
}

class CustomButton extends ElButton2 {
  const CustomButton({
    super.key,
    required super.child,
    super.loading,
    super.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends ElButton2State<CustomButton> {
  @override
  Duration get decorationDuration => const Duration(milliseconds: 200);

  @override
  Curve get decorationCurve => Curves.easeOut;

  /// 使用自定义 loading 构造器，这里使用链接按钮默认的 loading
  @override
  WidgetBuilder? get loadingBuilder => ElLinkButton.defaultLoadingBuilder;

  /// 自定义按钮的颜色集合，由于我们要创建渐变按钮，所以不需要背景颜色、边框颜色
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
      color: widget.loading ? colorRecord.bgColor : null,
      borderRadius: borderRadius,
      // 创建渐变色，loading 状态会移除渐变色使用默认背景
      gradient: widget.loading
          ? null
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // 这里我们监听悬停、点击事件来改变渐变颜色
              colors: context.hasHover || context.hasTap
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
