import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatelessWidget {
  const SvgWidget(
    this.url, {
    super.key,
    this.size,
    this.color,
    this.package,
  });

  /// svg地址路径，它根据地址前缀自动加载不同环境的svg：
  /// * http、https - 加载网络上的svg
  /// * asset、assets、/asset、/assets - 加载项目资产中的svg
  final String? url;

  final double? size;

  final Color? color;

  /// 指定其他库的asset资产包
  final String? package;

  @override
  Widget build(BuildContext context) {
    assert(url != null);
    if (url!.startsWith('http')) {
      return SvgPicture.network(
        url!,
        width: size,
        height: size,
        color: color,
      );
    } else if (url!.startsWith('asset') || url!.startsWith('/asset')) {
      return SvgPicture.asset(
        url!,
        width: size,
        height: size,
        color: color,
        package: package,
      );
    }
    return const SizedBox();
  }
}
