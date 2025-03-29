import 'package:flutter/foundation.dart'; // For kDebugMode

/// Extensions for the base [Object] class and nullable objects.
extension ObjectBoostExtensions on Object? {
  /// Returns `true` if the object is null.
  bool get isNull => this == null;

  /// Returns `true` if the object is not null.
  bool get isNotNull => this != null;

  /// Safely casts the object to type [T] or returns null if the cast fails or the object is null.
  ///
  /// Example:
  /// ```dart
  /// Object maybeString = "hello";
  /// String? str = maybeString.safeCast<String>(); // "hello"
  ///
  /// Object maybeInt = 123;
  /// String? notStr = maybeInt.safeCast<String>(); // null
  /// ```
  T? safeCast<T>() {
    if (this is T) {
      return this as T;
    }
    return null;
  }

  /// Executes the provided function [block] if the object is not null.
  /// Returns the result of the block or null if the object was null.
  /// Useful for chaining operations on nullable objects.
  ///
  /// Example:
  /// ```dart
  /// String? name = getName();
  /// int? nameLength = name?.let((it) => it.length);
  /// ```
  R? let<R>(R Function(Object self) block) {
    if (this != null) {
      return block(this!);
    }
    return null;
  }

  /// Executes the provided function [block] if the object is not null.
  /// Similar to `let` but primarily used for side effects. Returns the original object (or null).
  ///
  /// Example:
  /// ```dart
  /// User? user = getUser();
  /// user?.also((it) {
  ///   print("User fetched: ${it.name}");
  /// });
  /// ```
  T? also<T>(void Function(T self) block) {
    if (this != null && this is T) {
      block(this as T);
      return this as T?;
    }
    return null;
  }

  /// Prints the object to the console only in debug mode.
  /// Optionally adds a [prefix] to the output.
  /// Returns the original object for chaining.
  ///
  /// Example:
  /// ```dart
  /// fetchUserData().debugPrint("User Data:").then(...);
  /// ```
  T debugPrint<T>([String prefix = 'DEBUG']) {
    if (kDebugMode) {
      print('$prefix: $this');
    }
    return this as T; // Assume T is the type of 'this'
  }
}
