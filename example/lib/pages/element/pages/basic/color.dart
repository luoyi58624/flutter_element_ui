import 'package:example/global.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  List<Color> generaColors(Color color) {
    List strengths = <double>[0.05];
    List<Color> colors = [];
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i <= 14; i++) {
      strengths.add(0.12 * i);
    }
    for (var strength in strengths) {
      final double ds = 1.0 - strength;
      colors.add(Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      ));
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    List<List<Color>> colors1 = [];
    List<List<Color>> colors2 = [];

    int count = 5;
    context.elThemeColors.forEach((key, value) {
      List<Color> themeColors = [];
      for (int i = count; i >= 1; i--) {
        themeColors.add(value.brighten(15 * i));
      }
      themeColors.add(value);
      for (int i = 1; i <= count; i++) {
        themeColors.add(value.darken(15 * i));
      }
      colors1.add(themeColors);
    });

    context.elThemeColors.forEach((key, value) {
      colors2.add(generaColors(value));
    });

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Column(
            //   children: colors1
            //       .map(
            //         (e) => SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: e
            //                 .map(
            //                   (e) => Container(
            //                     width: 50,
            //                     height: 50,
            //                     color: e,
            //                   ),
            //                 )
            //                 .toList(),
            //           ),
            //         ),
            //       )
            //       .toList(),
            // ),
            // const SizedBox(height: 8),
            // Column(
            //   children: colors2
            //       .map(
            //         (e) => SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: e
            //                 .map(
            //                   (e) => Container(
            //                     width: 50,
            //                     height: 50,
            //                     color: e,
            //                   ),
            //                 )
            //                 .toList(),
            //           ),
            //         ),
            //       )
            //       .toList(),
            // ),
            const Gap(8),
            buildLightElementColor(),
            const Gap(8),
            buildDarkElementColor(),
          ],
        ),
      ),
    );
  }

  Widget buildLightElementColor() {
    List<List<Color>> colors = [];
    context.elThemeColors.forEach((key, value) {
      List<Color> themeColors = [value];
      for (int i = 1; i <= 9; i++) {
        themeColors.add(Colors.white.mix(value, i * 10));
      }
      colors.add(themeColors);
    });
    return Column(
      children: colors
          .map(
            (e) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: e
                    .map(
                      (e) => Container(
                        width: 80,
                        height: 80,
                        color: e,
                        alignment: Alignment.center,
                        child: Text(e.toHex()),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildDarkElementColor() {
    List<List<Color>> colors = [];
    context.elThemeColors.forEach((key, value) {
      List<Color> themeColors = [value];
      for (int i = 1; i <= 9; i++) {
        themeColors.add(value.darken(8 * i));
      }
      colors.add(themeColors);
    });
    return Column(
      children: colors
          .map(
            (e) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: e
                    .map(
                      (e) => Container(
                        width: 50,
                        height: 50,
                        color: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}
