import 'package:flutter/material.dart';

/// Extensions for the [Color] class.
extension ColorBoostExtensions on Color {
  /// Creates a lighter version of the color by a specified [amount].
  /// Amount should be between 0.0 (no change) and 1.0 (white).
  Color lighter([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Creates a darker version of the color by a specified [amount].
  /// Amount should be between 0.0 (no change) and 1.0 (black).
  Color darker([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Converts the color to its hexadecimal string representation (e.g., "FF00FF" or "80FF00FF").
  /// Includes alpha if [includeAlpha] is true.
  String toHex({bool leadingHashSign = true, bool includeAlpha = true}) {
    String hex = '';
    if (leadingHashSign) {
      hex += '#';
    }
    if (includeAlpha) {
      hex += alpha.toRadixString(16).padLeft(2, '0');
    }
    hex += red.toRadixString(16).padLeft(2, '0');
    hex += green.toRadixString(16).padLeft(2, '0');
    hex += blue.toRadixString(16).padLeft(2, '0');
    return hex.toUpperCase();
  }

  /// Creates a Color from a hex string (e.g., "#FF00FF", "FF00FF", "#80FF00FF", "80FF00FF").
  /// Returns null if the hex string is invalid.
  static Color? fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff'); // Add alpha if missing
    buffer.write(hexString.replaceFirst('#', ''));

    final hexValue = int.tryParse(buffer.toString(), radix: 16);
    if (hexValue == null || (buffer.length != 8)) {
      // Must be 8 hex digits (including alpha)
      return null; // Invalid hex format
    }
    return Color(hexValue);
  }
}

// Add an extension on String to use the static method more easily
extension HexColorStringExtension on String {
  /// Parses a hex color string (e.g., "#FF00FF", "FF00FF", "#80FF00FF") into a Color.
  /// Returns null if the format is invalid.
  Color? toColorOrNull() {
    return ColorBoostExtensions.fromHex(this);
  }
}
