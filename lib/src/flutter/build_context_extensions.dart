import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

/// Extensions for [BuildContext] to easily access common properties and functionalities.
extension BuildContextBoostExtensions on BuildContext {
  // --- Theme Access ---

  /// Returns the current [ThemeData]. Shortcut for `Theme.of(this)`.
  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme]. Shortcut for `Theme.of(this).textTheme`.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the current [ColorScheme]. Shortcut for `Theme.of(this).colorScheme`.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns `true` if the current theme's brightness is [Brightness.dark].
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // --- MediaQuery Access ---

  /// Returns the current [MediaQueryData]. Shortcut for `MediaQuery.of(this)`.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the screen size. Shortcut for `MediaQuery.of(this).size`.
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns the screen width. Shortcut for `MediaQuery.of(this).size.width`.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height. Shortcut for `MediaQuery.of(this).size.height`.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the screen orientation. Shortcut for `MediaQuery.of(this).orientation`.
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// Returns the device pixel ratio. Shortcut for `MediaQuery.of(this).devicePixelRatio`.
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Returns the top padding (usually status bar height). Shortcut for `MediaQuery.of(this).padding.top`.
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;

  /// Returns the bottom padding (usually navigation bar height). Shortcut for `MediaQuery.of(this).padding.bottom`.
  double get viewPaddingBottom => MediaQuery.of(this).viewPadding.bottom;

  /// Returns the bottom view inset (usually keyboard height). Shortcut for `MediaQuery.of(this).viewInsets.bottom`.
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;

  /// Returns `true` if the keyboard is currently visible.
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  // --- Navigator Access ---

  /// Returns the nearest [NavigatorState]. Shortcut for `Navigator.of(this)`.
  NavigatorState get navigator => Navigator.of(this);

  /// Pushes a new [route] onto the navigator stack.
  Future<T?> push<T extends Object?>(Route<T> route) => Navigator.of(this).push(route);

  /// Pushes a named route onto the navigator stack.
  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  /// Replaces the current route with a new named route.
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) => Navigator.of(this).pushReplacementNamed<T, TO>(routeName, result: result, arguments: arguments);

  /// Pushes a named route and removes all previous routes until the [predicate] returns true.
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) => Navigator.of(this).pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);

  /// Pops the current route off the navigator stack.
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);

  /// Returns `true` if the navigator can be popped.
  bool canPop() => Navigator.of(this).canPop();

  /// Pops routes until the predicate returns true.
  void popUntil(RoutePredicate predicate) => Navigator.of(this).popUntil(predicate);

  // --- ScaffoldMessenger Access ---

  /// Returns the nearest [ScaffoldMessengerState]. Shortcut for `ScaffoldMessenger.of(this)`.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Shows a [SnackBar]. Automatically hides the current one if visible.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(SnackBar snackBar) {
    scaffoldMessenger.hideCurrentSnackBar();
    return scaffoldMessenger.showSnackBar(snackBar);
  }

  /// Shows a simple text SnackBar.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showTextSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return showSnackBar(
      SnackBar(
        content: Text(message, style: textStyle),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating, // Often preferred
      ),
    );
  }

  /// Hides the current [SnackBar].
  void hideCurrentSnackBar() => scaffoldMessenger.hideCurrentSnackBar();

  /// Removes the current [SnackBar].
  void removeCurrentSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.remove}) =>
      scaffoldMessenger.removeCurrentSnackBar(reason: reason);

  // --- Focus Management ---

  /// Returns the nearest [FocusScopeNode]. Shortcut for `FocusScope.of(this)`.
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Requests focus for the primary focus node in the current scope.
  void requestFocus([FocusNode? node]) => FocusScope.of(this).requestFocus(node);

  /// Unfocuses the current node, usually hiding the keyboard.
  void unfocus({UnfocusDisposition disposition = UnfocusDisposition.previouslyFocusedChild}) =>
      FocusScope.of(this).unfocus(disposition: disposition);

  // --- Platform & Locale ---

  /// Returns the current [Locale]. Shortcut for `Localizations.localeOf(this)`.
  Locale get currentLocale => Localizations.localeOf(this);

  /// Returns the target platform. Shortcut for `Theme.of(this).platform`.
  TargetPlatform get platform => Theme.of(this).platform;

  /// Returns `true` if the target platform is [TargetPlatform.android].
  bool get isAndroid => platform == TargetPlatform.android;

  /// Returns `true` if the target platform is [TargetPlatform.iOS].
  bool get isIOS => platform == TargetPlatform.iOS;

  /// Returns `true` if the target platform is [TargetPlatform.windows].
  bool get isWindows => platform == TargetPlatform.windows;

  /// Returns `true` if the target platform is [TargetPlatform.macOS].
  bool get isMacOS => platform == TargetPlatform.macOS;

  /// Returns `true` if the target platform is [TargetPlatform.linux].
  bool get isLinux => platform == TargetPlatform.linux;

  /// Returns `true` if the target platform is Fuchsia.
  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  /// Returns `true` if the app is running on a mobile device (Android or iOS).
  /// Uses `Platform` from `dart:io` for more accuracy if available.
  bool get isMobile {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (_) {
      // dart:io not available on web
      return isAndroid || isIOS;
    }
  }

  /// Returns `true` if the app is running on a desktop device (Windows, macOS, Linux).
  /// Uses `Platform` from `dart:io` for more accuracy if available.
  bool get isDesktop {
    try {
      return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
    } catch (_) {
      // dart:io not available on web
      return isWindows || isMacOS || isLinux;
    }
  }

  /// Returns `true` if the app is running on the web (using kIsWeb).
  bool get isWeb => kIsWeb; // kIsWeb from foundation.dart

  // --- Dialogs ---

  /// Shows a Material dialog.
  Future<T?> showAppDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return showDialog<T>(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  /// Shows a Cupertino dialog.
  Future<T?> showAppCupertinoDialog<T>({
    required WidgetBuilder builder,
    String? barrierLabel, // Use default label
    bool useRootNavigator = true,
    bool barrierDismissible = false, // Cupertino default
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return showCupertinoDialog<T>(
      context: this,
      builder: builder,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  /// Shows a modal bottom sheet.
  Future<T?> showAppModalBottomSheet<T>({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    bool useSafeArea = false, // New in Flutter 3.7+
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
    );
  }
}
