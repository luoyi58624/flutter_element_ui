// import 'package:flutter/material.dart';
// import 'package:flutter_base/flutter_base.dart';
//
// /// 弹窗组件
// class DialogWidget extends StatefulWidget {
//   const DialogWidget({
//     super.key,
//     this.title,
//     this.content,
//     this.confirmText = '确定',
//     this.cancelText = '取消',
//     this.titleWidget,
//     this.contentWidget,
//     this.radius,
//     this.showCancel = true,
//     this.roundButton = false,
//     this.clickOutsideClose = true,
//     this.confirmColor,
//     this.cancelColor,
//     this.onConfirm,
//     this.onCancel,
//   }) : assert(
//             !(title == null &&
//                 content == null &&
//                 titleWidget == null &&
//                 contentWidget == null),
//             'title、content、titleWidget、contentWidget必须指定一个参数');
//
//   final String? title;
//   final String? content;
//   final String confirmText;
//   final String cancelText;
//   final Widget? titleWidget;
//   final Widget? contentWidget;
//   final double? radius;
//   final bool showCancel;
//   final bool roundButton;
//   final bool clickOutsideClose;
//   final Color? confirmColor;
//   final Color? cancelColor;
//   final Future<bool> Function()? onConfirm;
//   final Future<bool> Function()? onCancel;
//
//   /// 显示通用的文字提示框
//   /// 1. 当屏幕尺寸小于600时，将显示移动端风格弹窗，弹窗宽度固定280
//   /// 2. 当屏幕尺寸大于600时，将显示桌面端风格弹窗，弹窗宽度固定480
//   ///
//   /// * title 弹窗标题，为null则不渲染
//   /// * content 弹窗内容，为null则不渲染
//   /// * cancelText 取消按钮文字
//   /// * confirmText 确认按钮文字
//   /// * titleWidget 自定义弹窗标题组件
//   /// * contentWidget 自定义弹窗内容组件
//   /// * showCancel 显示取消按钮，默认true
//   /// * roundButton 是否使用圆角按钮(仅限移动端)，默认false，若开启，按钮布局将从上往下
//   /// * clickOutsideClose 点击外部关闭弹窗，默认true
//   /// * cardColor 自定义遮罩层颜色
//   /// * radius 弹窗圆角值
//   /// * onCancel 取消事件，如果返回true，将自动关闭弹窗
//   /// * onConfirm 确定事件，如果返回true，将自动关闭弹窗
//   ///
//   /// @return 如果点击确定，将返回true，否则返回false
//   static Future<bool?> show({
//     String? title,
//     String? content,
//     String confirmText = '确定',
//     String cancelText = '取消',
//     Widget? titleWidget,
//     Widget? contentWidget,
//     double? radius,
//     bool showCancel = true,
//     bool roundButton = false,
//     bool clickOutsideClose = true,
//     Color? cardColor,
//     Color? confirmColor,
//     Color? cancelColor,
//     Future<bool> Function()? onConfirm,
//     Future<bool> Function()? onCancel,
//   }) async {
//     return await showDialog(
//       context: el.context,
//       barrierColor: cardColor,
//       barrierDismissible: clickOutsideClose,
//       builder: (context) => DialogWidget(
//         title: title,
//         content: content,
//         cancelText: cancelText,
//         confirmText: confirmText,
//         titleWidget: titleWidget,
//         contentWidget: contentWidget,
//         radius: radius,
//         showCancel: showCancel,
//         roundButton: roundButton,
//         clickOutsideClose: clickOutsideClose,
//         confirmColor: confirmColor,
//         cancelColor: cancelColor,
//         onCancel: onCancel,
//         onConfirm: onConfirm,
//       ),
//     );
//   }
//
//   /// 显示 material2 风格确认框
//   static Future<bool?> m2() async {}
//
//   /// 显示 material3 风格确认框
//   static Future<bool?> m3() async {}
//
//   @override
//   State<DialogWidget> createState() => _DialogWidgetState();
// }
//
// class _DialogWidgetState extends State<DialogWidget> {
//   bool cancelLoading = false;
//   bool confirmLoading = false;
//
//   /// 只要有一个异步任务触发，则禁用所有按钮
//   bool get disableButton => cancelLoading || confirmLoading;
//
//   Widget? get titleWidget =>
//       widget.titleWidget ??
//       (widget.title != null
//           ? Text(
//               widget.title!,
//               style: TextStyle(
//                 fontWeight: ElFont.bold,
//                 fontSize: 16,
//               ),
//             )
//           : null);
//
//   Widget? get contentWidget =>
//       widget.contentWidget ??
//       (widget.content != null ? Text(widget.content!) : null);
//
//   bool get hasTitle => widget.title != null || widget.titleWidget != null;
//
//   bool get hasContent => widget.content != null || widget.contentWidget != null;
//
//   /// 弹窗的边框圆角
//   BorderRadius get radius => context.sm
//       ? widget.roundButton
//           ? BorderRadius.circular(16)
//           : widget.radius != null
//               ? BorderRadius.circular(widget.radius!)
//               : context.elTheme.cardTheme.radius
//       : widget.radius != null
//           ? BorderRadius.circular(widget.radius!)
//           : context.elTheme.cardTheme.radius;
//
//   /// 弹窗的垂直内边距
//   double get horizontalPadding => context.sm ? 16 : 20;
//
//   Color get confirmColor => widget.confirmColor ?? context.elTheme.primary;
//
//   Future<void> onCancel() async {
//     if (widget.onCancel != null) {
//       var timer = setTimeout(() {
//         if (mounted) {
//           setState(() {
//             cancelLoading = true;
//           });
//         }
//       }, 16);
//       bool? result;
//       try {
//         result = await widget.onCancel!();
//       } catch (error) {
//         e(error);
//       }
//       if (mounted) {
//         timer.cancel();
//         if (result == true) {
//           Navigator.of(context).pop(false);
//         } else {
//           setState(() {
//             cancelLoading = false;
//           });
//         }
//       }
//     } else {
//       Navigator.of(context).pop(false);
//     }
//   }
//
//   Future<void> onConfirm() async {
//     if (widget.onConfirm != null) {
//       var timer = setTimeout(() {
//         if (mounted) {
//           setState(() {
//             cancelLoading = true;
//           });
//         }
//       }, 16);
//       bool? result;
//       try {
//         result = await widget.onConfirm!();
//       } catch (error) {
//         e(error);
//       }
//       if (mounted) {
//         timer.cancel();
//         if (result == true) {
//           Navigator.of(context).pop(false);
//         } else {
//           setState(() {
//             confirmLoading = false;
//           });
//         }
//       }
//     } else {
//       Navigator.of(context).pop(true);
//     }
//   }
//
//   Widget buildButtonContent({
//     required bool loading,
//     required Widget child,
//   }) {
//     // return loading ? const LoadingWidget() : child;
//     return child;
//   }
//
//   Widget buildMobileWidget() {
//     return widget.roundButton
//         ? buildMobileRoundButtonModal()
//         : SizedBox(
//             width: 280,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (hasTitle)
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: 20,
//                         left: 16,
//                         right: 16,
//                         bottom: hasContent ? 8 : 20),
//                     child: titleWidget,
//                   ),
//                 if (widget.content != null || widget.contentWidget != null)
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: hasTitle ? 0 : 20,
//                         left: 16,
//                         right: 16,
//                         bottom: 20),
//                     child: contentWidget,
//                   ),
//                 const ElDivider(),
//                 SizedBox(
//                   height: 44,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: ElTapBuilder(
//                           onTap: onCancel,
//                           disabled: disableButton,
//                           builder: (context) {
//                             return Container(
//                               color: context.elTheme.cardTheme.color
//                                   .on(ElTapBuilder.of(context)),
//                               alignment: Alignment.center,
//                               child: buildButtonContent(
//                                 loading: cancelLoading,
//                                 child: Text(widget.cancelText,
//                                     style: TextStyle(
//                                       color: widget.cancelColor ??
//                                           context.elTheme.textTheme.textStyle
//                                               .color!
//                                               .deepen(50),
//                                     )),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const ElDivider(vertical: true),
//                       Expanded(
//                         child: ElTapBuilder(
//                           onTap: onConfirm,
//                           disabled: disableButton,
//                           builder: (context) {
//                             return Container(
//                               color: context.elTheme.cardTheme.color
//                                   .on(ElTapBuilder.of(context)),
//                               alignment: Alignment.center,
//                               child: buildButtonContent(
//                                 loading: confirmLoading,
//                                 child: Text(widget.confirmText,
//                                     style: TextStyle(
//                                         color: widget.confirmColor ??
//                                             context.elTheme.primary)),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
//
//   Widget buildMobileRoundButtonModal() {
//     return SizedBox(
//       width: 280,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (hasTitle)
//             Padding(
//               padding: EdgeInsets.only(
//                   top: 28, left: 16, right: 16, bottom: hasContent ? 8 : 20),
//               child: titleWidget,
//             ),
//           if (widget.content != null || widget.contentWidget != null)
//             Padding(
//               padding: EdgeInsets.only(
//                   top: hasTitle ? 0 : 36, left: 16, right: 16, bottom: 32),
//               child: contentWidget,
//             ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 28),
//                 child: ElTapBuilder(
//                   onTap: onConfirm,
//                   disabled: disableButton,
//                   builder: (context) {
//                     return Container(
//                       height: 40,
//                       alignment: Alignment.center,
//                       decoration: ShapeDecoration(
//                         shape: const StadiumBorder(),
//                         gradient: LinearGradient(colors: [
//                           confirmColor.deepen(20).on(ElTapBuilder.of(context)),
//                           confirmColor.on(ElTapBuilder.of(context)),
//                         ]),
//                       ),
//                       child: buildButtonContent(
//                         loading: confirmLoading,
//                         child: Text(
//                           widget.confirmText,
//                           style: TextStyle(
//                               color: confirmColor.elTextColor(context)),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               widget.showCancel ? const Gap(10) : const Gap(20),
//               if (widget.showCancel)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 28),
//                   child: ElTapBuilder(
//                     onTap: onCancel,
//                     disabled: disableButton,
//                     builder: (context) {
//                       return Container(
//                         height: 40,
//                         alignment: Alignment.center,
//                         decoration: ShapeDecoration(
//                           shape: const StadiumBorder(),
//                           gradient: LinearGradient(colors: [
//                             (widget.cancelColor ?? context.elTheme.info)
//                                 .deepen(30)
//                                 .on(ElTapBuilder.of(context)),
//                             (widget.cancelColor ?? context.elTheme.info)
//                                 .on(ElTapBuilder.of(context)),
//                           ]),
//                         ),
//                         child: buildButtonContent(
//                           loading: cancelLoading,
//                           child: Text(
//                             widget.cancelText,
//                             style: TextStyle(
//                                 color:
//                                     (widget.cancelColor ?? context.elTheme.info)
//                                         .elTextColor(context)),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               if (widget.showCancel) const Gap(20),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDesktopWidget() {
//     return SizedBox(
//       width: 480,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (hasTitle)
//             Padding(
//               padding: EdgeInsets.only(
//                 top: 24,
//                 left: horizontalPadding,
//                 right: horizontalPadding,
//                 bottom: hasContent ? 12 : 24,
//               ),
//               child: titleWidget,
//             ),
//           if (widget.content != null || widget.contentWidget != null)
//             Padding(
//               padding: EdgeInsets.only(
//                 top: hasTitle ? 0 : 28,
//                 left: horizontalPadding,
//                 right: horizontalPadding,
//                 bottom: 24,
//               ),
//               child: contentWidget,
//             ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               ElHoverBuilder(
//                 disabled: disableButton,
//                 builder: (context) => ElTapBuilder(
//                   onTap: onCancel,
//                   disabled: disableButton,
//                   builder: (context) => Container(
//                     height: 40,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: (widget.cancelColor ??
//                               context.elTheme.cardTheme.color)
//                           .on(ElHoverBuilder.of(context))
//                           .on(ElTapBuilder.of(context)),
//                       borderRadius: context.elTheme.buttonTheme.borderRadius,
//                     ),
//                     child: buildButtonContent(
//                       loading: cancelLoading,
//                       child: Text(
//                         widget.cancelText,
//                         style: TextStyle(
//                             color: (widget.cancelColor ??
//                                         context.elTheme.cardTheme.color)
//                                     .isDark
//                                 ? ElApp.of(context)
//                                     .darkTheme
//                                     .textTheme
//                                     .textStyle
//                                     .color!
//                                     .darken(20)
//                                 : context.elTheme.textTheme.textStyle.color!
//                                     .brighten(20)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Gap(8),
//               ElHoverBuilder(
//                 disabled: disableButton,
//                 builder: (context) => ElTapBuilder(
//                   onTap: onConfirm,
//                   disabled: disableButton,
//                   builder: (context) => Container(
//                     height: 40,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: confirmColor
//                           .on(ElHoverBuilder.of(context))
//                           .on(ElTapBuilder.of(context)),
//                       borderRadius: context.elTheme.buttonTheme.borderRadius,
//                     ),
//                     child: buildButtonContent(
//                       loading: confirmLoading,
//                       child: Text(
//                         widget.cancelText,
//                         style:
//                             TextStyle(color: confirmColor.elTextColor(context)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Gap(20),
//             ],
//           ),
//           const Gap(16),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: disableButton ? false : widget.clickOutsideClose,
//       child: Center(
//         child: Material(
//           type: MaterialType.canvas,
//           elevation: context.elTheme.modalTheme.elevation,
//           color: context.elTheme.cardTheme.color,
//           surfaceTintColor: Colors.transparent,
//           borderRadius: radius,
//           clipBehavior: Clip.hardEdge,
//           child: context.sm ? buildMobileWidget() : buildDesktopWidget(),
//         ),
//       ),
//     );
//   }
// }
