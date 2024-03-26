import 'package:example/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin/flutter_plugin.dart';

class ImageListPage extends StatefulWidget {
  const ImageListPage({super.key});

  @override
  State<ImageListPage> createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  @override
  Widget build(BuildContext context) {
    int start = DateTime.now().millisecondsSinceEpoch;
    var imageList = List.generate(1000000, (index) => faker.image.image(random: true)).toList();
    int end = DateTime.now().millisecondsSinceEpoch;
    LoggerUtil('加载100万张图片耗时：${end - start} 毫秒');
    return SuperListView.builder(
      itemCount: 200000,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ...List.generate(
              5,
              (rowIndex) => Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: ImageWidget(
                      url: imageList[index * 5 + rowIndex],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
