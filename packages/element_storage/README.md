一个简单的本地存储库，它支持所有平台，其 Api 基于原生 Web 的 localStorage，在客户端上则会将数据简单地写入到文件中，
由于浏览器 localStorage 存储上限为 5M，所以你不能将它用于存储大量数据。

此库 element_plus 已经默认导出，你无需声明此依赖。

使用示例：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // El.init 内部会初始化 localStorage、sessionStorage
  await El.init();

  // 若不使用 element_ui，直接调用 ElStorage.createLocalStorage 方法即可，你还可以指定 key 来创建多个存储对象
  ElStorage.createLocalStorage();

  // 然后可以在任意位置调用 api，使用方式和 web 完全一致
  localStorage.setItem('name', 'hihi');
  localStorage.getItem('name');
  localStorage.removeItem('name');
  localStorage.clear();
}
```

Tip：此库的源码只有 100 多行，除非有明确的错误、或者第三方包的兼容性问题，否则不需要发布新的版本，
请只将它用于存储简单的、不重要的数据，就如同在 Web 上使用 localStorage 一样，
如果你需要更多功能，请考虑使用其他第三方库。