import 'package:absence_manager/core/network/api_exceptions.dart';
import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/network/error_messages.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/repository/absence_manager_repository.dart';
import 'package:api/api.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AbsenceManagerRepository)
class AbsenceManagerRepositoryImpl extends AbsenceManagerRepository {

  final Api api;
  final ApiExceptionHandlingService apiExceptionHandlingService;

  AbsenceManagerRepositoryImpl(this.api, this.apiExceptionHandlingService);

  @override
  Future<ApiResponse<List<Absence>>> getAbsences() async {
    return apiExceptionHandlingService.handleApiCall(() async {
      final List<dynamic>? data = await api.absences();
      print('data' +data.toString());
      if (data != null && data.isNotEmpty) {
        final List<Absence> absenceList = data.map((dynamic json) {
          return Absence.fromJson(json as Map<String, dynamic>);
        }).toList();
        return SuccessResponse<List<Absence>>(
          statusCode: AppConst.successCode,
          data: absenceList,
        );
      } else {
        return const ErrorResponse<List<Absence>>(
          statusCode: AppConst.undefinedErrorCode,
          errorMessage: ErrorMessages.generalError,
        );
      }
    });
  }

  @override
  Future<ApiResponse<List<Member>>> getMembers() async {
    return apiExceptionHandlingService.handleApiCall(() async {
      final List<dynamic>? data = await api.members();
      if (data != null && data.isNotEmpty) {
        final List<Member> members = data.map((dynamic json) {
          return Member.fromJson(json as Map<String, dynamic>);
        }).toList();
        return SuccessResponse<List<Member>>(
          statusCode: AppConst.successCode,
          data: members,
        );
      } else {
        return const ErrorResponse<List<Member>>(
          statusCode: AppConst.undefinedErrorCode,
          errorMessage: ErrorMessages.generalError,
        );
      }
    });
  }
}
