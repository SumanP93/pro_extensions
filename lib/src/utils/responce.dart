abstract class Response<S, F> {
  void handle(void Function(S s) onSuccess, void Function(F f) onFailure) {
    if (this.isSuccess) {
      onSuccess(this._asSuccess.content);
    } else {
      onFailure(this._asFailure.content);
    }
  }

  bool get isSuccess => this is Data<S, F>;

  bool get isFailure => this is ErrorData<S, F>;

  Data<S, F> get _asSuccess => this as Data<S, F>;

  ErrorData<S, F> get _asFailure => this as ErrorData<S, F>;

  dynamic get response => this.isSuccess ? this._asSuccess.content : this._asFailure.content;
}

class Data<S, F> extends Response<S, F> {
  S content;
  Data(this.content);
}

class ErrorData<S, F> extends Response<S, F> {
  F content;
  ErrorData(this.content);
}
