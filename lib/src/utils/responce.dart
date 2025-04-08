typedef SuccessCallBack<S> = void Function(S s);
typedef FailedCallBack<F> = void Function(F f);

sealed class Response<S, F> {
  const Response();

  factory Response.success(S data) => Success<S, F>(data);
  factory Response.failed(F data) => Failed<S, F>(data);

  void handle({required SuccessCallBack<S> onSuccess, required FailedCallBack<F> onFailed}) {
    if (this.isSuccess) {
      onSuccess(this.asSuccess.data);
    } else {
      onFailed(this.asFailed.data);
    }
  }

  dynamic get responseData => this is Success<S, F> ? this.asSuccess.data : this.asFailed.data;

  bool get isSuccess => this is Success<S, F>;

  bool get isFailed => this is Failed<S, F>;

  Success<S, F> get asSuccess => this as Success<S, F>;

  Failed<S, F> get asFailed => this as Failed<S, F>;
}

final class Success<S, F> extends Response<S, F> {
  final S data;
  const Success(this.data);
}

final class Failed<S, F> extends Response<S, F> {
  final F data;
  const Failed(this.data);
}
