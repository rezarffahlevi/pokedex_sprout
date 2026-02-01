class FailureResponse<T> {
  final String errorMessage;
  final dynamic errors;
  final int? statusCode;
  final T? data;

  const FailureResponse({
    required this.errorMessage,
    this.errors,
    this.statusCode,
    this.data,
  });
}
