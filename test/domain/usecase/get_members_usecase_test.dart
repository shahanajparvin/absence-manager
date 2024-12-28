import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/repository/absence_manager_repository.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fake_data.dart';
import 'get_members_usecase_test.mocks.dart';

@GenerateMocks(<Type>[AbsenceManagerRepository])
void main() {
  late MockAbsenceManagerRepository mockRepository;
  late GetMembersUseCase useCase;

  setUp(() {
    mockRepository = MockAbsenceManagerRepository();
    useCase = GetMembersUseCase(mockRepository);
  });

  group('GetMembersUseCase', () {
    test('should return a list of members when repository call is successful',
            () async {
          final List<Member> members = <Member>[dummyMember];

          final ApiResponse<List<Member>> response =
          SuccessResponse<List<Member>>(
            statusCode: AppConst.successCode,
            data: members,
          );

          when(mockRepository.getMembers()).thenAnswer((_) async => response);

          final ApiResponse<List<Member>> result = await useCase.execute();

          expect(result.statusCode, AppConst.successCode);
          expect((result as SuccessResponse<List<Member>>).data, members);
          verify(mockRepository.getMembers()).called(1);
          verifyNoMoreInteractions(mockRepository);
        });

    test('should return an error when repository call fails', () async {
      const ApiResponse<List<Member>> response = ErrorResponse<List<Member>>(
        statusCode: AppConst.undefinedErrorCode,
        errorMessage: dummyErrorMessage,
      );

      when(mockRepository.getMembers()).thenAnswer((_) async => response);

      final ApiResponse<List<Member>> result = await useCase.execute();

      expect(result.statusCode, AppConst.undefinedErrorCode);
      expect(
          (result as ErrorResponse<List<Member>>).errorMessage, dummyErrorMessage);
      verify(mockRepository.getMembers()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
