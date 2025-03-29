import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Extensions for any [Widget] to easily wrap it with common layout widgets.
extension WidgetBoostExtensions on Widget {
  // --- Padding & Margin ---

  /// Wraps the widget with uniform padding.
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  /// Wraps the widget with symmetric padding (horizontal and vertical).
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  /// Wraps the widget with padding only on specified sides.
  Widget paddingOnly({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) =>
      Padding(padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom), child: this);

  /// Wraps the widget with [EdgeInsetsGeometry].
  Widget padding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);

  /// Wraps the widget in a [Container] with uniform margin.
  /// Note: Prefer `Padding` for space *inside* a conceptual boundary,
  /// and `Container` with `margin` for space *outside*.
  Widget marginAll(double value) => Container(margin: EdgeInsets.all(value), child: this);

  /// Wraps the widget in a [Container] with symmetric margin.
  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  /// Wraps the widget in a [Container] with margin only on specified sides.
  Widget marginOnly({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) =>
      Container(margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom), child: this);

  /// Wraps the widget in a [Container] with [EdgeInsetsGeometry] margin.
  Widget margin(EdgeInsetsGeometry margin) => Container(margin: margin, child: this);

  // --- Alignment & Positioning ---

  /// Wraps the widget in a [Center].
  Widget center({Key? key, double? widthFactor, double? heightFactor}) =>
      Center(key: key, widthFactor: widthFactor, heightFactor: heightFactor, child: this);

  /// Wraps the widget in an [Align].
  Widget align(AlignmentGeometry alignment, {Key? key, double? widthFactor, double? heightFactor}) =>
      Align(key: key, alignment: alignment, widthFactor: widthFactor, heightFactor: heightFactor, child: this);

  /// Wraps the widget in an [Align] with `Alignment.centerLeft`.
  Widget alignCenterLeft({Key? key}) => Align(key: key, alignment: Alignment.centerLeft, child: this);

  /// Wraps the widget in an [Align] with `Alignment.centerRight`.
  Widget alignCenterRight({Key? key}) => Align(key: key, alignment: Alignment.centerRight, child: this);

  /// Wraps the widget in an [Align] with `Alignment.topCenter`.
  Widget alignTopCenter({Key? key}) => Align(key: key, alignment: Alignment.topCenter, child: this);

  /// Wraps the widget in an [Align] with `Alignment.bottomCenter`.
  Widget alignBottomCenter({Key? key}) => Align(key: key, alignment: Alignment.bottomCenter, child: this);
  // Add more common alignments as needed...

  /// Wraps the widget in a [Positioned] widget (only useful within a [Stack]).
  Widget positioned({
    Key? key,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned(
    key: key,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: this,
  );

  /// Wraps the widget in a [Positioned.fill] widget (only useful within a [Stack]).
  Widget positionedFill({Key? key, double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) =>
      Positioned.fill(key: key, left: left, top: top, right: right, bottom: bottom, child: this);

  // --- Sizing & Constraints ---

  /// Wraps the widget in a [SizedBox].
  Widget sizedBox({Key? key, double? width, double? height}) =>
      SizedBox(key: key, width: width, height: height, child: this);

  /// Wraps the widget in a [ConstrainedBox].
  Widget constrainedBox(BoxConstraints constraints, {Key? key}) =>
      ConstrainedBox(key: key, constraints: constraints, child: this);

  /// Wraps the widget in a [LimitedBox].
  Widget limitedBox({Key? key, double maxWidth = double.infinity, double maxHeight = double.infinity}) =>
      LimitedBox(key: key, maxWidth: maxWidth, maxHeight: maxHeight, child: this);

  /// Wraps the widget in an [AspectRatio].
  Widget aspectRatio(double aspectRatio, {Key? key}) => AspectRatio(key: key, aspectRatio: aspectRatio, child: this);

  /// Wraps the widget in a [FittedBox].
  Widget fittedBox({
    Key? key,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    Clip clipBehavior = Clip.hardEdge,
  }) => FittedBox(key: key, fit: fit, alignment: alignment, clipBehavior: clipBehavior, child: this);

  // --- Flex Layout ---

  /// Wraps the widget in an [Expanded].
  Widget expanded({Key? key, int flex = 1}) => Expanded(key: key, flex: flex, child: this);

  /// Wraps the widget in a [Flexible].
  Widget flexible({Key? key, int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(key: key, flex: flex, fit: fit, child: this);

  // --- Visibility & Stacking ---

  /// Wraps the widget in an [Offstage].
  Widget offstage({Key? key, bool offstage = true}) => Offstage(key: key, offstage: offstage, child: this);

  /// Wraps the widget in a [Visibility].
  Widget visible({
    Key? key,
    bool visible = true,
    Widget replacement = const SizedBox.shrink(),
    bool maintainState = false,
    bool maintainAnimation = false,
    bool maintainSize = false,
    bool maintainSemantics = false,
    bool maintainInteractivity = false,
  }) => Visibility(
    key: key,
    visible: visible,
    replacement: replacement,
    maintainState: maintainState,
    maintainAnimation: maintainAnimation,
    maintainSize: maintainSize,
    maintainSemantics: maintainSemantics,
    maintainInteractivity: maintainInteractivity,
    child: this,
  );

  // --- Gestures ---

  /// Wraps the widget in a [GestureDetector] for tap events.
  Widget onTap(GestureTapCallback? onTap, {Key? key, HitTestBehavior? behavior}) =>
      GestureDetector(key: key, onTap: onTap, behavior: behavior, child: this);

  /// Wraps the widget in a [GestureDetector] for double-tap events.
  Widget onDoubleTap(GestureTapCallback? onDoubleTap, {Key? key, HitTestBehavior? behavior}) =>
      GestureDetector(key: key, onDoubleTap: onDoubleTap, behavior: behavior, child: this);

  /// Wraps the widget in a [GestureDetector] for long-press events.
  Widget onLongPress(GestureLongPressCallback? onLongPress, {Key? key, HitTestBehavior? behavior}) =>
      GestureDetector(key: key, onLongPress: onLongPress, behavior: behavior, child: this);

  /// Wraps the widget in a general [GestureDetector].
  Widget gesture({
    Key? key,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCallback? onTap,
    GestureTapCancelCallback? onTapCancel,
    GestureTapCallback? onSecondaryTap,
    GestureTapDownCallback? onSecondaryTapDown,
    GestureTapUpCallback? onSecondaryTapUp,
    GestureTapCancelCallback? onSecondaryTapCancel,
    GestureTapDownCallback? onTertiaryTapDown,
    GestureTapUpCallback? onTertiaryTapUp,
    GestureTapCancelCallback? onTertiaryTapCancel,
    GestureDoubleTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    // ... add other gesture callbacks as needed ...
    HitTestBehavior? behavior,
  }) => GestureDetector(
    key: key,
    onTapDown: onTapDown,
    onTapUp: onTapUp,
    onTap: onTap,
    onTapCancel: onTapCancel,
    onSecondaryTap: onSecondaryTap,
    onSecondaryTapDown: onSecondaryTapDown,
    onSecondaryTapUp: onSecondaryTapUp,
    onSecondaryTapCancel: onSecondaryTapCancel,
    onTertiaryTapDown: onTertiaryTapDown,
    onTertiaryTapUp: onTertiaryTapUp,
    onTertiaryTapCancel: onTertiaryTapCancel,
    onDoubleTap: onDoubleTap,
    onLongPress: onLongPress,
    behavior: behavior,
    child: this,
  );

  // --- Effects & Styling ---

  /// Wraps the widget in an [Opacity] widget.
  Widget opacity(double opacity, {Key? key, bool alwaysIncludeSemantics = false}) =>
      Opacity(key: key, opacity: opacity, alwaysIncludeSemantics: alwaysIncludeSemantics, child: this);

  /// Wraps the widget in a [DecoratedBox].
  Widget decoratedBox(Decoration decoration, {Key? key, DecorationPosition position = DecorationPosition.background}) =>
      DecoratedBox(key: key, decoration: decoration, position: position, child: this);

  /// Wraps the widget in a [RotatedBox].
  Widget rotatedBox(int quarterTurns, {Key? key}) => RotatedBox(key: key, quarterTurns: quarterTurns, child: this);

  /// Wraps the widget in a [Transform.scale].
  Widget scale(
    double scale, {
    Key? key,
    Offset? origin,
    AlignmentGeometry alignment = Alignment.center,
    bool transformHitTests = true,
  }) => Transform.scale(
    key: key,
    scale: scale,
    origin: origin,
    alignment: alignment,
    transformHitTests: transformHitTests,
    child: this,
  );

  /// Wraps the widget in a [Transform.translate].
  Widget translate(Offset offset, {Key? key, bool transformHitTests = true}) =>
      Transform.translate(key: key, offset: offset, transformHitTests: transformHitTests, child: this);

  /// Wraps the widget in a [ClipRRect].
  Widget clipRRect(
    BorderRadius borderRadius, {
    Key? key,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) => ClipRRect(key: key, borderRadius: borderRadius, clipper: clipper, clipBehavior: clipBehavior, child: this);

  /// Wraps the widget in a [ClipOval].
  Widget clipOval({Key? key, CustomClipper<Rect>? clipper, Clip clipBehavior = Clip.antiAlias}) =>
      ClipOval(key: key, clipper: clipper, clipBehavior: clipBehavior, child: this);

  /// Wraps the widget in a [Tooltip].
  Widget tooltip(String message, {Key? key /* Add other Tooltip params as needed */}) =>
      Tooltip(key: key, message: message, child: this);

  /// Wraps the widget in a [SafeArea].
  Widget safeArea({
    Key? key,
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) => SafeArea(
    key: key,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    minimum: minimum,
    maintainBottomViewPadding: maintainBottomViewPadding,
    child: this,
  );

  // --- Scrolling ---
  /// Wraps the widget in a [SingleChildScrollView].
  Widget scrollable({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsetsGeometry? padding,
    bool? primary,
    ScrollPhysics? physics,
    ScrollController? controller,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Clip clipBehavior = Clip.hardEdge,
    String? restorationId,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) {
    return SingleChildScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      padding: padding,
      primary: primary,
      physics: physics,
      controller: controller,
      // child is required, assigned below
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
      child: this,
    );
  }
}
