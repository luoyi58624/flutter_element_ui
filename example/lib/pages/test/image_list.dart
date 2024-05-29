import 'package:example/global.dart';
import 'package:example/utils/logger.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ImageListPage extends StatefulWidget {
  const ImageListPage({super.key});

  @override
  State<ImageListPage> createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int start = DateTime.now().millisecondsSinceEpoch;
    var imageList = List.generate(1000000, (index) => faker.image.image(random: true)).toList();
    int end = DateTime.now().millisecondsSinceEpoch;
    LoggerUtil('加载100万张图片耗时：${end - start} 毫秒');
    return SuperListView.builder(
      controller: controller,
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
                    child: ElImage(src: imageList[index * 5 + rowIndex]),
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
