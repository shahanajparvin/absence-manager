import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/network/error_messages.dart';
import 'package:absence_manager/core/utils/const.dart';
import 'package:flutter/material.dart';

class ApiExceptionHandlingService {
  Future<ApiResponse<T>> handleApiCall<T>(
      Future<ApiResponse<T>> Function() apiCall) async {
    try {
      return await apiCall();
    } on FormatException catch (err) {
      return ErrorResponse<T>(
        statusCode: undefinedErrorCode,
        errorMessage: ErrorMessages.invalidResponseFormat,
      );
    } catch (e, stackTrace) {
      return ErrorResponse<T>(
        statusCode: undefinedErrorCode,
        errorMessage: ErrorMessages.invalidResponseFormat,
      );
    }
  }

  void logError(String title, String details) {
    debugPrint('$title: $details'); // Replace with your preferred logging mechanism
  }
}
