library dart_serialize;

/// Object serialize interface
abstract interface class Serialize<T> {
  /// object -> string
  String? serialize(T? data);

  /// string -> object
  T? deserialize(String? str);
}

/// Data Model serialize interface
abstract interface class SerializeModel<T> {
  /// json -> model
  T fromJson(Map<String, dynamic>? json);

  /// model -> json
  Map<String, dynamic> toJson();
}

/// Object clone interface
abstract interface class Cloneable<T> {
  /// clone object
  T clone();
}
