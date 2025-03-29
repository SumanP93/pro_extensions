import 'package:flutter/material.dart'; // For TimeOfDay comparison
// Note: For advanced, locale-aware formatting, consider adding the 'intl' package.
// These extensions provide basic, fixed-format options.

/// Extensions for [DateTime] and nullable [DateTime?].
extension DateTimeBoostExtensions on DateTime? {
  /// Returns `true` if the [DateTime] object is not null.
  bool get isNotNull => this != null;

  /// Returns `true` if the [DateTime] object is null.
  bool get isNull => this == null;

  /// Checks if this [DateTime] occurs on the same day as [other].
  /// Ignores the time part.
  /// Returns `false` if either date is null.
  ///
  /// Example:
  /// ```dart
  /// final date1 = DateTime(2023, 10, 26, 10, 00);
  /// final date2 = DateTime(2023, 10, 26, 18, 30);
  /// date1.isSameDay(date2) // -> true
  ///
  /// final date3 = DateTime(2023, 10, 27);
  /// date1.isSameDay(date3) // -> false
  /// ```
  bool isSameDay(DateTime? other) {
    if (this == null || other == null) return false;
    final d = this!;
    return d.year == other.year && d.month == other.month && d.day == other.day;
  }

  /// Checks if this [DateTime] occurs on the same month as [other].
  /// Ignores the day and time parts.
  /// Returns `false` if either date is null.
  bool isSameMonth(DateTime? other) {
    if (this == null || other == null) return false;
    final d = this!;
    return d.year == other.year && d.month == other.month;
  }

  /// Checks if this [DateTime] occurs in the same year as [other].
  /// Ignores the month, day and time parts.
  /// Returns `false` if either date is null.
  bool isSameYear(DateTime? other) {
    if (this == null || other == null) return false;
    final d = this!;
    return d.year == other.year;
  }

  /// Checks if this [DateTime] is today.
  /// Returns `false` if the date is null.
  bool get isToday {
    if (this == null) return false;
    return this!.isSameDay(DateTime.now());
  }

  /// Checks if this [DateTime] was yesterday.
  /// Returns `false` if the date is null.
  bool get isYesterday {
    if (this == null) return false;
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return this!.isSameDay(yesterday);
  }

  /// Checks if this [DateTime] is tomorrow.
  /// Returns `false` if the date is null.
  bool get isTomorrow {
    if (this == null) return false;
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return this!.isSameDay(tomorrow);
  }

  /// Checks if this [DateTime] falls within the current week (assuming Monday is the start of the week).
  /// Returns `false` if the date is null.
  bool get isThisWeek {
    if (this == null) return false;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
    final endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

    // Check if the date is on or after start of week and on or before end of week (ignoring time)
    final dateOnly = DateTime(this!.year, this!.month, this!.day);
    final startOfWeekOnly = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endOfWeekOnly = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day);

