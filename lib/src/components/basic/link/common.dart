import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:url_launcher/link.dart';

abstract class ElLinkBase extends StatefulWidget {
  const ElLinkBase({
    super.key,
    required this.href,
    required this.builder,
    required this.title,
    required this.allowDrag,
    required this.target,
    required this.cursor,
  });

  /// 超链接地址，除了支持 http 链接外，还支持跳转 flutter 声明式路由
  final String href;

  /// 超链接子组件，如果不是 Widget 类型，则默认渲染成 [ElText]
  final Widget Function(BuildContext context, VoidCallback toLink) builder;

  /// 超链接标题描述，在 web 平台上，超链接可以允许被拖拽，该属性是用于描述拖拽的链接名字，
  /// 如果 [child] 不是 [Widget] 类型，则标题默认应用 [child] 内容
  final String title;

  /// 是否允许拖拽超链接（仅限 web 平台），此属性支持全局配置，默认true
  final bool allowDrag;

  /// 打开链接的目标位置，默认 [LinkTarget.self]
  final LinkTarget target;

  /// 自定义光标样式，默认 [SystemMouseCursors.click]
  final MouseCursor cursor;

  @override
  State<ElLinkBase> createState();
}

abstract class ElLinkBaseState<T extends ElLinkBase> extends State<T> {
  late String href;

  bool get isHttpLink => DartUtil.isHttp(href);

  void setHref(String v) {
    href = v;
  }

  void toLink() {
    if (isHttpLink) {
      launchUrl(Uri.parse(href));
    } else {
      pushRouteNameToFramework(null, widget.href);
    }
  }

  @override
  void initState() {
    super.initState();
    setHref(widget.href);
  }
}

const MethodCodec _codec = JSONMethodCodec();

Future<ByteData> pushRouteNameToFramework(Object? _, String routeName) {
  final Completer<ByteData> completer = Completer<ByteData>();
  SystemNavigator.routeInformationUpdated(uri: Uri.parse(routeName));
  ui.channelBuffers.push(
    'flutter/navigation',
    _codec.encodeMethodCall(
      MethodCall('pushRouteInformation', <dynamic, dynamic>{
        'location': routeName,
        'state': null,
      }),
    ),
    completer.complete,
  );
  return completer.future;
}
