import 'dart:async';

class Debouncer {
  static Timer? _timer;

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
