import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

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
    ElAppData.of(context).themeColors.forEach((key, value) {
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

    ElAppData.of(context).themeColors.forEach((key, value) {
      colors2.add(generaColors(value));
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('主题颜色'),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                children: colors1
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
              ),
              const SizedBox(height: 8),
              Column(
                children: colors2
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
              ),
            ],
          ),
        ));
  }
}
