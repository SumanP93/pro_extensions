import 'dart:convert';

import '../utils/_string_validation_patterns.dart';

/// Extensions for [String] and nullable [String?].
extension StringBoostExtensions on String? {
  /// Returns `true` if the string is either null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the string is not null and not empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns `true` if the string is null, empty, or consists only of whitespace characters.
  bool get isNullOrBlank {
    if (isNullOrEmpty) return true;
    return this!.trim().isEmpty;
  }

  /// Returns `true` if the string is not null, not empty, and does not consist only of whitespace.
  bool get isNotNullOrBlank => !isNullOrBlank;

  /// Returns the string itself if it's not null or empty, otherwise returns the [fallback].
  String orEmpty([String fallback = '']) => isNullOrEmpty ? fallback : this!;

  /// Returns the string itself if it's not null or blank, otherwise returns the [fallback].
  String orBlank([String fallback = '']) => isNullOrBlank ? fallback : this!;

  /// Parses the string as an [int] or returns `null` if parsing fails.
  /// Handles potential exceptions during parsing.
  int? toIntOrNull() {
    if (isNullOrEmpty) return null;
    return int.tryParse(this!);
  }

  /// Parses the string as a [double] or returns `null` if parsing fails.
  /// Handles potential exceptions during parsing.
  double? toDoubleOrNull() {
    if (isNullOrEmpty) return null;
    return double.tryParse(this!);
  }

  /// Parses the string as a [bool] or returns `null` if parsing fails.
  /// Considers 'true', '1', 'yes' (case-insensitive) as true.
  /// Considers 'false', '0', 'no' (case-insensitive) as false.
  bool? toBoolOrNull() {
    if (isNullOrEmpty) return null;
    final lowerCase = this!.toLowerCase();
    if (lowerCase == 'true' || lowerCase == '1' || lowerCase == 'yes') return true;
    if (lowerCase == 'false' || lowerCase == '0' || lowerCase == 'no') return false;
    return null;
  }

  /// Returns `true` if the string represents a valid email address.
  bool get isValidEmail {
    if (isNullOrEmpty) return false;
    return StringValidationPatterns.emailRegex.hasMatch(this!);
  }

  /// Returns `true` if the string represents a valid URL (basic check).
  bool get isValidUrl {
    if (isNullOrEmpty) return false;
    return StringValidationPatterns.urlRegex.hasMatch(this!);
  }

  /// Returns `true` if the string represents a potentially valid phone number (very basic check).
  /// Note: For robust phone validation, use a dedicated library like `libphonenumber_plugin`.
  bool get isValidPhone {
    if (isNullOrEmpty) return false;
    return StringValidationPatterns.phoneRegex.hasMatch(this!);
  }

  /// Returns `true` if the string contains the [other] string, ignoring case.
  bool containsIgnoreCase(String other) {
    if (isNullOrEmpty) return false;
    return this!.toLowerCase().contains(other.toLowerCase());
  }

  /// Returns `true` if the string is equal to the [other] string, ignoring case.
  bool equalsIgnoreCase(String other) {
    if (this == null) return false; // Can't compare null with a string
    return this!.toLowerCase() == other.toLowerCase();
  }

  /// Capitalizes the first letter of the string.
  /// Returns an empty string if the input is null or empty.
  /// Example: "hello world" -> "Hello world"
  String capitalize() {
    if (isNullOrEmpty) return '';
    final str = this!;
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  /// Converts the string to Title Case.
  /// Returns an empty string if the input is null or empty.
  /// Example: "hello world" -> "Hello World"
  String toTitleCase() {
    if (isNullOrEmpty) return '';
    final str = this!;
    return str.split(' ').map((word) => word.isNotEmpty ? word.capitalize() : '').join(' ');
  }

  /// Reverses the string.
  /// Returns an empty string if the input is null or empty.
  String reverse() {
    if (isNullOrEmpty) return '';
    return this!.split('').reversed.join('');
  }

  /// Truncates the string to a maximum [maxLength] and appends [ellipsis] if truncated.
  /// Does nothing if the string is shorter than or equal to [maxLength].
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (isNullOrEmpty || this!.length <= maxLength) {
      return this ?? '';
    }
    if (maxLength <= 0) return '';
    if (maxLength < ellipsis.length) return ellipsis.substring(0, maxLength);
    return '${this!.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Returns the string if it passes the [validation] function, otherwise returns `null`.
  String? validate(bool Function(String) validation) {
    if (this != null && validation(this!)) {
      return this!;
    }
    return null;
  }

  /// Removes all whitespace characters from the string.
  String removeWhitespace() {
    if (isNullOrEmpty) return '';
    return this!.replaceAll(RegExp(r'\s+'), '');
  }

  /// Estimates the reading time for the string.
  ///
  /// Assumes an average reading speed provided by [wordsPerMinute] (default is 225).
  /// Calculates based on word count, where words are separated by whitespace.
  /// Returns [Duration.zero] if the string is null or blank.
  Duration readingTime({int wordsPerMinute = 225}) {
    if (isNullOrBlank) return Duration.zero;
    assert(wordsPerMinute > 0, 'wordsPerMinute must be positive.');

    // Split by whitespace and filter out empty strings resulting from multiple spaces
    final wordList = this!.split(RegExp(r'\s+')).where((s) => s.isNotEmpty);
    final wordCount = wordList.length;

    if (wordCount == 0) return Duration.zero;

    final minutes = wordCount / wordsPerMinute;
    final totalSeconds = (minutes * 60);
    // Use milliseconds for better precision within Duration
    final milliseconds = (totalSeconds * 1000).round();

    return Duration(milliseconds: milliseconds);
  }

  /// Calculates the byte size of the string when encoded using the specified [encoding].
  ///
  /// Defaults to UTF-8 encoding, which is common for storage and transmission.
  /// Returns 0 if the string is null or empty.
  int byteSize({Encoding encoding = utf8}) {
    if (isNullOrEmpty) return 0;
    return encoding.encode(this!).length;
  }
}
