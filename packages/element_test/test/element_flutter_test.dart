import 'dart:ui';

import 'package:element_flutter/element_flutter.dart';
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

  test('toColor', () {
    const color1 = Color(0xff409EFF);
    final color2 = '#409EFF'.toColor();
    expect(color1, color2);
  });

  test('toHex', () {
    const color = Color.fromRGBO(25, 25, 112, 1.0);
    i(color.r, color.red);
    i(color.red.toRadixString(16));
    i((25 & 0xff) / 255);
    i((color.r * 255).toInt().toRadixString(16));
    expect(color.toHex(), '#191970');
  });
}
