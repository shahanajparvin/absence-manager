import 'package:mockito/annotations.dart';
import 'package:api/api.dart';
import 'package:absence_manager/core/data/repository/absence_manager_repository_impl.dart';
import 'package:absence_manager/core/network/api_exceptions.dart';
import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/network/error_messages.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'absence_manager_repository_impl_test.mocks.dart';

@GenerateMocks(<Type>[Api, ApiExceptionHandlingService])
void main() {
  late MockApi mockApi;
  late MockApiExceptionHandlingService mockExceptionHandler;
  late AbsenceManagerRepositoryImpl repository;

  setUp(() {
    mockApi = MockApi();
    mockExceptionHandler = MockApiExceptionHandlingService();
    repository = AbsenceManagerRepositoryImpl(mockApi, mockExceptionHandler);
  });

  group('getAbsences', () {
    final List<dynamic> mockAbsenceData = <dynamic>[
      <String, Object?>{ "admitterId": null,
        "admitterNote": "",
        "confirmedAt": "2020-12-12T18:03:55.000+01:00",
        "createdAt": "2020-12-12T14:17:01.000+01:00",
        "crewId": 352,
        "endDate": "2021-01-13",
        "id": 2351,
        "memberNote": "",
        "rejectedAt": null,
        "startDate": "2021-01-13",
        "type": "sickness",
        "userId": 2664}
    ];

    test('should return success response with absences when API call succeeds', () async {
      when(mockApi.absences()).thenAnswer((_) async => mockAbsenceData);

      final List<Absence> absenceList = mockAbsenceData.map((dynamic json) {
        return Absence.fromJson(json as Map<String, dynamic>);
      }).toList();

      final ApiResponse<List<Absence>> success = SuccessResponse<List<Absence>>(
        statusCode: AppConst.successCode,
        data: absenceList,
      );

      when(mockExceptionHandler.handleApiCall(any)).thenAnswer(
            (Invocation invocation) async => success,
      );

      final ApiResponse<List<Absence>> result = await repository.getAbsences();

      expect(result, isA<SuccessResponse<List<Absence>>>());
      final SuccessResponse<List<Absence>> successResult = result as SuccessResponse<List<Absence>>;
      expect(successResult.statusCode, AppConst.successCode);
      expect(successResult.data!.length, 1);
      expect(successResult.data![0].id, 2351);

    });

    test('should return error response when API returns empty data', () async {
      when(mockApi.absences()).thenAnswer((_) async => <ErrorResponse>[]);

      const ApiResponse<List<Absence>> error =  ErrorResponse<List<Absence>>(
        statusCode: AppConst.undefinedErrorCode,
        errorMessage: ErrorMessages.generalError,
      );
      when(mockExceptionHandler.handleApiCall(any)).thenAnswer(
            (Invocation invocation) async => error,
      );

      final ApiResponse<List<Absence>> result = await repository.getAbsences();

      expect(result, isA<ErrorResponse<List<Absence>>>());
      final ErrorResponse<List<Absence>> errorResult = result as ErrorResponse<List<Absence>>;
      expect(errorResult.statusCode, AppConst.undefinedErrorCode);
      expect(errorResult.errorMessage, ErrorMessages.generalError);
    });
  });

 group('getMembers', () {
    final List<dynamic> mockMemberData = <dynamic>[
      <String, Object>{
        "crewId": 352,
        "id": 709,
        "image": "https://loremflickr.com/300/400",
        "name": "Max",
        "userId": 644
      },
      <String, Object>{
        "crewId": 352,
        "id": 709,
        "image": "https://loremflickr.com/300/400",
        "name": "Max",
        "userId": 644
      },
    ];

    test('should return success response with members when API call succeeds', () async {

      when(mockApi.members()).thenAnswer((_) async => mockMemberData);

      final List<Member> members = mockMemberData.map((dynamic json) {
        return Member.fromJson(json as Map<String, dynamic>);
      }).toList();

      final ApiResponse<List<Member>> successResponse = SuccessResponse<List<Member>>(
        statusCode: AppConst.successCode,
        data: members,
      );

      when(mockExceptionHandler.handleApiCall(any)).thenAnswer(
            (Invocation invocation) async => successResponse,
      );

      final ApiResponse<List<Member>> result = await repository.getMembers();

      expect(result, isA<SuccessResponse<List<Member>>>());
      final SuccessResponse<List<Member>> successResult = result as SuccessResponse<List<Member>>;
      expect(successResult.statusCode, AppConst.successCode);
      expect(successResult.data!.length, 2);
      expect(successResult.data![0].id, 709);
    });

    test('should return error response when API returns empty data', () async {
      when(mockApi.members()).thenAnswer((_) async => <dynamic>[]);

      const ApiResponse<List<Member>> errorResponse =  ErrorResponse<List<Member>>(
        statusCode: AppConst.undefinedErrorCode,
        errorMessage: ErrorMessages.generalError,
      );

      when(mockExceptionHandler.handleApiCall(any)).thenAnswer(
            (Invocation invocation) async => errorResponse,
      );

      final ApiResponse<List<Member>> result = await repository.getMembers();
      expect(result, isA<ErrorResponse<List<Member>>>());
      final ErrorResponse<List<Member>> errorResult = result as ErrorResponse<List<Member>>;
      expect(errorResult.statusCode, AppConst.undefinedErrorCode);
      expect(errorResult.errorMessage, ErrorMessages.generalError);

    });
  });
}


