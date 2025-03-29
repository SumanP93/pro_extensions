import 'dart:math';

/// Extensions for [double] and nullable [double?].
extension DoubleBoostExtensions on double? {
  /// Returns 0.0 if the double is null, otherwise returns the double's value.
  ///
  /// Example:
  /// ```dart
  /// double? value = 10.5;
  /// value.orZero() // -> 10.5
  ///
  /// value = null;
  /// value.orZero() // -> 0.0
  /// ```
  double orZero() => this ?? 0.0;

  /// Clamps the double value to be within the range [min] and [max] (inclusive).
  /// Returns `null` if the original value is null.
  /// If [min] > [max], they are swapped.
  ///
  /// Example:
  /// ```dart
  /// 15.6.clamp(0.0, 10.0) // -> 10.0
  /// -2.3.clamp(0.0, 10.0) // -> 0.0
  /// 5.0.clamp(0.0, 10.0) // -> 5.0
  /// double? value = null;
  /// value.clamp(0.0, 10.0) // -> null
  /// ```
  double? clamp(double min, double max) {
    if (this == null) return null;
    final double effectiveMin = min < max ? min : max;
    final double effectiveMax = min < max ? max : min;
    final value = this!;
    if (value < effectiveMin) return effectiveMin;
    if (value > effectiveMax) return effectiveMax;
    return value;
  }

  /// Rounds the double to [decimalPlaces].
  /// Returns `null` if the original value is null.
  /// Uses a mathematical approach for rounding.
  ///
  /// Example:
  /// ```dart
  /// 3.14159.roundToDecimalPlaces(2) // -> 3.14
  /// 10.987.roundToDecimalPlaces(1) // -> 11.0
  /// -2.345.roundToDecimalPlaces(2) // -> -2.35
  /// double? value = null;
  /// value.roundToDecimalPlaces(2) // -> null
  /// ```
  double? roundToDecimalPlaces(int decimalPlaces) {
    if (this == null) return null;
    if (decimalPlaces < 0) throw ArgumentError("decimalPlaces must be non-negative");
    final value = this!;
    if (!value.isFinite) return value; // Avoid issues with NaN or Infinity

    num factor = pow(10, decimalPlaces);
    return (value * factor).round() / factor;
  }

  /// Converts the double to a string representation with a fixed number of decimal places.
  /// If the value is null, returns [defaultValue].
  ///
  /// Example:
  /// ```dart
  /// 3.14159.toStringAsFixedOrDefault(2) // -> "3.14"
  /// double? price = null;
  /// price.toStringAsFixedOrDefault(2, defaultValue: 'N/A') // -> "N/A"
  /// ```
  String toStringAsFixedOrDefault(int fractionDigits, {String defaultValue = '0.0'}) {
    if (this == null) return defaultValue;
    return this!.toStringAsFixed(fractionDigits);
  }

  /// Checks if the double value represents an integer (has no fractional part).
  /// Accounts for potential floating-point inaccuracies using a small epsilon.
  /// Returns `false` if the value is null, NaN, or infinite.
  ///
  /// Example:
  /// ```dart
  /// 10.0.isInteger() // -> true
  /// 10.5.isInteger() // -> false
  /// -5.0.isInteger() // -> true
  /// (1.0 + 2.0).isInteger() // -> true (usually)
  /// double? val = null;
  /// val.isInteger() // -> false
  /// ```
  bool isInteger({double epsilon = 1e-10}) {
    if (this == null || !this!.isFinite) return false;
    return (this!.abs() - this!.truncate().abs()).abs() < epsilon;
  }

  /// Checks if the double is between [min] and [max] (inclusive).
  /// Returns `false` if the value is null.
  /// If [min] > [max], they are swapped.
  ///
  /// Example:
  /// ```dart
  /// 5.5.isBetween(0.0, 10.0) // -> true
  /// 12.0.isBetween(0.0, 10.0) // -> false
  /// double? value = null;
  /// value.isBetween(0.0, 10.0) // -> false
  /// ```
  bool isBetween(double min, double max) {
    if (this == null) return false;
    final double effectiveMin = min < max ? min : max;
    final double effectiveMax = min < max ? max : min;
    return this! >= effectiveMin && this! <= effectiveMax;
  }
}
