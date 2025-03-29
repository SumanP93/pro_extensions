import 'dart:convert';
import 'dart:math';

import 'iterable_extensions.dart';
import 'string_extensions.dart';
import 'int_extensions.dart';
import '../utils/_reading_time.dart';

/// Extensions specific to non-nullable [List<T>].
extension ListBoostExtensions<T> on List<T> {
  // Note: Applies only to non-nullable lists

  /// Returns the element at the specified [index] or `null` if the index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final list = [10, 20, 30];
  /// list.getOrNull(1) // -> 20
  /// list.getOrNull(3) // -> null
  /// list.getOrNull(-1) // -> null
  /// ```
  T? getOrNull(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }

  /// Shuffles the elements of this list randomly in place.
  /// Uses the provided [random] generator or `Random()` by default.
  void shuffle([Random? random]) {
    final effectiveRandom = random ?? Random();
    for (int i = length - 1; i > 0; i--) {
      int j = effectiveRandom.nextInt(i + 1);
      T temp = this[i];
      this[i] = this[j];
      this[j] = temp;
    }
  }

  /// Returns a new list containing the elements of this list in shuffled order.
  /// The original list is not modified.
  /// Uses the provided [random] generator or `Random()` by default.
  List<T> shuffled([Random? random]) {
    final newList = List<T>.from(this);
    newList.shuffle(random);
    return newList;
  }

  /// Returns a new list containing a random sample of [size] elements from this list.
  /// If [size] is greater than or equal to the list length, a shuffled copy of the list is returned.
  /// Throws [ArgumentError] if size is negative.
  /// Uses the provided [random] generator or `Random()` by default.
  List<T> sample(int size, [Random? random]) {
    if (size < 0) throw ArgumentError.value(size, 'size', 'cannot be negative');
    if (size == 0) return [];
    if (size >= length) return shuffled(random);

    final effectiveRandom = random ?? Random();
    final List<T> sampleList = [];
    final List<int> indices = List<int>.generate(length, (i) => i);
    for (int i = 0; i < size; i++) {
      final randomIndex = effectiveRandom.nextInt(indices.length);
      sampleList.add(this[indices.removeAt(randomIndex)]);
    }
    return sampleList;
  }

  /// Adds the [element] to the list if the [condition] is true.
  /// Returns `true` if the element was added, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2];
  /// bool shouldAdd = true;
  /// numbers.addIf(shouldAdd, 3); // numbers is now [1, 2, 3]
  /// ```
  bool addIf(bool condition, T element) {
    if (condition) {
      add(element);
      return true;
    }
    return false;
  }

  /// Adds the [element] to the list only if [element] is not null.
  /// This is particularly useful when dealing with nullable types in list construction.
  /// Returns `true` if the element was added, `false` otherwise.
  ///
  /// Note: This method requires the list element type `T` to potentially accept null,
  /// or the [element] argument should be cast appropriately if `T` is non-nullable.
  /// A common use case is `List<Widget?>` or `List<String?>`.
  /// For strictly non-nullable lists `List<Widget>`, use `addIf(element != null, element)`.
  ///
  /// Example (with List<int?>):
  /// ```dart
  /// final nullableNumbers = <int?>[1, null];
  /// int? newValue = 3;
  /// nullableNumbers.addIfNotNull(newValue); // nullableNumbers is now [1, null, 3]
  /// int? nullValue = null;
  /// nullableNumbers.addIfNotNull(nullValue); // nullableNumbers remains [1, null, 3]
  /// ```
  bool addIfNotNull(T element) {
    if (element != null) {
      add(element);
      return true;
    }
    return false;
  }

  /// Swaps the elements at the specified indices [index1] and [index2].
  /// Throws [RangeError] if either index is out of bounds.
  void swap(int index1, int index2) {
    // RangeError check is implicitly done by accessing the elements
    final T temp = this[index1];
    this[index1] = this[index2];
    this[index2] = temp;
  }
}

/// Extensions specific to `List<String>` and nullable `List<String>?`.
extension ListStringBoostExtensions on List<String>? {
  /// Estimates the total reading time for all strings in the list combined.
  ///
  /// Assumes an average reading speed provided by [wordsPerMinute] (default is 225).
  /// Calculates based on the total word count across all non-blank strings.
  /// Returns [Duration.zero] if the list is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final paragraphs = ["Hello world.", "Another sentence here."];
  /// final readTime = paragraphs.readingTime(); // ~2 seconds if WPM is 225
  /// ```
  String readingTime({int wordsPerMinute = 225}) {
    if (isNullOrEmpty) return "0 min";
    assert(wordsPerMinute > 0, 'wordsPerMinute must be positive.');

    int totalWordCount = 0;
    for (final str in this!) {
      // Reuse the logic from String extension
      if (str.isNotNullOrBlank) {
        final wordList = str.split(RegExp(r'\s+')).where((s) => s.isNotEmpty);
        totalWordCount += wordList.length;
      }
    }

    if (totalWordCount == 0) return "0 min";

    final minutes = totalWordCount / wordsPerMinute;

    return readingTimeFromMinutes(minutes);
  }

  /// Calculates the total byte size of all strings in the list when encoded
  /// using the specified [encoding].
  ///
  /// Defaults to UTF-8 encoding. Skips null or empty strings in the list.
  /// Returns 0 if the list is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final lines = ["abc", "你好"];
  /// final utf8Size = lines.totalByteSize(); // 3 + 6 = 9 bytes in UTF-8
  /// final latin1Size = lines.totalByteSize(encoding: latin1); // 3 + 2 = 5 bytes in Latin-1
  /// ```
  int totalByteSize({Encoding encoding = utf8}) {
    if (isNullOrEmpty) return 0;

    int totalSize = 0;
    for (final str in this!) {
      // Reuse the String extension's logic for consistency
      totalSize += str.byteSize(encoding: encoding); // String extension handles null/empty str
    }
    return totalSize;
  }

  int totalLength() {
    if (isNullOrEmpty) return 0;
    return this!.fold(0, (prev, line) => prev + line.length);
  }

  String get formatedSize => totalByteSize().formatedSize;

  String get formatedSizeV2 => totalLength().formatedSize;
}
