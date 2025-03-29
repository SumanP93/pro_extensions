import 'package:flutter/widgets.dart'; // For TextStyle, Color, FontStyle, FontWeight, TextDecoration

/// Extensions for [TextStyle] and nullable [TextStyle?].
extension TextStyleBoostExtensions on TextStyle? {
  /// Returns `true` if the TextStyle is null or has default properties (or properties that resolve to defaults).
  /// Note: This is a basic check and might not cover all edge cases of TextStyle resolution.
  bool get isNullOrDefault {
    if (this == null) return true;
    // Check against a default TextStyle instance
    const defaultStyle = TextStyle();
    // Compare common properties. More could be added.
    return this!.color == defaultStyle.color &&
        this!.fontSize == defaultStyle.fontSize && // Defaults to 14.0
        this!.fontWeight == defaultStyle.fontWeight && // Defaults to regular
        this!.fontStyle == defaultStyle.fontStyle && // Defaults to normal
        this!.letterSpacing == defaultStyle.letterSpacing &&
        this!.wordSpacing == defaultStyle.wordSpacing &&
        this!.decoration == defaultStyle.decoration; // Defaults to none
  }

  /// Returns a default `TextStyle()` if the value is null, otherwise returns the value itself.
  TextStyle orDefault() => this ?? const TextStyle();

  /// Creates a new [TextStyle] by merging this style with [other].
  /// Properties from [other] take precedence.
  /// If this style is null, returns [other]. If [other] is null, returns this.
  /// If both are null, returns null.
  TextStyle? mergeWith(TextStyle? other) {
    if (this == null) return other;
    if (other == null) return this;
    return this!.merge(other);
  }

  /// Creates a copy of this style with the specified [color].
  /// If this style is null, creates a new style with only the color set.
  TextStyle copyWithColor(Color color) {
    return orDefault().copyWith(color: color);
  }

  /// Creates a copy of this style with the specified [fontSize].
  /// If this style is null, creates a new style with only the font size set.
  TextStyle copyWithSize(double fontSize) {
    return orDefault().copyWith(fontSize: fontSize);
  }

  /// Creates a copy of this style with the specified [fontWeight].
  /// If this style is null, creates a new style with only the font weight set.
  TextStyle copyWithWeight(FontWeight fontWeight) {
    return orDefault().copyWith(fontWeight: fontWeight);
  }

  /// Creates a copy of this style with the specified [fontStyle].
  /// If this style is null, creates a new style with only the font style set.
  TextStyle copyWithStyle(FontStyle fontStyle) {
    return orDefault().copyWith(fontStyle: fontStyle);
  }

  /// Creates a copy of this style with the specified text [decoration].
  /// If this style is null, creates a new style with only the decoration set.
  TextStyle copyWithDecoration(TextDecoration decoration) {
    return orDefault().copyWith(decoration: decoration);
  }

  /// Creates a copy of this style with the specified [letterSpacing].
  /// If this style is null, creates a new style with only the letter spacing set.
  TextStyle copyWithLetterSpacing(double spacing) {
    return orDefault().copyWith(letterSpacing: spacing);
  }

  /// Creates a copy of this style with the specified [wordSpacing].
  /// If this style is null, creates a new style with only the word spacing set.
  TextStyle copyWithWordSpacing(double spacing) {
    return orDefault().copyWith(wordSpacing: spacing);
  }

  /// Creates a copy of this style with the specified line [height].
  /// If this style is null, creates a new style with only the height set.
  TextStyle copyWithHeight(double height) {
    return orDefault().copyWith(height: height);
  }

  // --- Common Style Shortcuts ---

  /// Shortcut for `copyWithWeight(FontWeight.bold)`.
  TextStyle get bold => copyWithWeight(FontWeight.bold);

  /// Shortcut for `copyWithWeight(FontWeight.normal)`.
  TextStyle get normalWeight => copyWithWeight(FontWeight.normal); // More explicit than 'normal'

  /// Shortcut for `copyWithStyle(FontStyle.italic)`.
  TextStyle get italic => copyWithStyle(FontStyle.italic);

  /// Shortcut for `copyWithStyle(FontStyle.normal)`.
  TextStyle get normalStyle => copyWithStyle(FontStyle.normal);

  /// Shortcut for `copyWithDecoration(TextDecoration.underline)`.
  TextStyle get underline => copyWithDecoration(TextDecoration.underline);

  /// Shortcut for `copyWithDecoration(TextDecoration.lineThrough)`.
  TextStyle get lineThrough => copyWithDecoration(TextDecoration.lineThrough);

  /// Shortcut for `copyWithDecoration(TextDecoration.overline)`.
  TextStyle get overline => copyWithDecoration(TextDecoration.overline);

  /// Shortcut for `copyWithDecoration(TextDecoration.none)`.
  TextStyle get noDecoration => copyWithDecoration(TextDecoration.none);
}
