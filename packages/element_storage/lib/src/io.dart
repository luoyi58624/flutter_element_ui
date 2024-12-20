import 'dart:convert';
import 'dart:io';

import 'package:element_flutter/element_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<ElStorage> $createStorage(String key, bool isTemp) async {
  final dir = isTemp
      ? await getTemporaryDirectory()
      : await getApplicationSupportDirectory();
  final path = p.join(dir.path, key);
  final file = File(path);
  if (!file.existsSync()) file.createSync();
  try {
    final json = jsonDecode(file.readAsStringSync());
    return _Storage(file, key, json.cast<String, dynamic>());
  } catch (e) {
    return _Storage(file, key, {});
  }
}

class _Storage extends ElStorage {
  final File _file;

  _Storage(this._file, super.key, super.mapData);

  @override
  void serialize() {
    _file.writeAsString(jsonEncode(mapData));
  }
}
