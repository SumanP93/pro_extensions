/// Extensions for [int].
extension IntBoostExtensions on int {
  /// Returns `true` if the integer is between [min] and [max] (inclusive).
  bool isBetween(int min, int max) {
    assert(min <= max, 'min must be less than or equal to max');
    return this >= min && this <= max;
  }

  /// Clamps the integer to be within the range [min] and [max] (inclusive).
  int clamp(int min, int max) {
    assert(min <= max, 'min must be less than or equal to max');
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Executes the [action] function [this] number of times.
  /// The callback receives the current index (0-based).
  ///
  /// Example:
  /// ```dart
  /// 5.times((i) => print("Loop #$i"));
  /// ```
  void times(void Function(int index) action) {
    if (this < 0) return; // Or throw ArgumentError? Decided to just do nothing.
    for (int i = 0; i < this; i++) {
      action(i);
    }
  }

  /// Returns the ordinal representation of the number (e.g., 1st, 2nd, 3rd, 4th).
  String toOrdinal() {
    if (this <= 0) return toString(); // Or handle differently?
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  // --- File Size Helpers ---

  /// Represents the integer value as Kilobytes (value * 1024).
  int get kb => this * 1024;

  /// Represents the integer value as Megabytes (value * 1024 * 1024).
  int get mb => this * 1024 * 1024;

  /// Represents the integer value as Gigabytes (value * 1024 * 1024 * 1024).
  int get gb => this * 1024 * 1024 * 1024;

  String get formatedSize {
    if (this <= 0) return "0 B";
    if (this < 1024) return "$this B";
    if (this < 1024 * 1024) return "${(this / 1024).toStringAsFixed(1)} KB"; // KB
    if (this < 1024 * 1024 * 1024) return "${(this / (1024 * 1024)).toStringAsFixed(1)} MB";
    if (this < 1024 * 1024 * 1024 * 1024) return "${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB";
    if (this < 1024 * 1024 * 1024 * 1024 * 1024) return "${(this / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(1)} TB";
    if (this < 1024 * 1024 * 1024 * 1024 * 1024 * 1024) {
      return "${(this / (1024 * 1024 * 1024 * 1024 * 1024)).toStringAsFixed(1)} PB";
    }
    if (this < 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024) {
      return "${(this / (1024 * 1024 * 1024 * 1024 * 1024 * 1024)).toStringAsFixed(1)} EB";
    }
    if (this < 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024) {
      return "${(this / (1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024)).toStringAsFixed(1)} ZB";
    }
    return "${(this / (1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024)).toStringAsFixed(1)} YB";
  }
}
