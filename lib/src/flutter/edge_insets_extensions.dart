import 'package:flutter/widgets.dart'; // For EdgeInsets, EdgeInsetsGeometry

/// Extensions for [EdgeInsetsGeometry] and nullable [EdgeInsetsGeometry?].
extension EdgeInsetsGeometryBoostExtensions on EdgeInsetsGeometry? {
  /// Returns `true` if the EdgeInsetsGeometry is null or represents no insets ([EdgeInsets.zero]).
  bool get isNullOrZero {
    if (this == null) return true;
    // EdgeInsetsGeometry doesn't have a direct 'zero' check, but EdgeInsets does.
    // We rely on the most common implementation.
    final geometry = this!;
    if (geometry is EdgeInsets) {
      return geometry == EdgeInsets.zero;
    }
    // For EdgeInsetsDirectional or others, check resolved values if possible,
    // or assume non-zero if not EdgeInsets.zero. This might not cover all
    // custom EdgeInsetsGeometry subclasses perfectly.
    final resolved = geometry.resolve(TextDirection.ltr); // Resolve with arbitrary direction
    return resolved == EdgeInsets.zero;
  }

  /// Returns `EdgeInsets.zero` if the value is null, otherwise returns the value itself.
  EdgeInsetsGeometry orZero() => this ?? EdgeInsets.zero;

  /// Returns the total horizontal inset (left + right or start + end).
  /// Resolves directional insets using [TextDirection.ltr] by default if needed.
  /// Returns 0.0 if null.
  double horizontal({TextDirection direction = TextDirection.ltr}) {
    if (this == null) return 0.0;
    final resolved = this!.resolve(direction);
    return resolved.left + resolved.right;
  }

  /// Returns the total vertical inset (top + bottom).
  /// Returns 0.0 if null.
  double vertical({TextDirection direction = TextDirection.ltr}) {
    if (this == null) return 0.0;
    final resolved = this!.resolve(direction);
    return resolved.top + resolved.bottom;
  }

  /// Creates a new [EdgeInsets] by adding the resolved values of this [EdgeInsetsGeometry]
  /// and the [other] [EdgeInsetsGeometry].
  /// Resolves directional insets using [TextDirection.ltr] by default.
  /// Returns `EdgeInsets.zero` if both are null. Returns the non-null one if the other is null.
  EdgeInsets add(EdgeInsetsGeometry? other, {TextDirection direction = TextDirection.ltr}) {
    if (this == null && other == null) return EdgeInsets.zero;
    if (this == null) return other!.resolve(direction);
    if (other == null) return this!.resolve(direction);

    final resolvedThis = this!.resolve(direction);
    final resolvedOther = other.resolve(direction);

    return EdgeInsets.only(
      left: resolvedThis.left + resolvedOther.left,
      top: resolvedThis.top + resolvedOther.top,
      right: resolvedThis.right + resolvedOther.right,
      bottom: resolvedThis.bottom + resolvedOther.bottom,
    );
  }

  /// Creates a new [EdgeInsets] by subtracting the resolved values of the [other] [EdgeInsetsGeometry]
  /// from this [EdgeInsetsGeometry]. Resulting values are clamped to be non-negative.
  /// Resolves directional insets using [TextDirection.ltr] by default.
  /// Returns this resolved value if [other] is null. Returns zero if this is null.
  EdgeInsets subtract(EdgeInsetsGeometry? other, {TextDirection direction = TextDirection.ltr}) {
    if (this == null) return EdgeInsets.zero;
    if (other == null) return this!.resolve(direction);

    final resolvedThis = this!.resolve(direction);
    final resolvedOther = other.resolve(direction);

    // Helper to subtract and clamp at 0
    double subtractClampZero(double a, double b) => (a - b) < 0.0 ? 0.0 : (a - b);

    return EdgeInsets.only(
      left: subtractClampZero(resolvedThis.left, resolvedOther.left),
      top: subtractClampZero(resolvedThis.top, resolvedOther.top),
      right: subtractClampZero(resolvedThis.right, resolvedOther.right),
      bottom: subtractClampZero(resolvedThis.bottom, resolvedOther.bottom),
    );
  }

  /// Creates a new [EdgeInsets] instance with specified values potentially overridden.
  /// If the original value is null, creates a new EdgeInsets with only the specified overrides.
  /// If the original value is directional, it's resolved using [direction] before copying.
  ///
  /// Example:
  /// ```dart
  /// final padding = EdgeInsets.all(10);
  /// final newPadding = padding.copyWith(top: 5); // -> EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10)
  ///
  /// EdgeInsetsGeometry? maybePadding = null;
  /// final newerPadding = maybePadding.copyWith(left: 15); // -> EdgeInsets.only(left: 15)
  /// ```
  EdgeInsets copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
    TextDirection direction = TextDirection.ltr,
  }) {
    if (this == null) {
      return EdgeInsets.only(left: left ?? 0.0, top: top ?? 0.0, right: right ?? 0.0, bottom: bottom ?? 0.0);
    }

    final resolved = this!.resolve(direction);
    return EdgeInsets.only(
      left: left ?? resolved.left,
      top: top ?? resolved.top,
      right: right ?? resolved.right,
      bottom: bottom ?? resolved.bottom,
    );
  }
}

/// Extensions specific to non-nullable [EdgeInsets].
extension EdgeInsetsBoostExtensions on EdgeInsets {
  /// Alias for `copyWith` for better discoverability on concrete EdgeInsets.
  EdgeInsets copyWithEdgeInsets({double? left, double? top, double? right, double? bottom}) {
    return copyWith(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  /// Creates a new EdgeInsets with only the horizontal (left, right) values preserved.
  EdgeInsets get horizontalOnly => EdgeInsets.symmetric(horizontal: horizontal);

  /// Creates a new EdgeInsets with only the vertical (top, bottom) values preserved.
  EdgeInsets get verticalOnly => EdgeInsets.symmetric(vertical: vertical);
}
