import 'dart:async';
import 'package:flutter/foundation.dart'; // for kDebugMode

/// Extensions for [Future<T>].
extension FutureBoostExtensions<T> on Future<T> {
  /// Attaches loading indicator callbacks.
  /// Executes [onStart] before the future begins and [onEnd] when it completes (successfully or with an error).
  /// Returns a new Future that completes with the original Future's result or error.
  /// Useful for managing loading states in UI.
  ///
  /// Example:
  /// ```dart
  /// void setLoading(bool loading) { ... }
  ///
  /// await fetchUserData()
  ///   .withLoading(
  ///     onStart: () => setLoading(true),
  ///     onEnd: () => setLoading(false),
  ///   )
  ///   .then((user) => displayUser(user))
  ///   .catchError((e) => showError(e));
  /// ```
  Future<T> withLoading({VoidCallback? onStart, VoidCallback? onEnd}) {
    onStart?.call();
    // Ensure onEnd is always called, regardless of success or error
    return whenComplete(() => onEnd?.call());
    // Alternative using finally (more explicit):
    // try {
    //   onStart?.call();
    //   return await this;
    // } finally {
    //   onEnd?.call();
    // }
  }

  /// Returns a new Future that completes with the result of this future,
  /// but returns [defaultValue] if this future completes with an error.
  ///
  /// Example:
  /// ```dart
  /// int count = await fetchCount().onErrorReturn(0);
  /// ```
  Future<T> onErrorReturn(T defaultValue) {
    return catchError((Object error, StackTrace stackTrace) {
      // Optionally log the error here
      // print("Future completed with error, returning default value. Error: $error");
      return defaultValue;
    });
  }

  /// Returns a new Future that completes with the result of this future,
  /// but returns `null` if this future completes with an error.
  /// The future's type must be nullable (`Future<T?>`).
  ///
  /// Example:
  /// ```dart
  /// User? user = await fetchOptionalUser().onErrorReturnNull();
  /// if (user != null) { ... }
  /// ```
  Future<T?> onErrorReturnNull() {
    // Requires explicit nullable type T?
    // Ensure the extension is called on a Future<T?> or cast the result
    // This implementation assumes 'this' is Future<T> where T might be nullable.
    return catchError((Object error, StackTrace stackTrace) {
      // Optionally log the error
      return null;
    }).then((value) => value as T?); // Ensure correct return type
  }

  /// Returns a new Future that completes with the result of this future,
  /// but completes with `null` if it doesn't complete within the given [timeLimit]
  /// or if the original future completes with an error.
  /// The resulting future's type is explicitly nullable (`Future<T?>`).
  ///
  /// Example:
  /// ```dart
  /// // Wait max 5 seconds for data, otherwise proceed with null
  /// Data? data = await fetchData().timeoutOrNull(5.seconds);
  /// if (data == null) {
  ///   print("Operation timed out or failed.");
  /// }
  /// ```
  Future<T?> timeoutOrNull(Duration timeLimit) {
    return timeout(timeLimit) // Allow timeout() to throw TimeoutException
    .then<T?>(
      (value) => value, // Successfully completed, ensure type is T?
      onError: (Object error, StackTrace stackTrace) {
        // Catch errors from the original future OR TimeoutException from timeout()
        if (error is TimeoutException) {
          // If it specifically timed out
          return null;
        } else {
          // If the original future had a different error
          // Optionally log the error:
          // if (kDebugMode) {
          //   print('Future failed within timeoutOrNull: $error\n$stackTrace');
          // }
          return null; // Return null for any error as per method's goal
        }
      },
    );
  }

  /// Returns a new Future that completes with the result of this future,
  /// but completes with [defaultValue] if it doesn't complete within the given [timeLimit].
  ///
  /// Example:
  /// ```dart
  /// // Wait max 2 seconds for config, otherwise use default
  /// Config config = await loadConfig().timeoutOrDefault(2.seconds, defaultValue: defaultConfig);
  /// ```
  Future<T> timeoutOrDefault(Duration timeLimit, {required T defaultValue}) {
    return timeout(
      timeLimit,
      onTimeout: () => defaultValue, // Return default on timeout
    ).onErrorReturn(defaultValue); // Also return default on error
  }

  /// Delays the completion of the future by the specified [duration].
  /// The value or error from the original future is preserved.
  ///
  /// Example:
  /// ```dart
  /// await processData()
  ///      .delay(500.milliseconds) // Wait 500ms *after* processing finishes
  ///      .then((result) => print('Delayed result: $result'));
  /// ```
  Future<T> delay(Duration duration) async {
    // Wait for the original future first
    final T result = await this; // Or error propagates here
    // Then wait for the delay
    await Future.delayed(duration);
    // Return the original result
    return result;
  }

  /// Prints the result or error of the Future to the console, only in debug mode.
  /// Returns the original future for chaining.
  /// Includes an optional [prefix].
  ///
  /// Example:
  /// ```dart
  /// await apiCall()
  ///   .debugPrint("API Result:")
  ///   .then(...)
  /// ```
  Future<T> debugPrint([String prefix = 'DEBUG Future']) {
    if (kDebugMode) {
      return then((value) {
        debugPrint('$prefix: Success -> $value');
        return value; // Return the original value
      }).catchError((error, stackTrace) {
        debugPrint('$prefix: Error -> $error\n$stackTrace');
        // Rethrow the original error to maintain the error chain
        // Use `Future.error` to preserve the original stack trace
        return Future<T>.error(error, stackTrace);
      });
    } else {
      // If not in debug mode, just return the original future
      return this;
    }
  }
}
