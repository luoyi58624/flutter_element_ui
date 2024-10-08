import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EfficiencySvg extends StatelessWidget {
  const EfficiencySvg({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(_svgStr);
  }
}

const String st0 = '#eff5fd';
const String st1 = '#afb6bb';
const String st2 = '#e7eced';
const String st3 = '#ffffff';
const String st4 = '#0077ce';
const String st5 = '#20a0ff';

const String _svgStr = '''
  <svg
    id="图层_1"
    version="1.1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    x="0px"
    y="0px"
    viewBox="0 0 79 79"
    style="enable-background: new 0 0 79 79"
    xml:space="preserve"
  >
    <circle fill="$st0" cx="39.5" cy="39.5" r="39.5" />
    <path
      fill="$st1"
      d="M37,16.8c-1.6,0-3,1.3-3,3V22c-3,0.9-5.7,2.5-7.9,4.5l-2-1.1c-1.4-0.8-3.2-0.3-4,1.1l-2.5,4.3
      c-0.8,1.4-0.3,3.2,1.1,4l2,1.1c-0.4,1.5-0.5,3-0.5,4.5c0,1.6,0.2,3.1,0.5,4.5l-2,1.1c-1.4,0.8-1.9,2.6-1.1,4l2.5,4.3
      c0.8,1.4,2.6,1.9,4,1.1l2-1.1c2.2,2.1,4.9,3.7,7.9,4.5v2.3c0,1.6,1.3,3,3,3h4.9c1.6,0,3-1.3,3-3V59c3-0.9,5.7-2.5,7.9-4.5l2,1.1
      c1.4,0.8,3.2,0.3,4-1.1l2.5-4.3c0.8-1.4,0.3-3.2-1.1-4l-2-1.1c0.4-1.5,0.5-3,0.5-4.5c0-1.6-0.2-3.1-0.5-4.5l2-1.1
      c1.4-0.8,1.9-2.6,1.1-4l-2.5-4.3c-0.8-1.4-2.6-1.9-4-1.1l-2,1.1c-2.2-2.1-4.9-3.7-7.9-4.5v-2.3c0-1.6-1.3-3-3-3H37z"
    />
    <path
      fill="$st2"
      d="M37,14.8c-1.6,0-3,1.3-3,3V20c-3,0.9-5.7,2.5-7.9,4.5l-2-1.1c-1.4-0.8-3.2-0.3-4,1.1l-2.5,4.3
      c-0.8,1.4-0.3,3.2,1.1,4l2,1.1c-0.4,1.5-0.5,3-0.5,4.5s0.2,3.1,0.5,4.5l-2,1.1c-1.4,0.8-1.9,2.6-1.1,4l2.5,4.3
      c0.8,1.4,2.6,1.9,4,1.1l2-1.1c2.2,2.1,4.9,3.7,7.9,4.5v2.3c0,1.6,1.3,3,3,3h4.9c1.6,0,3-1.3,3-3V57c3-0.9,5.7-2.5,7.9-4.5l2,1.1
      c1.4,0.8,3.2,0.3,4-1.1l2.5-4.3c0.8-1.4,0.3-3.2-1.1-4l-2-1.1c0.4-1.5,0.5-3,0.5-4.5s-0.2-3.1-0.5-4.5l2-1.1c1.4-0.8,1.9-2.6,1.1-4
      l-2.5-4.3c-0.8-1.4-2.6-1.9-4-1.1l-2,1.1c-2.2-2.1-4.9-3.7-7.9-4.5v-2.3c0-1.6-1.3-3-3-3H37z"
    />
    <ellipse
      transform="matrix(1 -2.392332e-03 2.392332e-03 1 -9.202202e-02 9.445851e-02)"
      fill="$st3"
      cx="39.4"
      cy="38.5"
      rx="15.3"
      ry="15.3"
    />
    <path
      fill="$st4"
      d="M38.5,30.6c0-0.5,0.4-1,1-1c0.5,0,1,0.4,1,1v10.9h-2V30.6z"
    />
    <path
      fill="$st5"
      d="M47.3,39.5c0.5,0,1,0.4,1,1c0,0.5-0.4,1-1,1h-8.9v-2H47.3z"
    />
  </svg>
    ''';
