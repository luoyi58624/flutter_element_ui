part of 'router.dart';

class RouterUtil {
  RouterUtil._();

  /// 构建自适应路由，如果是桌面端，将不会应用任何过渡动画，移动端则使用 IOS 路由动画
  static GoRoute buildRoute({
    required String path,
    required GoRouterWidgetBuilder builder,
  }) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => context.sm
          ? PlatformUtil.isIOS
              ? CupertinoPage(child: builder(context, state))
              : MaterialPage(child: builder(context, state))
          : NoTransitionPage(
              child: builder(context, state),
            ),
    );
  }
}
