part of 'base_obs.dart';

class ObsBuilder extends StatefulWidget {
  /// 响应式变量构建器，监听内部的响应式变量，当变量发生变更时，将重建小部件
  const ObsBuilder({
    super.key,
    required this.builder,
    this.watch = const [],
  });

  /// 通过函数构建小部件，它会自动收集内部的响应式变量，你也可以手动指定：[watch]
  final WidgetBuilder builder;

  /// 设置监听的响应式变量，监听的任意一个变量发生更改都会刷新此小部件，使用场景：
  /// * ObsBuilder 依赖响应式变量触发变更，但 [builder] 函数中却不使用它
  /// * ObsBuilder 内部依赖的响应式变量被各种 [Builder] 又进行了一次转发，导致自动收集不到
  final List<BaseObs> watch;

  @override
  State<ObsBuilder> createState() => _ObsBuilderState();
}

class _ObsBuilderState extends State<ObsBuilder> {
  /// 保存绑定的响应式变量集合，[Obs] 和 [ObsBuilder] 是多对多关系，
  /// [Obs] 保存的是多个 [ObsBuilder] 的刷新方法，而 [ObsBuilder] 可以引用多个 [Obs] 变量，
  /// 当组件被销毁时，需要通知所有引用此 [ObsBuilder] 的响应式变量移除它的刷新方法。
  final Set<Set<VoidCallback>> _builderObsList = {};

  /// 是否更新了 watch 依赖，此变量用于区分首次绑定的 watch
  bool _isUpdateWatch = false;

  /// 当更新了 watch 依赖，需要进行添加或移除绑定的响应式变量
  @override
  void didUpdateWidget(covariant ObsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.watch != oldWidget.watch) {
      _isUpdateWatch = true;
      if (oldWidget.watch.isEmpty) {
        _addWatch(widget.watch);
      } else if (widget.watch.isEmpty) {
        _removeWatch(oldWidget.watch);
      } else {
        final List<BaseObs> hasObsList = [];
        final List<BaseObs> addObsList = [];
        final List<BaseObs> removeObsList = [];
        for (var value in widget.watch) {
          if (oldWidget.watch.contains(value)) {
            hasObsList.add(value);
          } else {
            addObsList.add(value);
          }
        }
        for (var value in oldWidget.watch) {
          if (!hasObsList.contains(value)) {
            removeObsList.add(value);
          }
        }
        _addWatch(addObsList);
        _removeWatch(removeObsList);
      }
    }
  }

  /// 小部件被销毁时移除副作用
  @override
  void dispose() {
    for (var obs in _builderObsList) {
      obs.remove(_notify);
    }
    _builderObsList.clear();
    super.dispose();
  }

  void _addWatch(List<BaseObs> watch) {
    for (final item in watch) {
      if (!item.builderFunList.contains(_notify)) {
        item.builderFunList.add(_notify);
        _builderObsList.add(item.builderFunList);
      }
    }
  }

  void _removeWatch(List<BaseObs> watch) {
    for (final item in watch) {
      item.builderFunList.remove(_notify);
      _builderObsList.remove(item.builderFunList);
    }
  }

  /// 响应式变量发生变更就是执行此函数通知页面刷新
  void _notify() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 1.设置刷新页面函数到临时变量
    _tempBuilderNotifyFun = _notify;
    // 2.构建页面，触发响应式变量的 getter 方法，将 _notify 函数添加到监听器中
    var result = widget.builder(context);
    // 3.销毁临时变量
    _tempBuilderNotifyFun = null;
    // 4.在构建器中保存依赖的响应式变量集合
    _builderObsList.addAll(_tempBuilderObsList);
    // 5.销毁依赖的响应式变量集合
    _tempBuilderObsList.clear();
    // 6.如果设置了watch，则需要将监听的响应式变量添加到集合中
    if (widget.watch.isNotEmpty) {
      // 7.排除更新 watch 依赖，didUpdateWidget生命周期中已处理
      if (_isUpdateWatch) {
        _isUpdateWatch = false;
      }
      // 8.添加监听依赖，如果已添加会自动跳过
      else {
        _addWatch(widget.watch);
      }
    }
    return result;
  }
}
