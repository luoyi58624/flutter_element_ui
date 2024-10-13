import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ControllabilitySvg extends StatelessWidget {
  const ControllabilitySvg({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(_svgStr);
  }
}

const String _svgStr = '''
  <svg
    id="图层_1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    x="0px"
    y="0px"
    viewBox="0 0 79 79"
    style="enable-background: new 0 0 79 79"
    xml:space="preserve"
  >
    <circle fill="#eff5fd" cx="39.5" cy="39.5" r="39.5" />
    <g>
      <defs>
        <rect id="SVGID_1_" x="15.8" y="17.3" width="47.4" height="43.9" />
      </defs>
      <clipPath id="SVGID_00000103965616648291865560000002216192073450902938_">
        <use xlink:href="#SVGID_1_" style="overflow: visible" />
      </clipPath>
      <g
        style="
          clip-path: url(#SVGID_00000103965616648291865560000002216192073450902938_);
        "
      >
        <path
          fill="#afcaf1"
          d="M57.3,23.2L57.3,23.2c0.5,0,1,0.4,1,1v36c0,0.5-0.4,1-1,1l0,0c-0.5,0-1-0.4-1-1v-36
        C56.3,23.6,56.7,23.2,57.3,23.2z"
        />
        <ellipse fill="#afb6bb" cx="57.3" cy="24.7" rx="5.9" ry="5.9" />
        <ellipse fill="#e7eced" cx="57.3" cy="23.2" rx="5.9" ry="5.9" />
        <path
          fill="#afcaf1"
          d="M21.7,17.3L21.7,17.3c0.5,0,1,0.4,1,1v36c0,0.5-0.4,1-1,1h0c-0.5,0-1-0.4-1-1v-36
        C20.7,17.7,21.2,17.3,21.7,17.3z"
        />
        <ellipse fill="#afb6bb" cx="21.7" cy="55.3" rx="5.9" ry="5.9" />
        <ellipse fill="#e7eced" cx="21.7" cy="53.8" rx="5.9" ry="5.9" />
        <path
          fill="#afcaf1"
          d="M39.5,17.3L39.5,17.3c0.5,0,1,0.4,1,1v42c0,0.5-0.4,1-1,1l0,0c-0.5,0-1-0.4-1-1v-42
        C38.5,17.7,39,17.3,39.5,17.3z"
        />
        <ellipse fill="#0077ce" cx="39.5" cy="39" rx="5.9" ry="5.9" />
        <ellipse fill="#20a0ff" cx="39.5" cy="37.5" rx="5.9" ry="5.9" />
      </g>
    </g>
  </svg>
    ''';
