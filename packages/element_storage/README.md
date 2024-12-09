一个简单的本地存储库，它支持所有平台，其 Api 基于原生 Web 的 localStorage，在客户端上则会将数据简单地写入到文件中，
由于浏览器 localStorage 存储上限为 5M，所以你不能将它用于存储大量数据。

此库 element_plus 已经默认导出，你无需声明此依赖。

使用示例：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // El.init 内部会初始化 localStorage、sessionStorage
  await El.init();

  // 然后可以在任意位置调用 api，使用方式和 web 完全一致
  localStorage.setItem('name', 'hihi');
  localStorage.getItem('name');
  localStorage.removeItem('name');
  localStorage.clear();
}
```
