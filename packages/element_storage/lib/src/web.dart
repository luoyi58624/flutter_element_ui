import 'dart:convert';

import 'package:web/web.dart' show window;

import '../element_storage.dart';

final _localStorage = window.localStorage;
final _sessionStorage = window.sessionStorage;

Future<ElStorage> $createStorage(String key, bool isTemp) async {
  if (isTemp) {
    final result = _sessionStorage.getItem(key);
    if (result != null) {
      final json = jsonDecode(result);
      return _SessionStorage(key, json.cast<String, dynamic>());
    } else {
      return _SessionStorage(key, {});
    }
  } else {
    final result = _localStorage.getItem(key);
    if (result != null) {
      final json = jsonDecode(result);
      return _LocalStorage(key, json.cast<String, dynamic>());
    } else {
      return _LocalStorage(key, {});
    }
  }
}

class _LocalStorage extends ElStorage {
  _LocalStorage(super.key, super.storage);

  @override
  void serialize() => _localStorage.setItem(key, jsonEncode(storage));
}

class _SessionStorage extends ElStorage {
  _SessionStorage(super.key, super.storage);

  @override
  void serialize() => _sessionStorage.setItem(key, jsonEncode(storage));
}
