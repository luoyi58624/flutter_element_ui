import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ElImage extends StatelessWidget {
  const ElImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.radius = 6,
    this.borderRadius,
    this.circle = false,
    this.fit = BoxFit.cover,
    this.package,
    this.heroTag,
    this.failWidget,
    this.onTap,
  });

  /// 图片地址，如果是http开头，则从网络加载，其次：
  /// * 如果是web环境，则尝试从assets资产文件中加载
  /// * 如果是客户端环境，则优先检查本地是否存在此文件，若没有则再尝试从assets资产文件中加载
  final String src;

  /// 图片宽高
  final double? width;
  final double? height;

  /// 图片圆角
  final double radius;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 圆形图片
  final bool circle;

  /// 图片展示方式，默认填充容器[BoxFit.cover]
  final BoxFit fit;

  /// 指定其他包的资产文件，注意：只有当图片是从asset中加载才可以设置它
  final String? package;

  /// hero英雄动画
  final String? heroTag;

  /// 图片加载失败时展示的widget，它会覆盖默认的失败图标
  final Widget? failWidget;

  /// 自定义点击事件，它会覆盖默认的预览行为
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    late Widget result;
    if (DartUtil.isHttp(src)) {
      result = buildNetworkImage();
    } else {
      if (kIsWeb) {
        result = buildAssetImage();
      } else {
        final file = File(src);
        if (file.existsSync()) {
          result = buildFileImage();
        } else {
          result = buildAssetImage();
        }
      }
    }
    late BorderRadiusGeometry $borderRadius;
    if (circle) {
      assert(width != null);
      $borderRadius = BorderRadius.circular(width! / 2);
    } else {
      $borderRadius = borderRadius ?? BorderRadius.circular(radius);
    }
    return ClipRRect(
      borderRadius: $borderRadius,
      child: result,
    );
  }

  Widget buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: src,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => SpinKitPulse(color: Colors.grey.shade400),
      errorWidget: (context, url, error) => loadFailWidget,
    );
  }

  Widget buildAssetImage() {
    return Image.asset(
      src,
      width: width,
      height: height,
      fit: fit,
      package: package,
    );
  }

  Widget buildFileImage() {
    if (kIsWeb) {
      return circle
          ? Container(
              width: width,
              height: height,
              color: Colors.grey,
            )
          : SizedBox(
              width: width,
              height: height,
              child: const Placeholder(),
            );
    } else {
      return Image.file(
        File(src),
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  Widget get loadFailWidget {
    return SizedBox(
      width: width,
      height: height,
      child: failWidget == null
          ? const Icon(
              Icons.error_outline_outlined,
            )
          : failWidget!,
    );
  }
}
