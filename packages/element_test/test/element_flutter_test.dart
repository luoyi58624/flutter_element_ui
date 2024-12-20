import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void colorTest() {
  test('hsp', () {
    expect('#000000'.toColor().hsp, 0);
    expect('#ffffff'.toColor().hsp, 255);
    expect('#409EFF'.toColor().hsp, 141);
    expect('#E6A23C'.toColor().hsp, 171);
    expect('#00BCD4'.toColor().hsp, 135);
    expect('#4CAF50'.toColor().hsp, 135);
    expect('#FFC107'.toColor().hsp, 191);
    expect('#3F51B5'.toColor().hsp, 88);
    expect('#2196F3'.toColor().hsp, 126);
    expect('#F44336'.toColor().hsp, 119);
    expect('#9C27B0'.toColor().hsp, 90);
    expect('#607D8B'.toColor().hsp, 118);
    expect('#795548'.toColor().hsp, 95);
    expect('#FFEB3B'.toColor().hsp, 221);
    expect('#009688'.toColor().hsp, 104);
    expect('#03A9F4'.toColor().hsp, 128);
    expect('#CDDC39'.toColor().hsp, 197);
    expect('#8BC34A'.toColor().hsp, 165);
    expect('#9E9E9E'.toColor().hsp, 158);
    expect('#E91E63'.toColor().hsp, 99);
    expect('#FF5722'.toColor().hsp, 132);
  });

  test('toInt', () {
    const color = Colors.green;
    expect(color.toInt, 0xFF4CAF50);
  });

  test('toHex', () {
    const color = Color.fromRGBO(25, 25, 112, 1.0);
    expect(color.toHex(), '#191970');
  });

  test('toColor', () {
    const color1 = Color(0xff409EFF);
    final color2 = '#409EFF'.toColor();
    expect(color1, color2);
  });

  // MaterialColor 都是预设值，转换的目标颜色不会匹配是符号预期的
  test('toMaterialColor', () {
    const color = Colors.green;
    final hexColor = color.toHex();
    expect(hexColor, '#4caf50');

    final newColor = hexColor.toColor().toMaterialColor();

    // expect(newColor.shade50, color.shade50);
    // expect(newColor.shade100, color.shade100);
    // expect(newColor.shade200, color.shade200);
    // expect(newColor.shade300, color.shade300);
    // expect(newColor.shade400, color.shade400);
    expect(newColor.shade500, color.shade500);
    // expect(newColor.shade600, color.shade600);
    // expect(newColor.shade700, color.shade700);
    // expect(newColor.shade800, color.shade800);
    // expect(newColor.shade900, color.shade900);
  });
}
