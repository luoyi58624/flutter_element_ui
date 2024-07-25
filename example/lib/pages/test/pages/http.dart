import 'package:example/global.dart';
import 'package:flutter/material.dart';

BaseHttp http = BaseHttp();

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            Text('请求的数据：$text'),
            ElevatedButton(
              onPressed: () async {
                ElLoading.show('加载中');
                var resData = await http
                    .get('https://jsonplaceholder.typicode.com/todos/1');
                ElLoading.close();
                setState(() {
                  text = resData.toString();
                });
              },
              child: const Text('发送get请求'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                ElLoading.show('加载中');
                var resData = await myHttp.test('/todos/1');
                ElLoading.close();
                setState(() {
                  text = resData.toString();
                });
              },
              child: const Text('发送get请求 - 自定义http'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                ElLoading.show('加载中');
                var resData = await myHttp.get(
                  '/todos/1',
                  getRequestExtra: GetRequestExtra(),
                );
                setState(() {
                  text = resData.toString();
                });
              },
              child: const Text('发送get请求 - 自定义http'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                ElLoading.show('加载中');
                var resData = await myHttp.get(
                  '/todos/1',
                  getRequestExtra: GetRequestExtra(
                      errorMessageFun: (errorMsg) =>
                          el.showToast(el.context, errorMsg, type: 'error')),
                );
                setState(() {
                  text = resData.toString();
                });
              },
              child: const Text('发送get请求 - 自定义http - 自定义错误消息打印'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                ElLoading.show('加载中');
                var resData = await myHttp.get(
                  '/todos/1',
                  getRequestExtra: GetRequestExtra(
                    enableCache: true,
                    useCache: true,
                  ),
                );
                setState(() {
                  text = resData.toString();
                });
              },
              child: const Text('发送get请求 - 自定义http - 缓存请求数据'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  text = '';
                });
                // i(http.instance == myHttp.instance);
                // i(http.instance.options.baseUrl);
                // i(myHttp.instance.options.baseUrl);
              },
              child: const Text('清空数据'),
            ),
          ]),
        ),
      ),
    );
  }
}
