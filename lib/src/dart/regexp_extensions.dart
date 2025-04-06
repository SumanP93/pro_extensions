import 'dart:core';

/// Extensions for the [RegExp] class to simplify common operations.
extension RegExpBoostExtensions on RegExp {
  /// Checks if the entire [input] string matches this regular expression
  /// from start to end.
  ///
  /// This is different from [hasMatch], which returns true if the pattern
  /// is found *anywhere* within the string. This method requires the
  /// pattern to consume the whole string.
  ///
  /// Example:
  /// ```dart
  /// final numberRegex = RegExp(r'^\d+$'); // Pattern anchored start-to-end
  /// numberRegex.matchesEntireString('123') // -> true
  /// numberRegex.matchesEntireString('123a') // -> false
  ///
  /// final wordRegex = RegExp(r'hello'); // Unanchored pattern
  /// wordRegex.matchesEntireString('hello') // -> true (implicit anchoring applied)
  /// wordRegex.matchesEntireString('hello world') // -> false
  /// wordRegex.hasMatch('hello world') // -> true
  /// ```
  bool matchesEntireString(String input) {
    final match = matchAsPrefix(input);
    return match != null && match.end == input.length;
    // Alternative: Use a modified pattern, but matchAsPrefix is often cleaner
    // return RegExp('^${this.pattern}\$', multiLine: this.isMultiLine, caseSensitive: this.isCaseSensitive, unicode: this.isUnicode, dotAll: this.isDotAll).hasMatch(input);
  }

  /// Returns the first matched string (`group(0)`) in the [input].
  /// Returns `null` if no match is found.
  ///
  /// Example:
  /// ```dart
  /// final numberRegex = RegExp(r'\d+');
  /// numberRegex.firstMatchValue('abc 123 def 456') // -> '123'
  /// numberRegex.firstMatchValue('abc def') // -> null
  /// ```
  String? firstMatchValue(String input) {
    final match = firstMatch(input);
    return match?.group(0);
  }

  /// Returns an iterable sequence of all matched strings (`group(0)`)
  /// found in the [input]. Returns an empty iterable if no matches are found.
  ///
  /// Example:
  /// ```dart
  /// final numberRegex = RegExp(r'\d+');
  /// numberRegex.allMatchesValues('abc 123 def 456').toList() // -> ['123', '456']
  /// numberRegex.allMatchesValues('abc def').toList() // -> []
  /// ```
  Iterable<String> allMatchesValues(String input) {
    return allMatches(input).map((match) => match.group(0)!); // group(0) is never null if match exists
  }

  /// Returns an iterable sequence of the captured strings for a specific [groupIndex]
  /// across all matches found in the [input].
  /// Returns `null` for a specific match if that match doesn't have the specified group.
  /// Returns an empty iterable if no matches are found.
  ///
  /// Throws [RangeError] if [groupIndex] is negative or greater than `groupCount`.
  ///
  /// Example:
  /// ```dart
  /// final keyValueRegex = RegExp(r'(\w+)=(\d+)'); // Group 1: key, Group 2: value
  /// final text = 'id=10 name=test value=123';
  /// keyValueRegex.allMatchesGroups(text, 1).toList() // -> ['id', 'name', 'value']
  /// keyValueRegex.allMatchesGroups(text, 2).toList() // -> ['10', 'test', '123']
  /// keyValueRegex.allMatchesGroups(text, 0).toList() // -> ['id=10', 'name=test', 'value=123'] (same as allMatchesValues)
  /// ```
  Iterable<String?> allMatchesGroups(String input, int groupIndex) {
    if (groupIndex < 0) {
      throw RangeError.range(groupIndex, 0, null, 'groupIndex', 'must be non-negative');
    }
    // groupCount isn't available directly on RegExp, check first match or assume valid index
    // A RangeError will be thrown by match.group() if index is invalid for that match anyway.
    return allMatches(input).map((match) {
      if (groupIndex > match.groupCount) {
        throw RangeError.range(
          groupIndex,
          0,
          match.groupCount,
          'groupIndex',
          'out of bounds for match "${match.group(0)}"',
        );
      }
      return match.group(groupIndex);
    });
  }

  /// Captures specific groups from the *first* match found in the [input].
  /// Returns a map where keys are the requested [groupIndices] and values
  /// are the corresponding captured strings (or `null` if a group didn't match).
  /// Returns an empty map if no match is found or no indices are provided.
  ///
  /// Throws [RangeError] if any [groupIndices] is negative or out of bounds for the match.
  ///
  /// Example:
  /// ```dart
  /// final dateRegex = RegExp(r'(\d{4})-(\d{2})-(\d{2})'); // Y:1, M:2, D:3
  /// final text = 'Date: 2023-10-27';
  /// dateRegex.captureGroupsFromFirstMatch(text, [1, 3]) // -> {1: '2023', 3: '27'}
  /// dateRegex.captureGroupsFromFirstMatch(text, [0, 2]) // -> {0: '2023-10-27', 2: '10'}
  /// dateRegex.captureGroupsFromFirstMatch('invalid date', [1]) // -> {}
  /// ```
  Map<int, String?> captureGroupsFromFirstMatch(String input, List<int> groupIndices) {
    if (groupIndices.isEmpty) return {};

    final match = firstMatch(input);
    if (match == null) return {};

    final result = <int, String?>{};
    for (final index in groupIndices) {
      if (index < 0 || index > match.groupCount) {
        throw RangeError.range(index, 0, match.groupCount, 'groupIndices', 'contains invalid index for match');
      }
      result[index] = match.group(index);
    }
    return result;
  }

  /// Replaces all matches of this pattern in the [input] string, providing
  /// the list of captured group values (starting from group 1) to the [replacer] function.
  ///
  /// The [replacer] function receives a list where `groups[0]` corresponds to `match.group(1)`,
  /// `groups[1]` corresponds to `match.group(2)`, and so on. Each element can be `null`
  /// if the corresponding optional group did not match.
  ///
  /// Example:
  /// ```dart
  /// final templateRegex = RegExp(r'\{(\w+)\}'); // Capture variable name in group 1
  /// final data = {'name': 'Alice', 'city': 'Wonderland'};
  /// final template = 'Hello {name}, welcome to {city}!';
  ///
  /// final result = templateRegex.replaceAllWithGroups(template, (groups) {
  ///   final variableName = groups[0]; // Corresponds to group 1
  ///   return data[variableName] ?? '<missing>';
  /// });
  /// // result -> 'Hello Alice, welcome to Wonderland!'
  ///
  /// final missingVarTemplate = 'User: {name}, Age: {age}';
  /// final result2 = templateRegex.replaceAllWithGroups(missingVarTemplate, (groups) {
  ///    final variableName = groups[0];
  ///    return data[variableName] ?? '<missing>';
  /// });
  /// // result2 -> 'User: Alice, Age: <missing>'
  /// ```
  String replaceAllWithGroups(String input, String Function(List<String?> groups) replacer) {
    return input.replaceAllMapped(this, (Match match) {
      final groups = <String?>[];
      // Extract groups starting from index 1 up to groupCount
      for (int i = 1; i <= match.groupCount; i++) {
        groups.add(match.group(i));
      }
      return replacer(groups);
    });
  }
}
