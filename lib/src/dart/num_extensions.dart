/// Extensions for [num] (covers [int] and [double]) and nullable [num?].
extension NumBoostExtensions on num? {
  /// Returns 0 if the number is null, otherwise returns the number's value.
  num orZero() => this ?? 0;

  /// Clamps the number value to be within the range [min] and [max] (inclusive).
  /// Returns `null` if the original value is null.
  /// If [min] > [max], they are swapped.
  /// Works for both int and double. Result type matches the input type if not null.
  ///
  /// Example:
  /// ```dart
  /// 15.clamp(0, 10) // -> 10
  /// -2.3.clamp(0.0, 10.0) // -> 0.0
  /// 5.clamp(0, 10) // -> 5
  /// num? value = null;
  /// value.clamp(0, 10) // -> null
  /// ```
  num? clamp(num min, num max) {
    if (this == null) return null;
    final num effectiveMin = min < max ? min : max;
    final num effectiveMax = min < max ? max : min;
    final value = this!;
    if (value < effectiveMin) return effectiveMin;
    if (value > effectiveMax) return effectiveMax;
    return value;
  }

  /// Checks if the number is between [min] and [max] (inclusive).
  /// Returns `false` if the value is null.
  /// If [min] > [max], they are swapped.
  /// Works for both int and double.
  ///
  /// Example:
  /// ```dart
  /// 5.5.isBetween(0.0, 10.0) // -> true
  /// 12.isBetween(0, 10) // -> false
  /// num? value = null;
  /// value.isBetween(0, 10) // -> false
  /// ```
  bool isBetween(num min, num max) {
    if (this == null) return false;
    final num effectiveMin = min < max ? min : max;
    final num effectiveMax = min < max ? max : min;
    return this! >= effectiveMin && this! <= effectiveMax;
  }

  /// Converts the number to a string representation with a fixed number of decimal places.
  /// If the value is null, returns [defaultValue]. If the value is an int, it's treated as a double.
  ///
  /// Example:
  /// ```dart
  /// 3.14159.toStringAsFixedOrDefault(2) // -> "3.14"
  /// 10.toStringAsFixedOrDefault(1) // -> "10.0"
  /// num? price = null;
  /// price.toStringAsFixedOrDefault(2, defaultValue: 'N/A') // -> "N/A"
  /// ```
  String toStringAsFixedOrDefault(int fractionDigits, {String defaultValue = '0.0'}) {
    if (this == null) return defaultValue;
    // If it's an int, it behaves like double.toStringAsFixed
    return this!.toStringAsFixed(fractionDigits);
  }

  /// Converts the number (assumed to be a proportion, e.g., 0.75) to a percentage string.
  /// Returns [ifNull] (default empty string) if the value is null.
  ///
  /// Example:
  /// ```dart
  /// 0.75.toPercentageString(1) // -> "75.0%"
  /// 1.2.toPercentageString(0) // -> "120%"
  /// num? completion = null;
  /// completion.toPercentageString(0, ifNull: '-') // -> "-"
  /// ```
  String toPercentageString(int decimalPlaces, {String ifNull = ''}) {
    if (this == null) return ifNull;
    final percentage = this! * 100;
    return '${percentage.toStringAsFixed(decimalPlaces)}%';
  }

  // --- Duration Creators ---
  // These allow writing durations like `1.5.minutes`, `10.seconds`.

  /// Returns a [Duration] representing this number of microseconds.
  /// Returns [Duration.zero] if the number is null.
  Duration get microseconds => Duration(microseconds: this?.round() ?? 0);

  /// Returns a [Duration] representing this number of milliseconds.
  /// Returns [Duration.zero] if the number is null.
  Duration get milliseconds => Duration(milliseconds: this?.round() ?? 0);

  /// Returns a [Duration] representing this number of seconds.
  /// Converts double values appropriately.
  /// Returns [Duration.zero] if the number is null.
  Duration get seconds => Duration(microseconds: (this?.toDouble() ?? 0.0 * 1000000).round());

  /// Returns a [Duration] representing this number of minutes.
  /// Converts double values appropriately.
  /// Returns [Duration.zero] if the number is null.
  Duration get minutes => Duration(microseconds: (this?.toDouble() ?? 0.0 * 60 * 1000000).round());

  /// Returns a [Duration] representing this number of hours.
  /// Converts double values appropriately.
  /// Returns [Duration.zero] if the number is null.
  Duration get hours => Duration(microseconds: (this?.toDouble() ?? 0.0 * 60 * 60 * 1000000).round());

  /// Returns a [Duration] representing this number of days.
  /// Converts double values appropriately.
  /// Returns [Duration.zero] if the number is null.
  Duration get days => Duration(microseconds: (this?.toDouble() ?? 0.0 * 24 * 60 * 60 * 1000000).round());
}
