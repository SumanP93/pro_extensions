abstract class Response<S, F> {
  void handle(void Function(S s) onSuccess, void Function(F f) onFailure) {
    if (this.isSuccess) {
      onSuccess(this._asSuccess.content);
    } else {
      onFailure(this._asFailure.content);
    }
  }

  bool get isSuccess => this is Success<S, F>;

  bool get isFailure => this is Failure<S, F>;

  Success<S, F> get _asSuccess => this as Success<S, F>;

  Failure<S, F> get _asFailure => this as Failure<S, F>;

  dynamic get response => this.isSuccess ? this._asSuccess.content : this._asFailure.content;
}

class Success<S, F> extends Response<S, F> {
  S content;
  Success(this.content);
}

class Failure<S, F> extends Response<S, F> {
  F content;
  Failure(this.content);
}
