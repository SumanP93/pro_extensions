/// A functional result type representing either a successful value or a failure value.
///
/// This is similar to the Either type in functional programming, commonly used
/// for error handling without exceptions.
///
/// Type parameters:
/// - [S]: The type of the success value
/// - [F]: The type of the failure value
///
/// Example:
/// ```dart
/// Response<String, Exception> fetchUser(int id) {
///   try {
///     final user = api.getUser(id);
///     return Response.success(user);
///   } catch (e) {
///     return Response.failed(Exception('Failed to fetch user'));
///   }
/// }
///
/// final result = fetchUser(123);
/// final message = result.fold(
///   onSuccess: (user) => 'Found user: $user',
///   onFailed: (error) => 'Error: ${error.toString()}',
/// );
/// ```
sealed class Response<S, F> {
  const Response();

  /// Creates a successful response with the given [data].
  factory Response.success(S data) => Success<S, F>(data);

  /// Creates a failed response with the given [error].
  factory Response.failed(F error) => Failed<S, F>(error);

  /// Transforms this response into a value of type [R] by applying the appropriate callback.
  ///
  /// If this is a [Success], calls [onSuccess] with the success data.
  /// If this is a [Failed], calls [onFailed] with the failure data.
  R fold<R>({required R Function(S data) onSuccess, required R Function(F error) onFailed});

  /// Pattern matching method for exhaustive handling of both cases.
  ///
  /// This is the preferred method for handling responses as it enforces
  /// exhaustive case handling at compile time.
  R when<R>({required R Function(S data) success, required R Function(F error) failed}) =>
      fold(onSuccess: success, onFailed: failed);

  /// Maps the success value using the provided function.
  ///
  /// If this is a [Success], applies [transform] to the data.
  /// If this is a [Failed], returns the failure unchanged.
  Response<T, F> map<T>(T Function(S data) transform);

  /// Maps the failure value using the provided function.
  ///
  /// If this is a [Failed], applies [transform] to the error.
  /// If this is a [Success], returns the success unchanged.
  Response<S, T> mapError<T>(T Function(F error) transform);

  /// Returns the success value or a default value if this is a failure.
  S getOrElse(S Function() defaultValue) => fold(onSuccess: (data) => data, onFailed: (_) => defaultValue());

  /// Returns the success value or null if this is a failure.
  S? getOrNull() => fold(onSuccess: (data) => data, onFailed: (_) => null);

  /// Returns the failure value or null if this is a success.
  F? getErrorOrNull() => fold(onSuccess: (_) => null, onFailed: (error) => error);

  /// Swaps success and failure types.
  Response<F, S> swap() =>
      fold(onSuccess: (data) => Response.failed(data), onFailed: (error) => Response.success(error));

  /// Returns true if this is a [Success].
  bool get isSuccess => this is Success<S, F>;

  /// Returns true if this is a [Failed].
  bool get isFailed => this is Failed<S, F>;
}

/// Represents a successful response containing data of type [S].
final class Success<S, F> extends Response<S, F> {
  /// The successful data.
  final S data;

  const Success(this.data);

  @override
  R fold<R>({required R Function(S data) onSuccess, required R Function(F error) onFailed}) => onSuccess(data);

  @override
  Response<T, F> map<T>(T Function(S data) transform) => Success(transform(data));

  @override
  Response<S, T> mapError<T>(T Function(F error) transform) => Success<S, T>(data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Success<S, F> && runtimeType == other.runtimeType && data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success($data)';
}

/// Represents a failed response containing an error of type [F].
final class Failed<S, F> extends Response<S, F> {
  /// The failure error.
  final F error;

  const Failed(this.error);

  @override
  R fold<R>({required R Function(S data) onSuccess, required R Function(F error) onFailed}) => onFailed(error);

  @override
  Response<T, F> map<T>(T Function(S data) transform) => Failed<T, F>(error);

  @override
  Response<S, T> mapError<T>(T Function(F error) transform) => Failed(transform(error));

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Failed<S, F> && runtimeType == other.runtimeType && error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failed($error)';
}
