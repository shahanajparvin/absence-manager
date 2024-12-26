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
    required super.statusCode,
    required this.errorMessage,
    this.exception,
    super.message,
  });
  final String errorMessage;
  final Exception? exception;
}

class UndefinedErrorResponse<T> extends ErrorResponse<T> {
  const UndefinedErrorResponse({
    this.error = 'An undefined error occurred',
    this.exception1,
  }) : super(
          statusCode: undefinedErrorCode,
          errorMessage: error,
          exception: exception1,
        );

  static const int undefinedErrorCode = -100;

  final String error;


  final Exception? exception1;
}
