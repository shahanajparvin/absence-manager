import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import '../../../../fake_data.dart';
import 'absence_detail_bloc_test.mocks.dart';


@GenerateMocks(<Type>[GetAbsencesUseCase, GetMembersUseCase])
void main() {
  late MockGetAbsencesUseCase mockGetAbsencesUseCase;
  late MockGetMembersUseCase mockGetMembersUseCase;
  late AbsenceDetailBloc absenceDetailBloc;

  setUp(() {
    mockGetAbsencesUseCase = MockGetAbsencesUseCase();
    mockGetMembersUseCase = MockGetMembersUseCase();
    absenceDetailBloc = AbsenceDetailBloc(mockGetAbsencesUseCase, mockGetMembersUseCase);
  });

  tearDown(() {
    absenceDetailBloc.close();
  });

  group('FetchAbsenceDetailEvent', () {
    final List<Absence> mockAbsences = <Absence>[dummyAbsence];
    final List<Member> mockMembers = <Member>[dummyMember];

    blocTest<AbsenceDetailBloc, AbsenceDetailState>(
      'should emit loading and success states with absence details',
      build: () {
        when(mockGetAbsencesUseCase.execute())
            .thenAnswer((_) async => SuccessResponse<List<Absence>>(
          statusCode: AppConst.successCode,
          data: mockAbsences,
        ));
        when(mockGetMembersUseCase.execute())
            .thenAnswer((_) async => SuccessResponse<List<Member>>(
          statusCode: AppConst.successCode,
          data: mockMembers,
        ));
        return absenceDetailBloc;
      },
      act: (AbsenceDetailBloc bloc) =>
          bloc.add(FetchAbsenceDetailsEvent(1)),
      expect: () => <Object>[
        isA<AbsenceDetailLoadingState>(),
        isA<AbsenceDetailSuccessState>(),
      ],
      verify: (_) async {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
      },
    );

    blocTest<AbsenceDetailBloc, AbsenceDetailState>(
      'should emit error state when fetching details fails',
      build: () {
        when(mockGetAbsencesUseCase.execute())
            .thenAnswer((_) async => const ErrorResponse<List<Absence>>(
          statusCode: 500,
          message: 'Server error', errorMessage: 'error message',
        ));
        when(mockGetMembersUseCase.execute())
            .thenAnswer((_) async => SuccessResponse<List<Member>>(
          statusCode: AppConst.successCode,
          data: mockMembers,
        ));
        return absenceDetailBloc;
      },
      act: (AbsenceDetailBloc bloc) =>
          bloc.add(FetchAbsenceDetailsEvent(1)),
      expect: () => <Object>[
        isA<AbsenceDetailLoadingState>(),
        isA<AbsenceDetailErrorState>(),
      ],
      verify: (_) {
        verify(mockGetAbsencesUseCase.execute()).called(1);
      },
    );
  });
}
