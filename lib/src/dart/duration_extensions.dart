import 'dart:async';

/// Extensions for [Duration].
extension DurationBoostExtensions on Duration {
  /// Creates a [Future] that completes after this [Duration].
  /// Useful for creating delays in async functions.
  ///
  /// Example:
  /// ```dart
  /// print("Start");
  /// await 3.seconds.delay; // Uses num extension .seconds
  /// print("End after 3 seconds");
  ///
  /// await const Duration(milliseconds: 500).delay;
  /// print("End after 500ms");
  /// ```
  Future<void> get delay => Future.delayed(this);

  /// Formats the duration into a string like "HH:MM:SS".
  /// Handles durations longer than 24 hours.
  /// Negative durations will have a leading minus sign.
  ///
  /// Example:
  /// ```dart
  /// Duration(hours: 2, minutes: 15, seconds: 30).toHHMMSS() // -> "02:15:30"
  /// Duration(hours: 26, minutes: 0, seconds: 5).toHHMMSS() // -> "26:00:05"
  /// Duration(minutes: 5, seconds: 10).toHHMMSS() // -> "00:05:10"
  /// Duration(seconds: -10).toHHMMSS() // -> "-00:00:10"
  /// ```
  String toHHMMSS() {
    // Handle negative durations
    final Duration absoluteDuration = isNegative ? -this : this;

    final String hours = absoluteDuration.inHours.toString().padLeft(2, '0');
    final String minutes = absoluteDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds = absoluteDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${isNegative ? '-' : ''}$hours:$minutes:$seconds";
  }

  /// Formats the duration into a string like "MM:SS".
  /// Total minutes are shown (e.g., 90 minutes becomes "90:00").
  /// Negative durations will have a leading minus sign.
  ///
  /// Example:
  /// ```dart
  /// Duration(minutes: 5, seconds: 30).toMMSS() // -> "05:30"
  /// Duration(hours: 1, minutes: 30, seconds: 15).toMMSS() // -> "90:15"
  /// Duration(seconds: -45).toMMSS() // -> "-00:45"
  /// ```
  String toMMSS() {
    final Duration absoluteDuration = isNegative ? -this : this;

    final String minutes = absoluteDuration.inMinutes.toString().padLeft(2, '0');
    final String seconds = absoluteDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${isNegative ? '-' : ''}$minutes:$seconds";
  }

  /// Provides a human-readable string representation of the duration.
  /// Omits zero components. Example: "2h 15m", "30s 500ms", "1d 5h".
  /// Returns "0s" for Duration.zero.
  /// Handles negative durations with a leading "-".
  ///
  /// Example:
  /// ```dart
  /// Duration(days: 1, hours: 5, minutes: 10).toHumanReadable() // -> "1d 5h 10m"
  /// Duration(minutes: 30, seconds: 5).toHumanReadable() // -> "30m 5s"
  /// Duration(milliseconds: 750).toHumanReadable() // -> "750ms"
  /// Duration.zero.toHumanReadable() // -> "0s"
  /// Duration(seconds: -90).toHumanReadable() // -> "-1m 30s"
  /// ```
  String toHumanReadable() {
    if (this == Duration.zero) return "0s";

    final Duration absoluteDuration = isNegative ? -this : this;

    final List<String> parts = [];
    final int days = absoluteDuration.inDays;
    final int hours = absoluteDuration.inHours.remainder(24);
    final int minutes = absoluteDuration.inMinutes.remainder(60);
    final int seconds = absoluteDuration.inSeconds.remainder(60);
    final int milliseconds = absoluteDuration.inMilliseconds.remainder(1000);
    // final int microseconds = absoluteDuration.inMicroseconds.remainder(1000); // Usually too granular

    if (days > 0) parts.add("${days}d");
    if (hours > 0) parts.add("${hours}h");
    if (minutes > 0) parts.add("${minutes}m");
    if (seconds > 0) parts.add("${seconds}s");
    if (milliseconds > 0 && parts.length < 3) {
      // Show ms only if other parts are few
      parts.add("${milliseconds}ms");
    }
    // if (microseconds > 0 && parts.isEmpty) parts.add("${microseconds}μs"); // Add if needed

    if (parts.isEmpty) {
      // Handle very small durations (e.g., microseconds only if not added above)
      if (absoluteDuration.inMicroseconds > 0) return "${isNegative ? '-' : ''}${absoluteDuration.inMicroseconds}μs";
      return "0s"; // Fallback
    }

    return "${isNegative ? '-' : ''}${parts.join(' ')}";
  }
}
