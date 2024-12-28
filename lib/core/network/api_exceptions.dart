import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/network/error_messages.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ApiExceptionHandlingService {
  Future<ApiResponse<T>> handleApiCall<T>(
      Future<ApiResponse<T>> Function() apiCall) async {
    try {
      return await apiCall();
    } on FormatException catch (e) {
      logError('ddd ',e.toString());
      return ErrorResponse<T>(
        statusCode: AppConst.undefinedErrorCode,
        errorMessage: ErrorMessages.invalidResponseFormat,
      );
    } catch (e) {
      return ErrorResponse<T>(
        statusCode: AppConst.undefinedErrorCode,
        errorMessage: ErrorMessages.invalidResponseFormat,
      );
    }
  }

  void logError(String title, String details) {
    debugPrint('$title: $details'); // Replace with your preferred logging mechanism
  }
}
