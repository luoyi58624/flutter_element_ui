一个简单的本地存储库，整包源码只有 100 多行，在 Web 端直接基于 localStorage 进行封装，
在客户端上则将数据简单地写入到文件中，由于浏览器 localStorage 存储上限为 5M，所以你不能将它用于存储大量数据。

提示：此库 element_plus 已经默认导出，你无需声明此依赖。

使用示例：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // El.init 内部会初始化 localStorage、sessionStorage
  await El.init();

  // 若不使用 element_ui，调用 ElStorage.createLocalStorage 即可
  ElStorage.createLocalStorage();
  ElStorage.createSessionStorage();

  // 然后使用方式和 web 完全一致
  localStorage.setItem('name', 'hihi');
  localStorage.getItem('name');
  localStorage.removeItem('name');
  localStorage.clear();
}
```
