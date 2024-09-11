import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class FlutterColorData {
  FlutterColorData._();

  static List<MaterialColor> materialColors = [
    Colors.cyan,
    Colors.green,
    Colors.amber,
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.blueGrey,
    Colors.brown,
    Colors.yellow,
    Colors.teal,
    Colors.lightBlue,
    Colors.lime,
    Colors.lightGreen,
    Colors.grey,
    Colors.pink,
    Colors.deepOrange,
  ];

  static List<int> materialColorSwatchs = [
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  ];

  static List<Color> get expandMaterialSwatchColors {
    return [
      ...materialColorSwatchs.map((e) => Colors.cyan[e]!),
      ...materialColorSwatchs.map((e) => Colors.green[e]!),
      ...materialColorSwatchs.map((e) => Colors.amber[e]!),
      ...materialColorSwatchs.map((e) => Colors.indigo[e]!),
      ...materialColorSwatchs.map((e) => Colors.blue[e]!),
      ...materialColorSwatchs.map((e) => Colors.red[e]!),
      ...materialColorSwatchs.map((e) => Colors.purple[e]!),
      ...materialColorSwatchs.map((e) => Colors.blueGrey[e]!),
      ...materialColorSwatchs.map((e) => Colors.brown[e]!),
      ...materialColorSwatchs.map((e) => Colors.yellow[e]!),
      ...materialColorSwatchs.map((e) => Colors.teal[e]!),
      ...materialColorSwatchs.map((e) => Colors.lightBlue[e]!),
      ...materialColorSwatchs.map((e) => Colors.lime[e]!),
      ...materialColorSwatchs.map((e) => Colors.lightGreen[e]!),
      ...materialColorSwatchs.map((e) => Colors.grey[e]!),
      ...materialColorSwatchs.map((e) => Colors.pink[e]!),
      ...materialColorSwatchs.map((e) => Colors.deepOrange[e]!),
    ];
  }
}

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('主色'),
        const SectionText('Element UI 默认的主题色是明亮、友好的蓝色。'),
        textGap,
        CodeExampleWidget(
          code: code,
          children: [
            buildPresetColors(context),
            const Gap(8),
            buildPrimaryColor(context),
          ],
        ),
      ],
    );
  }

  Widget buildPresetColors(BuildContext context) {
    return Wrap(
      children: [
        ElThemeData.theme.primary,
        ElThemeData.theme.warning,
        ...FlutterColorData.materialColors
      ].map((color) {
        return ObsBuilder(builder: (context) {
          final isActive = GlobalState.primaryColor.value == color;
          return Ink(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color),
            child: InkWell(
              onTap: () {
                GlobalState.primaryColor.value = color;
              },
              child: Container(
                child: isActive
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget buildPrimaryColor(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: context.elTheme.primary,
              ),
              child: SelectionArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElText(
                      'Primary Color',
                      style: TextStyle(
                          color: GlobalState.primaryColor.value
                              .elTextColor(context)),
                    ),
                    const Gap(4),
                    ElText(
                      context.elTheme.primary.toHex(),
                      style: TextStyle(
                        fontSize: 0.875.rem(context),
                        color:
                            GlobalState.primaryColor.value.elTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: context.elTheme.primary
                  .elColors(context)
                  .map(
                    (e) => Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: GestureDetector(
                          onTap: () async {
                            CommonUtil.copy(e.toHex(), copyMessage: e.toHex());
                          },
                          child: ElHoverBuilder(
                              cursor: SystemMouseCursors.click,
                              builder: (context) {
                                return AnimatedContainer(
                                  duration: 150.ms,
                                  curve: Curves.easeOut,
                                  decoration: BoxDecoration(
                                    color: e,
                                    border: Border.all(
                                      width: context.isHover
                                          ? 4
                                          : 0.0000000000000001,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

String get code => '''
// elColors 是 Color 对象的扩展函数，它会返回 elLight1 - elLight9 等 9 种级别颜色
Row(
  children: context.elTheme.primary.elColors(context).map((e) => Expanded(
    child: AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTap: () async {
          final colorText = e.toHex();
          await Clipboard.setData(ClipboardData(text: colorText));
          el.message.success('复制成功: \$colorText');
        },
        child: ElHoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            return AnimatedContainer(
              duration: 150.ms,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: e,
                border: Border.all(
                  // 直接写 0 会有 1 像素边框，啥原理我也不知道
                  width: context.isHover ? 4 : 0.0000000000000001,
                  color: Colors.white,
                ),
              ),
            );
          }),
      ),
    ),
  )).toList(),
),
''';
