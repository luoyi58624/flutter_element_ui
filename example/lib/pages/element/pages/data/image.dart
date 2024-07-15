import 'package:example/global.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ImagePage extends HookWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    int start = DateTime.now().millisecondsSinceEpoch;
    var imageList = useObs(
        List.generate(100000, (index) => faker.image.image(random: true))
            .toList());
    int end = DateTime.now().millisecondsSinceEpoch;
    final count = context.xs
        ? 1
        : context.sm
            ? 2
            : context.md
                ? 4
                : context.lg
                    ? 5
                    : context.xl
                        ? 10
                        : 10;
    i('加载10万张图片耗时：${end - start} 毫秒');
    return ObsBuilder(builder: (context) {
      return SuperListView.builder(
        itemCount: (imageList.value.length / count).floor(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ...List.generate(
                count,
                (rowIndex) => Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ObsBuilder(builder: (context) {
                        return ElImage(
                            src: imageList.value[index * count + rowIndex]);
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
