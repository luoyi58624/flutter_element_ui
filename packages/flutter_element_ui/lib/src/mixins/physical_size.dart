import 'package:flutter/widgets.dart';

mixin ElPhysicalSizeMixin<T extends StatefulWidget> on State<T> {
  /// 最大物理尺寸
  double? _maxSize;

  double get maxSize {
    assert(_maxSize != null, '_maxSize 还未初始化');
    return _maxSize!;
  }

  set maxSize(double size) {
    _maxSize = size;
  }

  Widget buildPhysicalLayout({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return child;
      },
    );
  }
}
