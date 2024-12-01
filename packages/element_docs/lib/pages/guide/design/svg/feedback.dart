import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackSvg extends StatelessWidget {
  const FeedbackSvg({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(_svgStr);
  }
}

const String st0 = '#eff5fd';
const String st1 = '#0077ce';
const String st2 = '#20a0ff';
const String st3 = '#ffffff';

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
      d="M19.8,26.2c0-3.3,2.7-5.9,5.9-5.9h27.7c3.3,0,5.9,2.7,5.9,5.9v23.7c0,3.3-2.7,5.9-5.9,5.9H25.9l-6.2,6.4V26.2z"
    />
    <path
      fill="$st2"
      d="M19.8,24.2c0-3.3,2.7-5.9,5.9-5.9h27.7c3.3,0,5.9,2.7,5.9,5.9v23.7c0,3.3-2.7,5.9-5.9,5.9H25.9l-6.2,6.4V24.2z"
    />
    <path
      fill="$st3"
      d="M37.5,35.5c0-1.1,0.9-2,2-2s2,0.9,2,2v7.9c0,1.1-0.9,2-2,2s-2-0.9-2-2V35.5z"
    />
    <path
      fill="$st3"
      d="M37.5,29.1c0-1.1,0.9-2,2-2s2,0.9,2,2c0,1.1-0.9,2-2,2S37.5,30.2,37.5,29.1z"
    />
  </svg>
    ''';
