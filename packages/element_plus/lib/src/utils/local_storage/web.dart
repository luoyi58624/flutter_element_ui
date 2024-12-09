import 'dart:convert';

import 'package:web/web.dart' show window;

import 'local_storage.dart';

final _storage = window.localStorage;

Future<ElStorage> $createLocalStorage(String key) async {
  final result = _storage.getItem(key);
  if (result != null) {
    final json = jsonDecode(result);
    return _LocalStorage(key, json.cast<String, dynamic>());
  } else {
    return _LocalStorage(key, {});
  }
}

class _LocalStorage extends ElStorage {
  _LocalStorage(super.key, super.storage);

  @override
  void serialize() => window.localStorage.setItem(key, jsonEncode(_storage));
}
