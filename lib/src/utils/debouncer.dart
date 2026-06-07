import 'dart:async';

/// A utility class for debouncing operations.
///
/// Debouncing ensures that a function is only called after a specified
/// delay has passed without any new calls being made.
/// This is useful for search inputs and other scenarios where you want to
/// limit the rate of function calls.
///
/// Example:
/// ```dart
/// Debouncer.debounce(() {
///   print('User finished typing');
/// }, delay: 500);
/// ```
class Debouncer {
  static Timer? _timer;

  // Private constructor to prevent direct instantiation
  Debouncer._(); // default delay is 300ms

  /// delay default 300 miliseconds
  static void debounce(Function callback, {int delay = 300}) {
    if (_timer != null) {
      _dispose();
    }

    _timer = Timer(Duration(milliseconds: delay), () {
      callback();
    });
  }

  static void _dispose() {
    _timer?.cancel();
  }
}
