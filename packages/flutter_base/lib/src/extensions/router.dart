import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension FlutterRouterExtension on BuildContext {
  /// 跳转到新页面
  Future<T?> push<T>(
    Widget page, {
    RouteSettings? settings,
  }) async {
    var result = await Navigator.of(this).push<T>(CupertinoPageRoute(
      builder: (context) => page,
      settings: settings,
    ));
    return result;
  }

  /// 返回上一页
  void pop([dynamic data]) async {
    Navigator.of(this).pop(data);
  }

  /// 重定向页面，先跳转新页面，再删除之前的页面
  Future<T?> pushReplacement<T>(
    Widget page, {
    RouteSettings? settings,
  }) async {
    return await Navigator.of(this).pushReplacement(CupertinoPageRoute(
      builder: (context) => page,
      settings: settings,
    ));
  }

  /// 跳转新页面，同时删除之前所有的路由，直到指定的routePath。
  ///
  /// 例如：如果你想跳转一个新页面，同时希望这个新页面的上一级是首页，那么就设置routePath = '/'，
  /// 它会先跳转到新的页面，再删除从首页开始后的全部路由。
  void pushAndRemoveUntil(
    Widget page,
    String routePath, {
    RouteSettings? settings,
  }) async {
    Navigator.of(this).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
      ModalRoute.withName(routePath),
    );
  }

  /// 退出到指定位置
  void popUntil(String routePath) async {
    Navigator.of(this).popUntil(
      ModalRoute.withName(routePath),
    );
  }

  /// 进入新的页面并删除之前所有路由
  void pushAndRemoveAllUntil(
    Widget page, {
    RouteSettings? settings,
  }) async {
    Navigator.of(this).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
      (route) => false,
    );
  }
}

extension FlutterGoRouterExtension on BuildContext {
  /// 声明式跳转，通过此方法进行路由跳转会更改浏览器上面的url
  void go(String path) {
    GoRouter.of(this).go(path);
  }

  /// 命令式url跳转新页面，与[go]方法的区别在于，它不会更改浏览器上的url
  void pushUrl(String path) {
    GoRouter.of(this).push(path);
  }

  /// [GoRoute]页面构建，如果你需要实现[hideTabbar]，请一律使用此方法构建路由
  Page<dynamic> pageBuilder<T>(GoRouterState state, Widget page) => _Page<void>(
        key: state.pageKey,
        name: state.name ?? state.path,
        arguments: <String, String>{
          ...state.pathParameters,
          ...state.uri.queryParameters
        },
        restorationId: state.pageKey.value,
        child: page,
      );
}

/// 定义路由[CupertinoPage]
class _Page<T> extends CupertinoPage<T> {
  const _Page({
    required super.child,
    super.name,
    super.arguments,
    super.key,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return _GoRoutePage<T>(
      page: this,
      allowSnapshotting: allowSnapshotting,
    );
  }
}

/// 适用于[GoRouter]定义的声明式页面路由过渡动画，
class _GoRoutePage<T> extends PageRoute<T> with CupertinoRouteTransitionMixin {
  _GoRoutePage({
    required CupertinoPage<T> page,
    super.allowSnapshotting = true,
  }) : super(settings: page) {
    assert(opaque);
  }

  CupertinoPage<T> get _page => settings as CupertinoPage<T>;

  @override
  String? get title => _page.title;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Widget buildContent(BuildContext context) => _page.child;
}
