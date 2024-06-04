import 'package:flutter/widgets.dart';

class ElImage extends StatelessWidget {
  const ElImage({super.key, required this.src});

  /// 图片地址，如果是http开头，则从网络加载，其次：
  /// * 如果是web环境，则尝试从assets资产文件中加载
  /// * 如果是客户端环境，则优先检查本地是否存在此文件，若没有则再尝试从assets资产文件中加载
  final String src;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
