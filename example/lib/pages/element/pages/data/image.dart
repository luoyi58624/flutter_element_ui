import 'package:example/global.dart';
import 'package:flutter/material.dart';

BaseHttp http = BaseHttp(enableCacheInterceptor: true);

class ImagePage extends HookWidget {
  const ImagePage({super.key});

  Future<void> loadImageList(ValueNotifier<List<String>> imageList) async {
    final resData = await http.get(
      'https://api.unsplash.com/photos/random/?client_id=H1Ta-9K4hz-7M0B5sCPN9PtxHNmaPl87QDfCzsf7E2c&count=10',
      getRequestExtra: GetRequestExtra(enableCache: true, useCache: true),
    );
    if (!DartUtil.isEmpty(resData)) {
      final urlList =
          (resData as List).cast<Map>().map((e) => e['urls']['small']).toList();
      List<String> list = [];
      List.generate(10000, (index) {
        list.addAll(urlList.cast<String>());
      });
      imageList.value = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageList = useState<List<String>>([]);
    useEffect(() {
      loadImageList(imageList);
      return null;
    }, []);
    final rowCount = context.xs
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
    return ObsBuilder(builder: (context) {
      return SuperListView.builder(
        itemCount: (imageList.value.length / rowCount).floor(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ...List.generate(
                rowCount,
                (rowIndex) => Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ObsBuilder(builder: (context) {
                        return ElImage(
                            src: imageList.value[index * rowCount + rowIndex]);
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
