import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Extensions for [State] objects to provide common helper methods.
extension StateBoostExtensions<T extends StatefulWidget> on State<T> {
  /// Safely calls `setState` only if the widget is still mounted.
  /// Prevents the common "setState() called after dispose()" error.
  ///
  /// Example:
  /// ```dart
  /// Future<void> fetchData() async {
  ///   final data = await myApi.getData();
  ///   safeSetState(() {
  ///     _data = data;
  ///     _isLoading = false;
  ///   });
  /// }
  /// ```
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }

  /// Executes a callback after the current frame is rendered.
  /// Useful for performing actions after the layout phase.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   addPostFrameCallback((_) {
  ///     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  ///   });
  /// }
  /// ```
  void addPostFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback(callback);
  }
}
