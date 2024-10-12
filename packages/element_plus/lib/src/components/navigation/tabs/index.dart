import 'package:element_plus/src/global.dart';

import '../../../models/tab.dart';
import '../tab/index.dart';

part 'state.dart';

part 'style.dart';

part '../../../generates/components/navigation/tabs/index.g.dart';

class ElTabs extends ElModelValue<int> {
  const ElTabs(
    super.modelValue, {
    super.key,
    super.onChanged,
    required this.children,
  });

  /// [ElTab] 子标签集合
  final List<ElTabModel> children;

  @override
  State<ElTabs> createState() => _ElTabsState();
}
