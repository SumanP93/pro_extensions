// Internal utility file - not exported by the main library.
// Prefix with '_' to indicate privacy.

// ignore_for_file: constant_identifier_names

/// Holds common regular expression patterns for string validation.
class StringValidationPatterns {
  /// Basic email validation regex. Covers most common cases but not all edge cases (RFC 5322).
  static final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// Basic URL validation regex. Requires http/https protocol.
  static final RegExp urlRegex = RegExp(
    r'^(https?:\/\/)?' // Optional protocol http:// or https://
    r'((([a-zA-Z\d]([a-zA-Z\d-]*[a-zA-Z\d])*)\.)+[a-zA-Z]{2,}|' // domain name
    r'((\d{1,3}\.){3}\d{1,3}))' // OR ip (v4) address
    r'(\:\d+)?(\/[-a-zA-Z\d%_.~+]*)*' // port and path
    r'(\?[;&a-zA-Z\d%_.~+=-]*)?' // query string
    r'(\#[-a-zA-Z\d_]*)?$', // fragment locator
    caseSensitive: false,
  );

  /// VERY basic phone number validation (allows digits, spaces, hyphens, parentheses, plus sign).
  /// WARNING: Does not validate actual phone number formats. Use a dedicated library for real validation.
  static final RegExp phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  /// Regex for validating if a string contains only alphabetic characters.
  static final RegExp onlyAlphabeticRegex = RegExp(r'^[a-zA-Z]+$');

  /// Regex for validating if a string contains only alphanumeric characters.
  static final RegExp onlyAlphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

  /// Regex for validating if a string contains only numeric characters (digits).
  static final RegExp onlyNumericRegex = RegExp(r'^[0-9]+$');
}
