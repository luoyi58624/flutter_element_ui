library flutter_element_ui;

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

part 'src/components/basic/config_provider.dart';

part 'src/components/basic/button.dart';

part 'src/components/basic/button_group.dart';

part 'src/components/basic/button_item.dart';

part 'src/components/basic/container.dart';

part 'src/components/data/table/table.dart';

part 'src/components/data/table/table_header.dart';

part 'src/components/data/table/table_body.dart';

part 'src/components/data/table/table_scroll.dart';

part 'src/components/data/table/config.dart';

part 'src/components/feedback/loading.dart';

part 'src/components/affix.dart';

part 'src/components/alert.dart';

part 'src/components/anchor.dart';

part 'src/components/anchor_link.dart';

part 'src/components/autocomplete.dart';

part 'src/components/avatar.dart';

part 'src/components/backtop.dart';

part 'src/components/badge.dart';

part 'src/components/breadcrumb.dart';

part 'src/components/calendar.dart';

part 'src/components/card.dart';

part 'src/components/carousel.dart';

part 'src/components/carousel_item.dart';

part 'src/components/cascader.dart';

part 'src/components/checkbox.dart';

part 'src/components/checkbox_group.dart';

part 'src/components/collapse.dart';

part 'src/components/collapse_item.dart';

part 'src/components/color_picker.dart';

part 'src/components/date_picker.dart';

part 'src/components/descriptions.dart';

part 'src/components/descriptions_item.dart';

part 'src/components/dialog.dart';

part 'src/components/divider.dart';

part 'src/components/dropdown.dart';

part 'src/components/dropdown_menu.dart';

part 'src/components/dropdown_item.dart';

part 'src/components/empty.dart';

part 'src/components/form.dart';

part 'src/components/icon.dart';

part 'src/components/image.dart';

part 'src/components/infinite_scroll.dart';

part 'src/components/input.dart';

part 'src/components/input_number.dart';

part 'src/components/navigation/menu.dart';

part 'src/components/pagination.dart';

part 'src/components/progress.dart';

part 'src/components/radio.dart';

part 'src/components/radio_group.dart';

part 'src/components/rate.dart';

part 'src/components/result.dart';

part 'src/components/select.dart';

part 'src/components/skeleton.dart';

part 'src/components/skeleton_item.dart';

part 'src/components/slider.dart';

part 'src/components/step.dart';

part 'src/components/steps.dart';

part 'src/components/switch.dart';

part 'src/components/tab_pane.dart';

part 'src/components/tabs.dart';

part 'src/components/time_picker.dart';

part 'src/components/time_select.dart';

part 'src/components/timeline.dart';

part 'src/components/timeline_item.dart';

part 'src/components/transfer.dart';

part 'src/components/tree.dart';

part 'src/components/upload.dart';

part 'src/mixins/mouse.dart';

part 'src/mixins/tap.dart';

part 'src/mixins/theme.dart';

part 'src/styles/icons.dart';

part 'src/styles/theme.dart';

part 'src/styles/config.dart';

part 'src/utils/color.dart';

part 'src/utils/common.dart';

part 'src/utils/logger.dart';

part 'src/widgets/loading.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
