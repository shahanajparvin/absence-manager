import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/repository/absence_manager_repository.dart';
import 'package:absence_manager/domain/usecases/get_absences_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fake_data.dart';
import 'get_absences_usecase_test.mocks.dart';

@GenerateMocks(<Type>[AbsenceManagerRepository])
void main() {
  late MockAbsenceManagerRepository mockRepository;
  late GetAbsencesUseCase useCase;

  setUp(() {
    mockRepository = MockAbsenceManagerRepository();
    useCase = GetAbsencesUseCase(mockRepository);
  });

  group('GetAbsencesUseCase', () {
    test('should return a list of absences when repository call is successful',
        () async {
      final List<Absence> absences = <Absence>[dummyAbsence];

      final ApiResponse<List<Absence>> response =
          SuccessResponse<List<Absence>>(
        statusCode: AppConst.successCode,
        data: absences,
      );

      when(mockRepository.getAbsences()).thenAnswer((_) async => response);

      final ApiResponse<List<Absence>> result = await useCase.execute();

      expect(result.statusCode, AppConst.successCode);
      expect((result as SuccessResponse<List<Absence>>).data, absences);
      verify(mockRepository.getAbsences()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    test('should return an error when repository call fails', () async {
      const ApiResponse<List<Absence>> response = ErrorResponse<List<Absence>>(
        statusCode: AppConst.undefinedErrorCode,
        errorMessage: errorMessage,
      );

      when(mockRepository.getAbsences()).thenAnswer((_) async => response);

      final ApiResponse<List<Absence>> result = await useCase.execute();

      expect(result.statusCode, AppConst.undefinedErrorCode);
      expect(
          (result as ErrorResponse<List<Absence>>).errorMessage, errorMessage);
      verify(mockRepository.getAbsences()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
