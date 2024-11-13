// part of 'index.dart';
//
// class ElHover extends StatefulWidget {
//   /// Hover 悬停事件构建器
//   const ElHover({
//     super.key,
//     this.child,
//     this.builder,
//     this.cursor,
//     this.hitTestBehavior,
//     this.disabled = false,
//     this.onEnter,
//     this.onExit,
//     this.onHover,
//   }) : assert(
//             (child != null && builder == null) ||
//                 (child == null && builder != null),
//             'ElHover child、builder 参数只能二选一');
//
//   /// 子组件
//   final Widget? child;
//
//   /// 功能和 [child] 一样，只不过它会转发 context 对象，允许你通过 [of] 方法访问事件状态
//   final WidgetBuilder? builder;
//
//   /// 鼠标悬停光标样式
//   final MouseCursor? cursor;
//
//   /// 命中测试
//   final HitTestBehavior? hitTestBehavior;
//
//   /// 是否开启禁用样式，默认false
//   final bool disabled;
//
//   /// 鼠标进入事件
//   final PointerEnterEventListener? onEnter;
//
//   /// 鼠标离开事件
//   final PointerExitEventListener? onExit;
//
//   /// hover事件
//   final PointerHoverEventListener? onHover;
//
//   /// 根据上下文获取最近的悬停状态
//   static bool of(BuildContext context) =>
//       _HoverInheritedWidget.maybeOf(context)?.isHover ?? false;
//
//   @override
//   State<ElHover> createState() => _ElHoverState();
// }
//
// class _ElHoverState extends State<ElHover> {
//   bool isHover = false;
//
//   /// 是否存在依赖，如果有那么会自动触发 setState
//   bool hasDepend = false;
//
//   void setDependFlag(bool value) {
//     hasDepend = value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget result;
//     if (widget.child != null) {
//       result = widget.child!;
//     } else {
//       result = Builder(builder: (context) {
//         return widget.builder!(context);
//       });
//     }
//
//     // 仅限桌面端，移动端不存在hover
//     if (PlatformUtil.isDesktop) {
//       final cursor = widget.cursor ?? MouseCursor.defer;
//       if (widget.disabled) isHover = false;
//       return _HoverInheritedWidget(
//         isHover: isHover,
//         setDependFlag: setDependFlag,
//         child: MouseRegion(
//           cursor: cursor,
//           hitTestBehavior: widget.hitTestBehavior,
//           onHover: widget.disabled ? null : widget.onHover,
//           onEnter: widget.disabled ? null : _onEnter,
//           onExit: widget.disabled ? null : _onExit,
//           child: result,
//         ),
//       );
//     }
//     return result;
//   }
//
//   void _onEnter(PointerEnterEvent event) {
//     if (widget.onEnter != null) widget.onEnter!(event);
//     if (hasDepend && !isHover) {
//       setState(() {
//         isHover = true;
//       });
//     }
//   }
//
//   void _onExit(PointerExitEvent event) {
//     if (widget.onExit != null) widget.onExit!(event);
//     if (hasDepend && isHover) {
//       setState(() {
//         isHover = false;
//       });
//     }
//   }
// }
//
// class _HoverInheritedWidget extends InheritedWidget {
//   const _HoverInheritedWidget({
//     required super.child,
//     required this.isHover,
//     required this.setDependFlag,
//   });
//
//   final bool isHover;
//   final ElBoolVoidCallback setDependFlag;
//
//   static _HoverInheritedWidget? maybeOf(BuildContext context) {
//     final result =
//         context.dependOnInheritedWidgetOfExactType<_HoverInheritedWidget>();
//     if (result != null) {
//       result.setDependFlag(true);
//     }
//     return result;
//   }
//
//   @override
//   bool updateShouldNotify(_HoverInheritedWidget oldWidget) {
//     return true;
//   }
// }
