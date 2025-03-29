/// Extensions for [bool] and nullable [bool?].
extension BoolBoostExtensions on bool? {
  /// Returns `true` if the value is not null and true.
  bool get isTrue => this == true;

  /// Returns `true` if the value is not null and false.
  /// Note: This is different from `isNullOrFalse`, which is true if the value is null OR false.
  bool get isFalse => this == false;

  /// Returns `true` if the value is null or false.
  bool get isNullOrFalse => this == null || this == false;

  /// Returns `true` if the value is null or true.
  bool get isNullOrTrue => this == null || this == true;

  /// Converts the boolean to an integer.
  ///
  /// Returns:
  /// - `1` if the boolean is true.
  /// - `0` if the boolean is false or null.
  ///
  /// Example:
  /// ```dart
  /// true.toInt()  // -> 1
  /// false.toInt() // -> 0
  /// null.toInt()  // -> 0 (where null is bool?)
  /// ```
  int toInt() => this == true ? 1 : 0;

  /// Executes the [callback] only if the boolean value is not null and true.
  /// Returns the original boolean value for chaining.
  ///
  /// Example:
  /// ```dart
  /// bool loggedIn = checkLoginStatus();
  /// loggedIn.ifTrue(() => print('User is logged in.'));
  /// ```
  bool? ifTrue(void Function() callback) {
    if (this == true) {
      callback();
    }
    return this;
  }

  /// Executes the [callback] only if the boolean value is not null and false.
  /// Returns the original boolean value for chaining.
  ///
  /// Example:
  /// ```dart
  /// bool hasErrors = validateForm();
  /// hasErrors.ifFalse(() => submitForm());
  /// ```
  bool? ifFalse(void Function() callback) {
    if (this == false) {
      callback();
    }
    return this;
  }

  /// Returns a custom string representation based on the boolean value.
  ///
  /// Handles null by returning the [ifNull] value (defaults to an empty string).
  ///
  /// Example:
  /// ```dart
  /// true.toStringRepresentation('Yes', 'No') // -> 'Yes'
  /// false.toStringRepresentation('Yes', 'No') // -> 'No'
  /// bool? maybeFlag = null;
  /// maybeFlag.toStringRepresentation('Active', 'Inactive', ifNull: 'Unknown') // -> 'Unknown'
  /// ```
  String toStringRepresentation(String ifTrue, String ifFalse, {String ifNull = ''}) {
    if (this == true) return ifTrue;
    if (this == false) return ifFalse;
    return ifNull;
  }
}

/// Extensions specific to non-nullable [bool].
extension NonNullableBoolBoostExtensions on bool {
  /// Toggles the boolean value (true becomes false, false becomes true).
  ///
  /// Example:
  /// ```dart
  /// bool lightIsOn = true;
  /// lightIsOn = lightIsOn.toggle(); // lightIsOn is now false
  /// ```
  bool toggle() => !this;
}
