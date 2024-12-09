import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'local_storage.dart';

Future<ElStorage> $createLocalStorage(String key) async {
  final dir = await getApplicationSupportDirectory();
  final path = p.join(dir.path, key);
  final file = File(path);
  if (!file.existsSync()) file.createSync();
  try {
    final json = jsonDecode(file.readAsStringSync());
    return _LocalStorage(file, key, json.cast<String, dynamic>());
  } catch (e) {
    return _LocalStorage(file, key, {});
  }
}

class _LocalStorage extends ElStorage {
  final File _file;

  _LocalStorage(this._file, super.key, super.storage);

  @override
  void serialize() {
    _file.writeAsString(jsonEncode(storage));
  }
}
