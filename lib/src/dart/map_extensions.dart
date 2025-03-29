import 'dart:convert'; // For toJson

/// Extensions for [Map] and nullable [Map?].
extension MapBoostExtensions<K, V> on Map<K, V>? {
  /// Returns `true` if the map is either null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the map is not null and not empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns the map itself if it's not null, otherwise returns an empty map.
  Map<K, V> orEmpty() => this ?? const {};

  /// Returns the value associated with the [key], or [defaultValue] if the key is not present or the map is null.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2};
  /// map.getOrDefault('a', 0) // -> 1
  /// map.getOrDefault('c', 0) // -> 0
  ///
  /// Map<String, int>? nullMap;
  /// nullMap.getOrDefault('a', -1) // -> -1
  /// ```
  V? getOrDefault(K key, V? defaultValue) {
    if (this == null) return defaultValue;
    return this!.containsKey(key) ? this![key] : defaultValue;
    // Alternative: return this?[key] ?? defaultValue; (slightly shorter but same effect)
  }

  /// Creates a new map containing only the entries where the value is not null.
  /// Returns an empty map if the original map is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': null, 'c': 3};
  /// map.removeNullValues() // -> {'a': 1, 'c': 3}
  /// ```
  Map<K, V> removeNullValues() {
    if (isNullOrEmpty) return {};
    final result = <K, V>{};
    this!.forEach((key, value) {
      if (value != null) {
        result[key] = value;
      }
    });
    return result;
    // Alternative using where:
    // return Map.fromEntries(this!.entries.where((entry) => entry.value != null));
  }

  /// Creates a new map by applying the [transform] function to each key of the original map.
  /// If multiple original keys map to the same new key, the last one encountered wins.
  /// Returns an empty map if the original map is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final map = {1: 'a', 2: 'b'};
  /// map.mapKeys<String>((key) => 'K$key') // -> {'K1': 'a', 'K2': 'b'}
  /// ```
  Map<NK, V> mapKeys<NK>(NK Function(K key) transform) {
    if (isNullOrEmpty) return {};
    final result = <NK, V>{};
    this!.forEach((key, value) {
      result[transform(key)] = value;
    });
    return result;
  }

  /// Creates a new map by applying the [transform] function to each value of the original map.
  /// Returns an empty map if the original map is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2};
  /// map.mapValues<String>((value) => 'V$value') // -> {'a': 'V1', 'b': 'V2'}
  /// ```
  Map<K, NV> mapValues<NV>(NV Function(V value) transform) {
    if (isNullOrEmpty) return {};
    final result = <K, NV>{};
    this!.forEach((key, value) {
      result[key] = transform(value);
    });
    return result;
    // Alternative using map:
    // return this!.map((key, value) => MapEntry(key, transform(value)));
  }

  /// Merges this map with [other].
  /// If a key exists in both maps, the value from [other] map is used by default.
  /// Returns a new map with combined entries. Returns a copy of this map if [other] is null or empty.
  /// Returns a copy of [other] if this map is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final map1 = {'a': 1, 'b': 2};
  /// final map2 = {'b': 3, 'c': 4};
  /// map1.merge(map2) // -> {'a': 1, 'b': 3, 'c': 4}
  /// ```
  Map<K, V> merge(Map<K, V>? other) {
    if (other == null || other.isEmpty) {
      return Map<K, V>.from(this.orEmpty()); // Return copy
    }
    if (this.isNullOrEmpty) {
      return Map<K, V>.from(other); // Return copy of other
    }
    // Create a new map starting with this, then add other (overwriting duplicates)
    return Map<K, V>.from(this!)..addAll(other);
  }

  /// Converts the map to a JSON string using [jsonEncode].
  /// Returns an empty JSON object string '{}' if the map is null or empty.
  /// Note: Keys must be strings, and values must be JSON-encodable types
  /// (String, num, bool, null, List, Map<String, dynamic>).
  /// Throws [JsonUnsupportedObjectError] if the map contains non-encodable values.
  ///
  /// Example:
  /// ```dart
  /// final map = {'name': 'Alice', 'age': 30, 'city': null};
  /// map.toJson() // -> '{"name":"Alice","age":30,"city":null}'
  /// Map<int, String> numKeyMap = {1: 'a'};
  /// numKeyMap.toJson() // -> Throws error (int keys not directly supported unless converted)
  /// ```
  String toJson() {
    if (isNullOrEmpty) return '{}';
    try {
      return jsonEncode(this);
    } catch (e) {
      // Consider logging the error or rethrowing a more specific exception
      print('Error encoding map to JSON: $e');
      rethrow; // Rethrow the original error by default
      // Or return '{}' or throw custom exception
      // return '{}';
      // throw FormatException('Map contains values that cannot be encoded to JSON.', this);
    }
  }
}

/// Extensions specific to non-nullable [Map<K, V>].
extension NonNullableMapBoostExtensions<K, V> on Map<K, V> {
  // Note: Applies only to non-nullable maps

  /// Adds the key-value pair to the map only if the [value] is not null.
  /// Returns the map itself for chaining.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1};
  /// map.addIfNotNull('b', 2);    // map is now {'a': 1, 'b': 2}
  /// map.addIfNotNull('c', null); // map remains {'a': 1, 'b': 2}
  /// ```
  Map<K, V> addIfNotNull(K key, V? value) {
    if (value != null) {
      this[key] = value;
    }
    return this;
  }

  /// Adds the key-value pair to the map only if the [condition] is true.
  /// Returns the map itself for chaining.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1};
  /// bool shouldAdd = false;
  /// map.addIf(shouldAdd, 'b', 2); // map remains {'a': 1}
  /// shouldAdd = true;
  /// map.addIf(shouldAdd, 'c', 3); // map is now {'a': 1, 'c': 3}
  /// ```
  Map<K, V> addIf(bool condition, K key, V value) {
    if (condition) {
      this[key] = value;
    }
    return this;
  }

  /// Adds all entries from [other] map to this map, but only if the value
  /// in [other] is not null. Keys already present in this map will be overwritten
  /// if the corresponding value in [other] is not null.
  /// Returns the map itself for chaining.
  Map<K, V> addAllIfNotNull(Map<K, V?> other) {
    other.forEach((key, value) {
      addIfNotNull(key, value);
    });
    return this;
  }
}
