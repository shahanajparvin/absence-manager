abstract class ApiResponse<T> {
  const ApiResponse({required this.statusCode, this.message});

  final int statusCode;
  final String? message;
}

class SuccessResponse<T> extends ApiResponse<T> {
  const SuccessResponse({
    required super.statusCode,
    this.data,
    super.message,
  });

  final T? data;
}

class ErrorResponse<T> extends ApiResponse<T> {
  const ErrorResponse({
    required int statusCode,
    required this.errorMessage,
    this.exception,
    String? message,
  }) : super(statusCode: statusCode, message: message);
  final String errorMessage;
  final Exception? exception;
}

class UndefinedErrorResponse<T> extends ErrorResponse<T> {
  const UndefinedErrorResponse({
    this.error = 'An undefined error occurred',
    this.exception,
  }) : super(
          statusCode: UndefinedErrorCode,
          errorMessage: error,
          exception: exception,
        );

  static const int UndefinedErrorCode = -100;

  final String error;
  final Exception? exception;
}
