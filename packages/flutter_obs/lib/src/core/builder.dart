part of 'obs.dart';

class ObsBuilder extends StatefulWidget {
  /// 响应式变量构建器，监听内部的响应式变量，当变量发生变更时，将重建小部件
  const ObsBuilder({
    super.key,
    required this.builder,
    this.binding = const [],
  });

  /// 通过函数构建小部件，它会自动收集内部的响应式变量
  final WidgetBuilder builder;

  /// 手动绑定监听的响应式变量，监听的任意一个变量发生更改都会刷新此小部件，应用场景：
  /// * 需要依赖响应式变量但 [Widget] 不需要使用它；
  /// * 响应式变量在多层嵌套 builder 函数内部导致 [ObsBuilder] 的 [builder] 没有收集到；
  final List<Obs> binding;

  @override
  State<ObsBuilder> createState() => _ObsBuilderState();
}

class _ObsBuilderState extends State<ObsBuilder> {
  /// 保存绑定的响应式变量集合，[Obs] 和 [ObsBuilder] 是多对多关系，
  /// [Obs] 保存的是多个 [ObsBuilder] 的刷新方法，而 [ObsBuilder] 可以引用多个 [Obs] 变量，
  /// 当组件被销毁时，需要通知所有引用此 [ObsBuilder] 的 [Obs] 变量移除它的刷新方法。
  final Set<Set<VoidCallback>> _builderObsList = {};

  /// 是否更新了 watch 依赖，此变量用于区分首次绑定的 watch
  bool _isUpdateWatch = false;

  /// 当更新了 watch 依赖，需要进行添加或移除绑定的响应式变量
  @override
  void didUpdateWidget(covariant ObsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.binding != oldWidget.binding) {
      _isUpdateWatch = true;
      if (oldWidget.binding.isEmpty) {
        _addWatch(widget.binding);
      } else if (widget.binding.isEmpty) {
        _removeWatch(oldWidget.binding);
      } else {
        final List<Obs> hasObsList = [];
        final List<Obs> addObsList = [];
        final List<Obs> removeObsList = [];
        for (var value in widget.binding) {
          if (oldWidget.binding.contains(value)) {
            hasObsList.add(value);
          } else {
            addObsList.add(value);
          }
        }
        for (var value in oldWidget.binding) {
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

  void _addWatch(List<Obs> watch) {
    for (final item in watch) {
      if (!item.builderFunList.contains(_notify)) {
        item.builderFunList.add(_notify);
        _builderObsList.add(item.builderFunList);
      }
    }
  }

  void _removeWatch(List<Obs> watch) {
    for (final item in watch) {
      item.builderFunList.remove(_notify);
      _builderObsList.remove(item.builderFunList);
    }
  }

  /// 响应式变量发生变更就是执行此函数通知页面刷新
  void _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 1.设置刷新页面函数到临时变量
    _tempBuilderNotifyFun = _notify;
    // 2.构建页面，如果触发响应式变量的 getter 方法，将 _notify 函数添加到监听器中
    var result = widget.builder(context);
    // 3.销毁临时变量
    _tempBuilderNotifyFun = null;
    // 4.builder 中可以有多个响应式变量，它们全都记录在临时集合中，这里将它们保存起来
    _builderObsList.addAll(_tempBuilderObsList);
    // 5.销毁依赖的响应式变量集合
    _tempBuilderObsList.clear();
    // 6.如果设置了watch，则需要将监听的响应式变量添加到集合中
    if (widget.binding.isNotEmpty) {
      // 7.排除更新 watch 依赖，didUpdateWidget生命周期中已处理
      if (_isUpdateWatch) {
        _isUpdateWatch = false;
      }
      // 8.添加监听依赖，如果已添加会自动跳过
      else {
        _addWatch(widget.binding);
      }
    }
    return result;
  }
}