    return !dateOnly.isBefore(startOfWeekOnly) && !dateOnly.isAfter(endOfWeekOnly);
  }

  /// Checks if this [DateTime] is in the future compared to the current time.
  /// Returns `false` if the date is null.
  bool get isInFuture {
    if (this == null) return false;
    return this!.isAfter(DateTime.now());
  }

  /// Checks if this [DateTime] is in the past compared to the current time.
  /// Returns `false` if the date is null.
  bool get isInPast {
    if (this == null) return false;
    // Use isBefore OR isAtSameMomentAs to include the exact current moment as "past"
    return this!.isBefore(DateTime.now());
  }

  /// Returns a new [DateTime] instance representing the start of the day (00:00:00).
  /// Returns `null` if the original date is null.
  DateTime? get startOfDay {
    if (this == null) return null;
    final d = this!;
    return DateTime(d.year, d.month, d.day);
  }

  /// Returns a new [DateTime] instance representing the end of the day (23:59:59.999).
  /// Returns `null` if the original date is null.
  DateTime? get endOfDay {
    if (this == null) return null;
    final d = this!;
    return DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
  }

  /// Returns a new [DateTime] instance representing the start of the month (day 1, 00:00:00).
  /// Returns `null` if the original date is null.
  DateTime? get startOfMonth {
    if (this == null) return null;
    final d = this!;
    return DateTime(d.year, d.month, 1);
  }

  /// Returns a new [DateTime] instance representing the end of the month
  /// (last day, 23:59:59.999). Handles different month lengths and leap years.
  /// Returns `null` if the original date is null.
  DateTime? get endOfMonth {
    if (this == null) return null;
    final d = this!;
    // Go to the first day of the next month, then subtract a millisecond
    final nextMonth = (d.month < 12) ? DateTime(d.year, d.month + 1, 1) : DateTime(d.year + 1, 1, 1);
    return nextMonth.subtract(const Duration(milliseconds: 1));
  }

  /// Returns a new [DateTime] by adding the specified [duration].
  /// Returns `null` if the original date is null.
  DateTime? addDuration(Duration duration) {
    if (this == null) return null;
    return this!.add(duration);
  }

  /// Returns a new [DateTime] by subtracting the specified [duration].
  /// Returns `null` if the original date is null.
  DateTime? subtractDuration(Duration duration) {
    if (this == null) return null;
    return this!.subtract(duration);
  }

  /// Formats the [DateTime] as 'YYYY-MM-DD'.
  /// Returns `null` or the [ifNull] string (default empty) if the date is null.
  ///
  /// Example: `DateTime(2023, 10, 26).formatYYYYMMDD() // -> "2023-10-26"`
  String formatYYYYMMDD({String ifNull = ''}) {
    if (this == null) return ifNull;
    final d = this!;
    return "${d.year.toString().padLeft(4, '0')}-"
        "${d.month.toString().padLeft(2, '0')}-"
        "${d.day.toString().padLeft(2, '0')}";
  }

  /// Formats the [DateTime] as 'DD/MM/YYYY'.
  /// Returns `null` or the [ifNull] string (default empty) if the date is null.
  ///
  /// Example: `DateTime(2023, 10, 26).formatDDMMYYYY() // -> "26/10/2023"`
  String formatDDMMYYYY({String ifNull = ''}) {
    if (this == null) return ifNull;
    final d = this!;
    return "${d.day.toString().padLeft(2, '0')}/"
        "${d.month.toString().padLeft(2, '0')}/"
        "${d.year.toString().padLeft(4, '0')}";
  }

  /// Formats the [DateTime] as 'MM/DD/YYYY'.
  /// Returns `null` or the [ifNull] string (default empty) if the date is null.
  ///
  /// Example: `DateTime(2023, 10, 26).formatMMDDYYYY() // -> "10/26/2023"`
  String formatMMDDYYYY({String ifNull = ''}) {
    if (this == null) return ifNull;
    final d = this!;
    return "${d.month.toString().padLeft(2, '0')}/"
        "${d.day.toString().padLeft(2, '0')}/"
        "${d.year.toString().padLeft(4, '0')}";
  }

  /// Formats the time part of [DateTime] as 'HH:MM:SS' (24-hour format).
  /// Returns `null` or the [ifNull] string (default empty) if the date is null.
  ///
  /// Example: `DateTime(2023, 10, 26, 14, 35, 05).formatHHMMSS() // -> "14:35:05"`
  String formatHHMMSS({String ifNull = ''}) {
    if (this == null) return ifNull;
    final d = this!;
    return "${d.hour.toString().padLeft(2, '0')}:"
        "${d.minute.toString().padLeft(2, '0')}:"
        "${d.second.toString().padLeft(2, '0')}";
  }

  /// Formats the time part of [DateTime] as 'HH:MM' (24-hour format).
  /// Returns `null` or the [ifNull] string (default empty) if the date is null.
  ///
  /// Example: `DateTime(2023, 10, 26, 14, 35, 05).formatHHMM() // -> "14:35"`
  String formatHHMM({String ifNull = ''}) {
    if (this == null) return ifNull;
    final d = this!;
    return "${d.hour.toString().padLeft(2, '0')}:"
        "${d.minute.toString().padLeft(2, '0')}";
  }

  /// Provides a basic relative time string like "5 minutes ago", "2 hours ago", "Yesterday", "3 days ago".
  /// Does not provide future times like "in 5 minutes".
  /// Returns `null` or the [ifNull] string (default empty) if the date is null.
  /// Note: This is a simplified version. For i18n and more complex cases, use a dedicated package like `timeago`.
  String timeAgo({String ifNull = ''}) {
    if (this == null) return ifNull;
    final d = this!;
    final now = DateTime.now();
    final difference = now.difference(d);

    if (difference.isNegative) {
      // Handle future dates minimally or return specific string
      // For simplicity, we'll treat future as "just now" or similar in this basic version.
      // A more robust version could return "in X minutes/hours".
      return "just now"; // Or formatYYYYMMDD() or similar fallback
    }

    if (difference.inSeconds < 5) {
      return "just now";
    } else if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago";
    } else if (d.isYesterday) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago";
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return "$weeks week${weeks == 1 ? '' : 's'} ago";
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor(); // Approximate
      return "$months month${months == 1 ? '' : 's'} ago";
    } else {
      final years = (difference.inDays / 365).floor(); // Approximate
      return "$years year${years == 1 ? '' : 's'} ago";
    }
  }

  /// Checks if the time part of this DateTime is the same as the given [TimeOfDay].
  /// Returns `false` if DateTime is null.
  bool hasSameTime(TimeOfDay timeOfDay) {
    if (this == null) return false;
    final d = this!;
    return d.hour == timeOfDay.hour && d.minute == timeOfDay.minute;
  }
}
