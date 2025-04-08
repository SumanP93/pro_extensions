typedef SuccessCallBack<R, S> = R Function(S s);
typedef FailedCallBack<R, F> = R Function(F f);

sealed class Response<S, F> {
  const Response();

  factory Response.success(S data) => Success<S, F>(data);
  factory Response.failed(F data) => Failed<S, F>(data);

  void handle({required SuccessCallBack<void, S> onSuccess, required FailedCallBack<void, F> onFailed});

  R fold<R>({required SuccessCallBack<R, S> onSuccess, required FailedCallBack<R, F> onFailed});

  S? get successData => isSuccess ? this.asSuccess.data : null;

  F? get failedData => isFailed ? this.asFailed.data : null;

  bool get isSuccess => this is Success<S, F>;

  bool get isFailed => this is Failed<S, F>;

  Success<S, F> get asSuccess => this as Success<S, F>;

  Failed<S, F> get asFailed => this as Failed<S, F>;
}

final class Success<S, F> extends Response<S, F> {
  final S data;
  const Success(this.data);

  @override
  void handle({required SuccessCallBack<void, S> onSuccess, required FailedCallBack<void, F> onFailed}) =>
      onSuccess(asSuccess.data);

  @override
  R fold<R>({required SuccessCallBack<R, S> onSuccess, required FailedCallBack<R, F> onFailed}) =>
      onSuccess(asSuccess.data);
}

final class Failed<S, F> extends Response<S, F> {
  final F data;
  const Failed(this.data);

  @override
  void handle({required SuccessCallBack<void, S> onSuccess, required FailedCallBack<void, F> onFailed}) =>
      onFailed(asFailed.data);

  @override
  R fold<R>({required SuccessCallBack<R, S> onSuccess, required FailedCallBack<R, F> onFailed}) =>
      onFailed(asFailed.data);
}
