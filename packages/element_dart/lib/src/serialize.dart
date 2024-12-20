/// Object serialize interface
abstract interface class ElSerialize<T> {
  /// object -> string
  String? serialize(T? obj);

  /// string -> object
  T? deserialize(String? str);
}

/// Data Model serialize interface
abstract interface class ElSerializeModel<T> {
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
