abstract class Response<S, F> {
  const Response(this.data);

  void handle(void Function(S s) onSuccess, void Function(F f) onFailed) {
    if (this.isSuccess) {
      onSuccess(this.asSuccess.data);
    } else {
      onFailed(this.asFailed.data);
    }
  }

  final dynamic data;

  bool get isSuccess => this is Success<S, F>;

  bool get isFailed => this is Failed<S, F>;

  Success<S, F> get asSuccess => this as Success<S, F>;

  Failed<S, F> get asFailed => this as Failed<S, F>;
}

class Success<S, F> extends Response<S, F> {
  const Success(S super.data);
}

class Failed<S, F> extends Response<S, F> {
  const Failed(F super.data);
}
