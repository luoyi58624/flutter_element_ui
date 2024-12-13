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
            'ElButton 提供的参数有限，但你可以通过继承 ElButton 实现更多样式的按钮，'
                '下面这个例子便以最简单的方式实现渐变按钮'
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
  /// 此方法是构建可交互按钮颜色集合，你可以通过 context.hasHover、context.hasTap 构建各种颜色变体，
  /// 不过我们现在是要创建渐变按钮，所以只需要简单返回一个文本颜色即可
  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    return (
      bgColor: null,
      textColor: Colors.white,
      borderColor: null,
    );
  }

  /// 此方法是构建按钮的装饰，操作此对象完全相当于操作我们常用的 [Container] 小部件
  @override
  BoxDecoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: borderRadius,
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

// /// 这里是对按钮进行一个高斯模糊，为了保持示例代码简单性，这段代码先注释掉
// @override
// Widget buildButtonWrapper(BuildContext context, Widget child) {
//   return ClipRRect(
//     borderRadius: borderRadius!,
//     child: super.buildButtonWrapper(
//       context,
//       BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//         child: child,
//       ),
//     ),
//   );
// }
}

/// 使用示例
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

String get code => '''
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
  /// 此方法是构建可交互按钮颜色集合，你可以通过 context.hasHover、context.hasTap 构建各种颜色变体，
  /// 不过我们现在是要创建渐变按钮，所以只需要简单返回一个文本颜色即可
  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    return (
      bgColor: null,
      textColor: Colors.white,
      borderColor: null,
    );
  }

  /// 此方法是构建按钮的装饰，操作此对象完全相当于操作我们常用的 [Container] 小部件
  @override
  BoxDecoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: borderRadius,
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
}

/// 使用示例
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
}''';
