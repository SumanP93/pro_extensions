# pro_extensions

A comprehensive collection of Dart and Flutter extensions designed to boost developer productivity, reduce boilerplate, and make your code more expressive and readable — all without adding heavy dependencies.

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Dart Extensions](#dart-extensions)
  - [Object Extensions](#1-object-extensions)
  - [String Extensions](#2-string-extensions)
  - [Bool Extensions](#3-bool-extensions)
  - [Num Extensions](#4-num-extensions)
  - [Int Extensions](#5-int-extensions)
  - [Double Extensions](#6-double-extensions)
  - [RegExp Extensions](#7-regexp-extensions)
  - [Iterable Extensions](#8-iterable-extensions)
  - [List Extensions](#9-list-extensions)
  - [Map Extensions](#10-map-extensions)
  - [DateTime Extensions](#11-datetime-extensions)
  - [Duration Extensions](#12-duration-extensions)
  - [Future Extensions](#13-future-extensions)
- [Flutter Extensions](#flutter-extensions)
  - [BuildContext Extensions](#14-buildcontext-extensions)
  - [Widget Extensions](#15-widget-extensions)
  - [State Extensions](#16-state-extensions)
  - [Color Extensions](#17-color-extensions)
  - [EdgeInsets Extensions](#18-edgeinsets-extensions)
  - [TextStyle Extensions](#19-textstyle-extensions)
- [Utilities](#utilities)
  - [Debouncer](#20-debouncer)
  - [Response](#21-response)
- [How It Works](#how-it-works)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- ✅ **Zero additional dependencies** — built purely on Dart and Flutter SDK
- ✅ **Null-safe** — all extensions safely handle nullable types
- ✅ **Dart core types** — `Object`, `String`, `bool`, `num`, `int`, `double`, `RegExp`
- ✅ **Collections** — `Iterable`, `List`, `Map`
- ✅ **Date & Time** — `DateTime`, `Duration`
- ✅ **Async** — `Future`
- ✅ **Flutter UI** — `BuildContext`, `Widget`, `State`, `Color`, `EdgeInsets`, `TextStyle`
- ✅ **Utility classes** — `Debouncer`, `Response`

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  pro_extensions: 
    git:
      url: https://github.com/SumanP93/pro_extensions.git
```

Then run:

```bash
flutter pub get
```

---

## Usage

Import the single barrel file to access all extensions at once:

```dart
import 'package:pro_extensions/pro_extensions.dart';
```

That's it! All extensions are now available throughout your project.

---

## Dart Extensions

### 1. Object Extensions

**File:** `src/dart/object_extensions.dart`  
**Extension:** `ObjectBoostExtensions on Object?`

These extensions apply to every Dart object (including nullable ones) and provide Kotlin-style utility methods.

| Method / Property | Description |
|---|---|
| `isNull` | Returns `true` if the object is `null` |
| `isNotNull` | Returns `true` if the object is not `null` |
| `safeCast<T>()` | Safe cast to type `T`, returns `null` if cast fails |
| `let<R>(block)` | Executes block if not null, returns the result |
| `also<T>(block)` | Executes block for side effects if not null, returns original object |
| `debugPrint([prefix])` | Prints the object to console in debug mode only |

**Example:**

```dart
String? name = getName();

// Safe cast
String? str = someObject.safeCast<String>();

// Let — chain operations on nullable objects
int? nameLength = name?.let((it) => it.length);

// Also — side effects
User? user = getUser();
user?.also<User>((it) {
  print("User fetched: \${it.name}");
});
```

---

### 2. String Extensions

**File:** `src/dart/string_extensions.dart`  
**Extension:** `StringBoostExtensions on String?`

Rich null-safe string utilities.

| Method / Property | Description |
|---|---|
| `isNullOrEmpty` | `true` if `null` or `""` |
| `isNotNullOrEmpty` | `true` if not null and not empty |
| `isNullOrBlank` | `true` if `null`, `""`, or whitespace only |
| `isNotNullOrBlank` | Opposite of `isNullOrBlank` |
| `orEmpty([fallback])` | Returns fallback if null/empty |
| `orBlank([fallback])` | Returns fallback if null/blank |
| `toIntOrNull()` | Parses to `int` or returns `null` |
| `toDoubleOrNull()` | Parses to `double` or returns `null` |
| `toBoolOrNull()` | Parses `"true"/"1"/"yes"` → `true`, `"false"/"0"/"no"` → `false` |
| `isValidEmail` | Validates email format |
| `isValidUrl` | Validates URL format |
| `isValidPhone` | Basic phone number validation |
| `containsIgnoreCase(other)` | Case-insensitive `contains` |
| `equalsIgnoreCase(other)` | Case-insensitive equality |
| `capitalize()` | `"hello world"` → `"Hello world"` |
| `toTitleCase()` | `"hello world"` → `"Hello World"` |
| `reverse()` | Reverses the string |
| `truncate(maxLength, {ellipsis})` | Truncates with optional `"..."` |
| `validate(fn)` | Returns string only if it passes a custom validator |
| `removeWhitespace()` | Removes all whitespace characters |
| `readingTime({wordsPerMinute})` | Estimates reading time (default 225 WPM) |
| `byteSize({encoding})` | Returns UTF-8 byte size of the string |

**Example:**

```dart
String? email = "user@example.com";
print(email.isValidEmail);          // true
print(email.capitalize());          // "User@example.com"

String? longText = "Hello World!";
print(longText.truncate(8));        // "Hello..."
print(longText.readingTime());      // "1 min" or similar

String? raw = "  ";
print(raw.isNullOrBlank);           // true
print(raw.orBlank("default"));      // "default"
```

---

### 3. Bool Extensions

**File:** `src/dart/bool_extensions.dart`  
**Extensions:** `BoolBoostExtensions on bool?`, `NonNullableBoolBoostExtensions on bool`

| Method / Property | Description |
|---|---|
| `isTrue` | `true` if not null and `true` |
| `isFalse` | `true` if not null and `false` |
| `isNullOrFalse` | `true` if `null` or `false` |
| `isNullOrTrue` | `true` if `null` or `true` |
| `toInt()` | `true` → `1`, `false/null` → `0` |
| `ifTrue(callback)` | Executes callback if `true`, returns self |
| `ifFalse(callback)` | Executes callback if `false`, returns self |
| `toStringRepresentation(ifTrue, ifFalse, {ifNull})` | Custom string per state |
| `toggle()` | Flips the boolean value (non-nullable only) |

**Example:**

```dart
bool? loggedIn = checkLoginStatus();

loggedIn.ifTrue(() => print("Welcome!"));
loggedIn.ifFalse(() => redirectToLogin());

print(loggedIn.toStringRepresentation("Yes", "No", ifNull: "Unknown"));

bool lightIsOn = true;
lightIsOn = lightIsOn.toggle(); // false
```

---

### 4. Num Extensions

**File:** `src/dart/num_extensions.dart`  
**Extension:** `NumBoostExtensions on num?`

Covers both `int` and `double`. Also provides **Duration creator shortcuts**.

| Method / Property | Description |
|---|---|
| `orZero()` | Returns `0` if null |
| `clamp(min, max)` | Clamps value to range, `null`-safe |
| `isBetween(min, max)` | Range check, inclusive |
| `toStringAsFixedOrDefault(digits, {defaultValue})` | Fixed decimal string |
| `toPercentageString(decimals, {ifNull})` | `0.75` → `"75.0%"` |
| `.microseconds` | `Duration(microseconds: value)` |
| `.milliseconds` | `Duration(milliseconds: value)` |
| `.seconds` | `Duration` in seconds |
| `.minutes` | `Duration` in minutes |
| `.hours` | `Duration` in hours |
| `.days` | `Duration` in days |

**Example:**

```dart
num? price = null;
print(price.orZero());                    // 0
print(0.75.toPercentageString(1));        // "75.0%"

// Duration creators (combine with Future.delayed, etc.)
await Future.delayed(2.seconds);
await Future.delayed(500.milliseconds);
```

---

### 5. Int Extensions

**File:** `src/dart/int_extensions.dart`  
**Extension:** `IntBoostExtensions on int`

| Method / Property | Description |
|---|---|
| `isBetween(min, max)` | Inclusive range check |
| `clamp(min, max)` | Clamps to range |
| `times(action)` | Executes action N times, receiving index |
| `toOrdinal()` | `1` → `"1st"`, `2` → `"2nd"`, `3` → `"3rd"` |
| `.kb` | Value × 1024 |
| `.mb` | Value × 1024² |
| `.gb` | Value × 1024³ |
| `formatedSize` | Auto formats bytes to `B`, `KB`, `MB`, `GB`, `TB`, etc. |

**Example:**

```dart
5.times((i) => print("Item \$i")); // prints 0, 1, 2, 3, 4

print(3.toOrdinal());   // "3rd"
print(11.toOrdinal());  // "11th"
print(21.toOrdinal());  // "21st"

int fileSize = 2048;
print(fileSize.formatedSize); // "2.0 KB"
```

---

### 6. Double Extensions

**File:** `src/dart/double_extensions.dart`  
**Extension:** `DoubleBoostExtensions on double?`

| Method / Property | Description |
|---|---|
| `orZero()` | Returns `0.0` if null |
| `clamp(min, max)` | Clamps value, null-safe |
| `roundToDecimalPlaces(n)` | Rounds to N decimal places |
| `toStringAsFixedOrDefault(digits, {defaultValue})` | Fixed decimal string or default |
| `isInteger({epsilon})` | Checks if value has no fractional part |
| `isBetween(min, max)` | Inclusive range check |

**Example:**

```dart
print(3.14159.roundToDecimalPlaces(2));  // 3.14
print(10.0.isInteger());                  // true
print(10.5.isInteger());                  // false

double? val = null;
print(val.orZero());                      // 0.0
```

---

### 7. RegExp Extensions

**File:** `src/dart/regexp_extensions.dart`  
**Extension:** `RegExpBoostExtensions on RegExp`

| Method | Description |
|---|---|
| `matchesEntireString(input)` | Checks if the entire string matches the pattern |
| `firstMatchValue(input)` | Returns the first matched substring or `null` |
| `allMatchesValues(input)` | Returns all matched substrings |
| `allMatchesGroups(input, groupIndex)` | Returns all captures of a specific group |
| `captureGroupsFromFirstMatch(input, groupIndices)` | Extracts specific groups from first match |
| `replaceAllWithGroups(input, replacer)` | Replace all matches with a function using captured groups |

**Example:**

```dart
final numberRegex = RegExp(r'\d+');
print(numberRegex.firstMatchValue('abc 123 def'));         // "123"
print(numberRegex.allMatchesValues('1 two 3').toList()); // ["1", "3"]

final dateRegex = RegExp(r'(\d{4})-(\d{2})-(\d{2})');
final groups = dateRegex.captureGroupsFromFirstMatch('2023-10-27', [1, 2, 3]);
// {1: '2023', 2: '10', 3: '27'}
```

---

### 8. Iterable Extensions

**File:** `src/dart/iterable_extensions.dart`  
**Extension:** `IterableBoostExtensions<T> on Iterable<T>?`

Applies to `List`, `Set`, and any `Iterable`.

| Method / Property | Description |
|---|---|
| `isNullOrEmpty` | `true` if null or empty |
| `isNotNullOrEmpty` | `true` if not null and not empty |
| `orEmpty()` | Returns empty iterable if null |
| `firstWhereOrNull(test)` | First match or `null` |
| `lastWhereOrNull(test)` | Last match or `null` |
| `randomElement([random])` | Returns a random element or `null` |
| `chunked(size)` | Splits into chunks of given size |
| `distinctBy(keySelector)` | Removes duplicates by a key |
| `mapNotNull(transform)` | Maps and filters out nulls |
| `whereNotNull()` | Removes null elements |
| `sumBy(selector)` | Sums values by selector function |
| `averageBy(selector)` | Averages values by selector function |
| `joinToString({separator, nullRepresentation})` | Joins to string with custom separator |
| `drop(count)` | Skips first N elements |
| `dropLast(count)` | Skips last N elements |

**Example:**

```dart
final numbers = [1, 2, 3, 4, 5];
print(numbers.chunked(2).toList()); // [[1,2], [3,4], [5]]
print(numbers.drop(2).toList());    // [3, 4, 5]
print(numbers.sumBy((n) => n));     // 15.0

final users = [User('Alice', 1), User('Bob', 2), User('Alice', 3)];
final distinct = users.distinctBy((u) => u.name);
// [User('Alice', 1), User('Bob', 2)]

final mixed = [1, null, 3, null, 5];
print(mixed.whereNotNull()); // [1, 3, 5]
```

---

### 9. List Extensions

**File:** `src/dart/list_extensions.dart`  
**Extensions:** `ListBoostExtensions<T> on List<T>`, `ListStringBoostExtensions on List<String>?`

| Method / Property | Description |
|---|---|
| `getOrNull(index)` | Returns element at index or `null` if out of bounds |
| `shuffle([random])` | Shuffles list in-place |
| `shuffled([random])` | Returns a new shuffled list |
| `sample(size, [random])` | Returns N random unique elements |
| `addIf(condition, element)` | Adds element only if condition is true |
| `addIfNotNull(element)` | Adds element only if not null |
| `swap(i1, i2)` | Swaps elements at two indices |
| `readingTime({wordsPerMinute})` | (String list) Estimates total reading time |
| `totalByteSize({encoding})` | (String list) Total UTF-8 byte size |
| `totalLength()` | (String list) Total character count |
| `formatedSize` | (String list) Human-readable total byte size |

**Example:**

```dart
final list = [10, 20, 30];
print(list.getOrNull(5));  // null
print(list.getOrNull(1));  // 20

list.swap(0, 2);           // [30, 20, 10]

final items = [1, 2, 3];
items.addIf(items.length < 5, 4); // [1, 2, 3, 4]

final sample = items.sample(2); // 2 random items
```

---

### 10. Map Extensions

**File:** `src/dart/map_extensions.dart`  
**Extensions:** `MapBoostExtensions<K,V> on Map<K,V>?`, `NonNullableMapBoostExtensions<K,V> on Map<K,V>`

| Method / Property | Description |
|---|---|
| `isNullOrEmpty` | `true` if null or empty |
| `isNotNullOrEmpty` | `true` if not null and not empty |
| `orEmpty()` | Returns `{}` if null |
| `getOrDefault(key, defaultValue)` | Gets value or returns default |
| `removeNullValues()` | Returns new map without null values |
| `mapKeys(transform)` | Returns new map with transformed keys |
| `mapValues(transform)` | Returns new map with transformed values |
| `merge(other)` | Merges two maps, `other` wins on conflict |
| `toJson()` | Converts to JSON string |
| `addIfNotNull(key, value)` | Adds only if value is not null |
| `addIf(condition, key, value)` | Adds only if condition is true |
| `addAllIfNotNull(other)` | Merges non-null entries only |

**Example:**

```dart
final map = {'a': 1, 'b': null, 'c': 3};
print(map.removeNullValues()); // {a: 1, c: 3}

final m1 = {'a': 1, 'b': 2};
final m2 = {'b': 3, 'c': 4};
print(m1.merge(m2));           // {a: 1, b: 3, c: 4}

print(m1.mapValues((v) => v * 10)); // {a: 10, b: 20}

print(map.toJson());
// '{"a":1,"b":null,"c":3}'
```

---

### 11. DateTime Extensions

**File:** `src/dart/date_time_extensions.dart`  
**Extension:** `DateTimeBoostExtensions on DateTime?`

| Method / Property | Description |
|---|---|
| `isNull` / `isNotNull` | Null checks |
| `isSameDay(other)` | Same day ignoring time |
| `isSameMonth(other)` | Same year and month |
| `isSameYear(other)` | Same year |
| `isToday` | True if today |
| `isYesterday` | True if yesterday |
| `isTomorrow` | True if tomorrow |
| `isThisWeek` | True if within current Mon–Sun week |
| `isInFuture` | True if after now |
| `isInPast` | True if before now |
| `startOfDay` | Same date at `00:00:00` |
| `endOfDay` | Same date at `23:59:59.999` |
| `startOfMonth` | First day of the month |
| `endOfMonth` | Last moment of the month |
| `addDuration(duration)` | Null-safe `add()` |
| `subtractDuration(duration)` | Null-safe `subtract()` |
| `formatYYYYMMDD()` | `"2023-10-26"` |
| `formatDDMMYYYY()` | `"26/10/2023"` |
| `formatMMDDYYYY()` | `"10/26/2023"` |
| `formatHHMMSS()` | `"14:35:05"` |
| `formatHHMM()` | `"14:35"` |
| `timeAgo()` | `"5 minutes ago"`, `"Yesterday"`, `"2 weeks ago"` |
| `hasSameTime(TimeOfDay)` | Checks hour and minute match |

**Example:**

```dart
DateTime? date = DateTime.now();

print(date.isToday);        // true
print(date.isInPast);       // false
print(date.formatDDMMYYYY()); // "19/02/2026"
print(date.timeAgo());      // "just now"

final yesterday = DateTime.now().subtract(Duration(days: 1));
print(yesterday.isYesterday); // true
print(yesterday.timeAgo());   // "Yesterday"
```

---

### 12. Duration Extensions

**File:** `src/dart/duration_extensions.dart`  
**Extension:** `DurationBoostExtensions on Duration`

| Method / Property | Description |
|---|---|
| `delay` | Returns a `Future` that completes after this duration |
| `toHHMMSS()` | `"02:15:30"` (handles >24h) |
| `toMMSS()` | `"90:15"` (total minutes) |
| `toHumanReadable()` | `"1d 5h 10m"`, omits zero parts |

**Example:**

```dart
print(Duration(hours: 2, minutes: 15, seconds: 30).toHHMMSS()); 
// "02:15:30"

print(Duration(days: 1, hours: 5, minutes: 10).toHumanReadable()); 
// "1d 5h 10m"

// Use with the num extension
await 3.seconds.delay;
print("Executed after 3 seconds");
```

---

### 13. Future Extensions

**File:** `src/dart/future_extensions.dart`  
**Extension:** `FutureBoostExtensions<T> on Future<T>`

| Method | Description |
|---|---|
| `withLoading({onStart, onEnd})` | Calls `onStart` before and `onEnd` after the future |
| `onErrorReturn(defaultValue)` | Returns a default value on error |
| `onErrorReturnNull()` | Returns `null` on error |
| `timeoutOrNull(duration)` | Returns `null` on timeout or error |
| `timeoutOrDefault(duration, {defaultValue})` | Returns default on timeout |
| `delay(duration)` | Adds a delay *after* the future completes |
| `debugPrint([prefix])` | Logs result/error in debug mode |

**Example:**

```dart
// Show a loading spinner while fetching
await fetchUserData()
  .withLoading(
    onStart: () => setState(() => _loading = true),
    onEnd:   () => setState(() => _loading = false),
  );

// Graceful error handling
int count = await fetchCount().onErrorReturn(0);
User? user = await fetchOptionalUser().onErrorReturnNull();

// Timeout safety
Data? data = await fetchData().timeoutOrNull(5.seconds);
if (data == null) print("Timed out");
```

---

## Flutter Extensions

### 14. BuildContext Extensions

**File:** `src/flutter/build_context_extensions.dart`  
**Extension:** `BuildContextBoostExtensions on BuildContext`

The most powerful extension in the package. Provides direct access to common Flutter infrastructure from any `BuildContext`.

**Theme & Style**
```dart
context.theme           // ThemeData
context.textTheme       // TextTheme
context.colorScheme     // ColorScheme
context.isDarkMode      // bool
```

**MediaQuery**
```dart
context.screenSize        // Size
context.screenWidth       // double
context.screenHeight      // double
context.orientation       // Orientation
context.devicePixelRatio  // double
context.viewPaddingTop    // Status bar height
context.viewPaddingBottom // Navigation bar height
context.viewInsetsBottom  // Keyboard height
context.isKeyboardVisible // bool
```

**Navigation**
```dart
context.push(route)
context.pushNamed('/home')
context.pushReplacementNamed('/dashboard')
context.pushNamedAndRemoveUntil('/login', (_) => false)
context.pop()
context.canPop()         // bool
context.popUntil(predicate)
```

**SnackBar**
```dart
context.showTextSnackBar("Saved successfully!");
context.showSnackBar(SnackBar(content: Text("Hello")));
context.hideCurrentSnackBar();
```

**Dialogs**
```dart
context.showAppDialog(builder: (_) => MyDialog());
context.showAppCupertinoDialog(builder: (_) => CupertinoAlertDialog(...));
context.showAppModalBottomSheet(builder: (_) => MySheet());
```

**Focus**
```dart
context.unfocus();                     // Dismiss keyboard
context.requestFocus(myFocusNode);
```

**Platform Detection**
```dart
context.isAndroid   // bool
context.isIOS       // bool
context.isWindows   // bool
context.isMacOS     // bool
context.isLinux     // bool
context.isMobile    // Android or iOS
context.isDesktop   // Windows, macOS, or Linux
context.isWeb       // kIsWeb
context.platform    // TargetPlatform
context.currentLocale // Locale
```

---

### 15. Widget Extensions

**File:** `src/flutter/widget_extensions.dart`  
**Extension:** `WidgetBoostExtensions on Widget`

Wrap any widget fluently without nesting constructors.

**Padding**
```dart
Text("Hello")
  .paddingAll(16)
  .paddingSymmetric(horizontal: 8, vertical: 4)
  .paddingOnly(left: 12, top: 8)
```

**Margin**
```dart
myWidget.marginAll(8)
myWidget.marginSymmetric(horizontal: 16)
myWidget.marginOnly(bottom: 24)
```

**Alignment & Positioning**
```dart
myWidget.center()
myWidget.align(Alignment.centerLeft)
myWidget.alignCenterRight()
myWidget.alignTopCenter()
myWidget.positioned(left: 10, top: 10)  // inside Stack
myWidget.positionedFill()               // inside Stack
```

**Sizing**
```dart
myWidget.sizedBox(width: 100, height: 50)
myWidget.constrainedBox(BoxConstraints(maxWidth: 200))
myWidget.aspectRatio(16 / 9)
myWidget.expanded()
myWidget.flexible(flex: 2)
```

**Visibility**
```dart
myWidget.visible(visible: someCondition)
myWidget.offstage(offstage: !isVisible)
```

**Gestures**
```dart
myWidget.onTap(() => print("Tapped!"))
myWidget.onDoubleTap(() => print("Double tapped!"))
myWidget.onLongPress(() => print("Long pressed!"))
```

**Effects & Styling**
```dart
myWidget.opacity(0.5)
myWidget.scale(1.2)
myWidget.translate(Offset(10, 0))
myWidget.clipRRect(BorderRadius.circular(12))
myWidget.clipOval()
myWidget.decoratedBox(BoxDecoration(color: Colors.blue))
myWidget.rotatedBox(1)   // 90-degree rotation
myWidget.tooltip("This is a hint")
myWidget.safeArea()
myWidget.scrollable()    // Wraps in SingleChildScrollView
```

**Chaining Example:**
```dart
// Without pro_extensions (nested boilerplate)
Padding(
  padding: const EdgeInsets.all(16),
  child: GestureDetector(
    onTap: () => doSomething(),
    child: Center(child: Text("Hello")),
  ),
);

// With pro_extensions (fluent chaining)
Text("Hello")
  .center()
  .onTap(() => doSomething())
  .paddingAll(16);
```

---

### 16. State Extensions

**File:** `src/flutter/state_extensions.dart`  
**Extension:** `StateBoostExtensions<T extends StatefulWidget> on State<T>`

| Method | Description |
|---|---|
| `safeSetState(fn)` | Calls `setState` only if widget is still mounted |
| `addPostFrameCallback(callback)` | Executes callback after the current frame is built |

**Example:**

```dart
Future<void> fetchData() async {
  final data = await api.getData();
  // No more "setState called after dispose()" crashes
  safeSetState(() {
    _data = data;
    _isLoading = false;
  });
}

@override
void initState() {
  super.initState();
  // Run after the first frame is rendered
  addPostFrameCallback((_) {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  });
}
```

---

### 17. Color Extensions

**File:** `src/flutter/color_extensions.dart`  
**Extensions:** `ColorBoostExtensions`, `HexColorStringExtension on String`

| Method | Description |
|---|---|
| `ColorBoostExtensions.fromHex(hex)` | Parses hex string to `Color` |
| `"#FF5733".toColorOrNull()` | Extension on `String` to parse to `Color?` |

**Example:**

```dart
// From the static factory
final color = ColorBoostExtensions.fromHex("#FF5733");

// From a String extension  
final Color? btnColor = "#4CAF50".toColorOrNull();
final Color? invalid  = "not-a-color".toColorOrNull(); // null

if (btnColor != null) {
  // use btnColor safely
}
```

---

### 18. EdgeInsets Extensions

**File:** `src/flutter/edge_insets_extensions.dart`  
**Extensions:** `EdgeInsetsGeometryBoostExtensions on EdgeInsetsGeometry?`, `EdgeInsetsBoostExtensions on EdgeInsets`

| Method / Property | Description |
|---|---|
| `isNullOrZero` | `true` if null or `EdgeInsets.zero` |
| `orZero()` | Returns `EdgeInsets.zero` if null |
| `horizontal({direction})` | Total left + right inset |
| `vertical({direction})` | Total top + bottom inset |
| `add(other)` | Adds two `EdgeInsetsGeometry` |
| `subtract(other)` | Subtracts (clamped to 0) |
| `copyWith({left, top, right, bottom})` | Copy with overrides |
| `horizontalOnly` | New `EdgeInsets` with only left/right |
| `verticalOnly` | New `EdgeInsets` with only top/bottom |

**Example:**

```dart
final padding = EdgeInsets.all(10);
final newPadding = padding.copyWith(top: 5);
// EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10)

EdgeInsetsGeometry? maybePadding = null;
print(maybePadding.isNullOrZero); // true
print(maybePadding.orZero());     // EdgeInsets.zero
```

---

### 19. TextStyle Extensions

**File:** `src/flutter/text_style_extensions.dart`  
**Extension:** `TextStyleBoostExtensions on TextStyle?`

| Method / Property | Description |
|---|---|
| `isNullOrDefault` | `true` if null or default `TextStyle()` |
| `orDefault()` | Returns `TextStyle()` if null |
| `mergeWith(other)` | Merges two styles, other wins |
| `copyWithColor(color)` | New style with color |
| `copyWithSize(fontSize)` | New style with font size |
| `copyWithWeight(fontWeight)` | New style with font weight |
| `copyWithStyle(fontStyle)` | New style with font style |
| `copyWithDecoration(decoration)` | New style with text decoration |
| `copyWithLetterSpacing(spacing)` | New style with letter spacing |
| `copyWithWordSpacing(spacing)` | New style with word spacing |
| `copyWithHeight(height)` | New style with line height |
| `bold` | Shortcut for `FontWeight.bold` |
| `italic` | Shortcut for `FontStyle.italic` |
| `underline` | Shortcut for `TextDecoration.underline` |
| `lineThrough` | Shortcut for `TextDecoration.lineThrough` |
| `overline` | Shortcut for `TextDecoration.overline` |
| `noDecoration` | Removes all decorations |

**Example:**

```dart
final base = TextStyle(fontSize: 14, color: Colors.black);

// Chained style customization
final title = base
  .copyWithSize(22)
  .bold
  .copyWithColor(Colors.blue);

final subtitle = base.italic.copyWithLetterSpacing(0.5);

TextStyle? userStyle = getUserStyle();
final safe = userStyle.orDefault().copyWithColor(Colors.red);
```

---

## Utilities

### 20. Debouncer

**File:** `src/utils/debouncer.dart`  
**Class:** `Debouncer`

A static utility class that prevents a function from being called too frequently. Ideal for search input, form auto-save, or scroll events.

| Method | Description |
|---|---|
| `Debouncer.debounce(callback, [delay])` | Debounces `callback` with default 300ms delay |
| `Debouncer.dispose()` | Cancels the current debounce timer |

**Example:**

```dart
// In your search TextField
TextField(
  onChanged: (query) {
    Debouncer.debounce(() {
      // Only fires 300ms after user stops typing
      performSearch(query);
    }, 300);
  },
);

// When the widget is disposed
@override
void dispose() {
  Debouncer.dispose();
  super.dispose();
}
```

---

### 21. Response

**File:** `src/utils/responce.dart`

A utility class for structured API/operation responses, providing a standard wrapper for success, error, and loading states.

**Example usage pattern:**

```dart
import 'package:pro_extensions/pro_extensions.dart';

// Wrap your API result in a Response
Future<Response> loadUserData() async {
  try {
    final user = await api.getUser();
    return Response.success(user);
  } catch (e) {
    return Response.error(e.toString());
  }
}

// Consume it
final result = await loadUserData();
if (result.isSuccess) {
  print(result.data);
} else {
  print(result.error);
}
```

---

## How It Works

`pro_extensions` uses Dart's **extension methods** feature to add new capabilities directly onto existing types — without subclassing, wrapping, or modifying the original types.

```
Import pro_extensions
        │
        ▼
┌───────────────────────────────────────┐
│        pro_extensions.dart            │
│   (Single barrel export file)         │
└──────────┬────────────────────────────┘
           │  exports all of:
     ┌─────┴──────┐
     │            │
┌────▼────┐  ┌────▼──────────┐
│  Dart   │  │    Flutter    │
│Extensions│  │  Extensions   │
├─────────┤  ├───────────────┤
│ Object  │  │ BuildContext  │
│ String  │  │ Widget        │
│ bool    │  │ State         │
│ num     │  │ Color         │
│ int     │  │ EdgeInsets    │
│ double  │  │ TextStyle     │
│ RegExp  │  └───────────────┘
│ Iterable│
│ List    │  ┌───────────────┐
│ Map     │  │  Utilities    │
│DateTime │  ├───────────────┤
│Duration │  │  Debouncer    │
│ Future  │  │  Response     │
└─────────┘  └───────────────┘
```

### Extension Method Mechanics

Each extension is defined like this:

```dart
// Declares a new extension on the nullable String? type
extension StringBoostExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String capitalize() {
    if (isNullOrEmpty) return '';
    return '\${this![0].toUpperCase()}\${this!.substring(1)}';
  }
}
```

When you call `"hello".capitalize()`, Dart resolves `capitalize` through the extension at compile time. There is **zero runtime overhead** compared to calling a standalone utility function.

### Null Safety Strategy

All extensions on nullable types (`String?`, `bool?`, `DateTime?`, etc.) follow a consistent pattern:

1. **Guard** — Check if `this == null` at the start.
2. **Fallback** — Return a safe default (`false`, `""`, `null`, `0.0`).
3. **Force unwrap** — Use `this!` only after the null check.

```dart
extension DoubleBoostExtensions on double? {
  double? roundToDecimalPlaces(int decimalPlaces) {
    if (this == null) return null;   // ← Guard
    final value = this!;              // ← Safe force-unwrap
    num factor = pow(10, decimalPlaces);
    return (value * factor).round() / factor;
  }
}
```

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-extension`
3. Add your extension with full documentation and example code
4. Add tests in the `test/` directory
5. Run `flutter test` to ensure all tests pass
6. Open a pull request
