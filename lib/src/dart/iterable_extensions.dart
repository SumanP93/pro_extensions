import 'dart:math';

/// Extensions for general [Iterable] and nullable [Iterable?].
/// These apply to Lists, Sets, etc.
extension IterableBoostExtensions<T> on Iterable<T>? {
  // --- Null/Empty Checks ---

  /// Returns `true` if the iterable is either null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the iterable is not null and not empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns the iterable itself if it's not null, otherwise returns an empty list.
  /// Useful for safe iteration.
  Iterable<T> orEmpty() => this ?? const [];

  // --- Element Access ---

  /// Returns the first element matching the [test] predicate, or `null` if no element is found or the iterable is null/empty.
  T? firstWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) return null;
    for (final element in this!) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Returns the last element matching the [test] predicate, or `null` if no element is found or the iterable is null/empty.
  T? lastWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) return null;
    T? result;
    for (final element in this!) {
      if (test(element)) {
        result = element;
      }
    }
    return result;
  }

  /// Returns a random element from the iterable, or `null` if the iterable is null or empty.
  /// Uses the provided [random] generator or `Random()` by default.
  /// Note: This requires iterating potentially the whole list if it's not a List.
  /// For performance on large non-List iterables, consider converting to List first if feasible.
  T? randomElement([Random? random]) {
    if (isNullOrEmpty) return null;
    final list = this!.toList(); // Efficient access by index requires a List
    if (list.isEmpty) return null;
    final effectiveRandom = random ?? Random();
    return list[effectiveRandom.nextInt(list.length)];
  }

  // --- Transformations & Filtering ---

  /// Groups the elements of the iterable into chunks of the specified [size].
  /// The last chunk may be smaller if the total number of elements is not a multiple of [size].
  /// Returns an empty iterable if the input is null or empty, or if size <= 0.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].chunked(2) // -> [[1, 2], [3, 4], [5]]
  /// ```
  Iterable<List<T>> chunked(int size) {
    if (isNullOrEmpty || size <= 0) return const [];
    // Use a generator for lazy evaluation if needed, or build the list directly
    final source = this!;
    final result = <List<T>>[];
    var chunk = <T>[];
    for (final element in source) {
      chunk.add(element);
      if (chunk.length == size) {
        result.add(chunk);
        chunk = <T>[];
      }
    }
    if (chunk.isNotEmpty) {
      result.add(chunk);
    }
    return result;
  }

  /// Returns a new list containing only the distinct elements from the iterable
  /// based on the key computed by the [keySelector] function.
  /// Preserves the order of the first occurrence of each key.
  ///
  /// Example:
  /// ```dart
  /// class User { String name; int id; }
  /// final users = [User('Alice', 1), User('Bob', 2), User('Alice', 3)];
  /// final distinctById = users.distinctBy((user) => user.id); // -> [User('Alice', 1), User('Bob', 2)]
  /// final distinctByName = users.distinctBy((user) => user.name); // -> [User('Alice', 1), User('Bob', 2)]
  /// ```
  List<T> distinctBy<K>(K Function(T element) keySelector) {
    if (isNullOrEmpty) return [];
    final source = this!;
    final seenKeys = <K>{};
    final distinctList = <T>[];
    for (final element in source) {
      final key = keySelector(element);
      if (seenKeys.add(key)) {
        // Set.add returns true if the value was not already present
        distinctList.add(element);
      }
    }
    return distinctList;
  }

  /// Maps the iterable to a new list, transforming each element using [transform].
  /// Null elements returned by the [transform] function are excluded from the result list.
  /// Returns an empty list if the source iterable is null or empty.
  ///
  /// Example:
  /// ```dart
  /// ['1', 'two', '3', null, '4'].mapNotNull((s) => int.tryParse(s ?? '')) // -> [1, 3, 4]
  /// ```
  List<R> mapNotNull<R>(R? Function(T element) transform) {
    if (isNullOrEmpty) return [];
    final result = <R>[];
    for (final element in this!) {
      final transformed = transform(element);
      if (transformed != null) {
        result.add(transformed);
      }
    }
    return result;
  }

  /// Returns a new list containing only the non-null elements of the original iterable.
  /// This is useful when the iterable itself might contain nulls.
  ///
  /// Example:
  /// ```dart
  /// [1, null, 3, null, 5].whereNotNull() // -> [1, 3, 5]
  /// ```
  List<T> whereNotNull() {
    if (isNullOrEmpty) return [];
    return this!.where((element) => element != null).toList();
  }

  // --- Aggregation ---

  /// Calculates the sum of values returned by the [selector] function for each element.
  /// Returns 0.0 if the iterable is null or empty.
  double sumBy(num Function(T element) selector) {
    if (isNullOrEmpty) return 0.0;
    double sum = 0.0;
    for (final element in this!) {
      sum += selector(element);
    }
    return sum;
  }

  /// Calculates the average of values returned by the [selector] function for each element.
  /// Returns `null` if the iterable is null or empty to avoid division by zero.
  double? averageBy(num Function(T element) selector) {
    if (isNullOrEmpty) return null;
    double sum = 0.0;
    int count = 0;
    for (final element in this!) {
      sum += selector(element);
      count++;
    }
    return count == 0 ? null : sum / count;
  }

  // --- String Conversion ---

  /// Joins the string representations of elements with the given [separator].
  /// Handles null elements by converting them to the [nullRepresentation] string (default: 'null').
  /// Uses `toString()` on each non-null element.
  ///
  /// Example:
  /// ```dart
  /// [1, null, 'hello'].joinToString(separator: ' | ', nullRepresentation: 'N/A') // -> "1 | N/A | hello"
  /// ```
  String joinToString({String separator = ', ', String nullRepresentation = 'null'}) {
    if (isNullOrEmpty) return '';
    return this!.map((e) => e == null ? nullRepresentation : e.toString()).join(separator);
  }

  // --- Subsetting ---

  /// Returns an iterable containing elements from the original iterable except the first [count] elements.
  /// If [count] is greater than the number of elements, an empty iterable is returned.
  /// Returns an empty iterable if the source is null.
  Iterable<T> drop(int count) {
    if (isNullOrEmpty || count <= 0) return this.orEmpty();
    return this!.skip(count);
  }

  /// Returns an iterable containing elements from the original iterable except the last [count] elements.
  /// If [count] is greater than the number of elements, an empty iterable is returned.
  /// Returns an empty iterable if the source is null.
  Iterable<T> dropLast(int count) {
    if (isNullOrEmpty || count <= 0) return this.orEmpty();
    // Efficiently calculates take count without creating intermediate list if length is known
    if (this is List<T>) {
      final list = this as List<T>;
      final length = list.length;
      final takeCount = length - count;
      return list.take(takeCount < 0 ? 0 : takeCount);
    } else {
      // Less efficient for general iterables: convert to list first
      final sourceList = this!.toList();
      final length = sourceList.length;
      final takeCount = length - count;
      return sourceList.take(takeCount < 0 ? 0 : takeCount);
    }
  }
}
