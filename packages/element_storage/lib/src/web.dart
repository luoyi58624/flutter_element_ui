import 'dart:convert';

import 'package:element_flutter/element_flutter.dart';
import 'package:web/web.dart' show window;

final _localStorage = window.localStorage;
final _sessionStorage = window.sessionStorage;

Future<ElStorage> $createStorage(
  String key,
  bool isTemp,
  ElSerializePreset serializePreset,
) async {
  if (isTemp) {
    final result = _sessionStorage.getItem(key);
    if (result != null) {
      final json = jsonDecode(result);
      return _SessionStorage(
        key,
        json.cast<String, dynamic>(),
        serializePreset,
      );
    } else {
      return _SessionStorage(key, {}, serializePreset);
    }
  } else {
    final result = _localStorage.getItem(key);
    if (result != null) {
      final json = jsonDecode(result);
      return _LocalStorage(key, json.cast<String, dynamic>(), serializePreset);
    } else {
      return _LocalStorage(key, {}, serializePreset);
    }
  }
}

class _LocalStorage extends ElStorage {
  _LocalStorage(super.key, super.mapData, super.serializePreset);

  @override
  void serialize() => _localStorage.setItem(key, jsonEncode(mapData));
}

class _SessionStorage extends ElStorage {
  _SessionStorage(super.key, super.mapData, super.serializePreset);

  @override
  void serialize() => _sessionStorage.setItem(key, jsonEncode(mapData));
}
