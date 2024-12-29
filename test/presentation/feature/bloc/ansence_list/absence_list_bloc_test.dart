import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_data.dart';
import 'absence_list_bloc_test.mocks.dart';

@GenerateMocks(<Type>[GetAbsencesUseCase, GetMembersUseCase])
void main() {
  late MockGetAbsencesUseCase mockGetAbsencesUseCase;
  late MockGetMembersUseCase mockGetMembersUseCase;
  late AbsenceListBloc absenceListBloc;

  setUp(() {
    mockGetAbsencesUseCase = MockGetAbsencesUseCase();
    mockGetMembersUseCase = MockGetMembersUseCase();
    absenceListBloc = AbsenceListBloc(mockGetAbsencesUseCase, mockGetMembersUseCase);
  });

  tearDown(() {
    absenceListBloc.close();
  });

  group('GetAbsencesWithMembersEvent', () {
     final List<Absence> mockAbsences = <Absence>[dummyAbsence];
     final List<Member> mockMembers = <Member>[dummyMember];

    blocTest<AbsenceListBloc, AbsenceListState>(
      'should emit loading and success states',
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
        return absenceListBloc;
      },
      act: (AbsenceListBloc bloc) => bloc.add(GetAbsencesWithMembersEvent()),
      wait: const Duration(milliseconds: AppConst.delayTime),
      expect: () => <Object>[
        AbsenceLoadingState(),
        isA<AbsenceSuccessState>(),
      ],
      verify: (_) async {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
        },
    );

  });

  group('FetchPaginatedAbsenceEvent', () {
    late  List<Absence> mockAbsences;
    late  List<Member> mockMembers;
    blocTest<AbsenceListBloc, AbsenceListState>(
      'should emit success state with paginated data',
      setUp: () {
        // Setup mock data
        mockAbsences = List<Absence>.generate(
          20,
              (int index) => dummyAbsence,
        );
        mockMembers = List<Member>.generate(
          5,
              (int index) => dummyMember,
        );
      },
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
        return absenceListBloc;
      },
      act: (AbsenceListBloc bloc) => bloc.add( FetchPaginatedAbsenceEvent(10)),
      expect: () => <TypeMatcher<AbsenceSuccessState>>[
        isA<AbsenceSuccessState>().having(
              (AbsenceSuccessState state) => state.absences.length,
          'first page length',
          equals(10),
        ).having(
              (AbsenceSuccessState state) => state.hasMorePages,
          'has more pages',
          isTrue,
        ),
      ],
      verify: (_) {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
      },
    );


    blocTest<AbsenceListBloc, AbsenceListState>(
      'should load next page and append to existing data',
      seed: () => AbsenceSuccessState(
        List<AbsenceListModel>.generate(
          10,
              (int index) => dummyAbsenceListModel,
        ),
        hasMorePages: true,
      ),
      setUp: () {
        // Setup mock data
        mockAbsences = List<Absence>.generate(
          20,
              (int index) => dummyAbsence,
        );
        mockMembers = List<Member>.generate(
          5,
              (int index) => dummyMember,
        );
      },
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
        return absenceListBloc;
      },
      act: (AbsenceListBloc bloc) => bloc.add( FetchPaginatedAbsenceEvent(10)),
      expect: () => <TypeMatcher<AbsenceSuccessState>>[
        isA<AbsenceSuccessState>().having(
              (AbsenceSuccessState state) => state.absences.length,
          'total items after second page',
          equals(20),
        ).having(
              (AbsenceSuccessState state) => state.hasMorePages,
          'no more pages',
          isFalse,
        ),
      ],
      verify: (_) {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
      },
    );

    blocTest<AbsenceListBloc, AbsenceListState>(
      'should emit error state when API call fails',
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
        return absenceListBloc;
      },
      act: (AbsenceListBloc bloc) => bloc.add( FetchPaginatedAbsenceEvent(10)),
      expect: () => <Object>[
        isA<AbsenceErrorState>().having(
              (AbsenceErrorState state) => state.errorMessage, // Access the error message
          'Server error', // Description of the property being checked
          contains('error message'), // Expected condition
        ),
      ],
      verify: (_) {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
      },
    );

    blocTest<AbsenceListBloc, AbsenceListState>(
      'should handle last page correctly',
      setUp: () {
        mockAbsences = List<Absence>.generate(
          15,
              (int index) => dummyAbsence,
        );
      },
      seed: () => AbsenceSuccessState(
        List<AbsenceListModel>.generate(
          10,
              (int index) =>  dummyAbsenceListModel,
        ),
        hasMorePages: true,
      ),
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
        return absenceListBloc;
      },
      act: (AbsenceListBloc bloc) => bloc.add( FetchPaginatedAbsenceEvent(10)),
      expect: () => <TypeMatcher<AbsenceSuccessState>>[
        isA<AbsenceSuccessState>().having(
              (AbsenceSuccessState state) => state.absences.length,
          'total items on last page',
          equals(15),
        ).having(
              (AbsenceSuccessState state) => state.hasMorePages,
          'no more pages',
          isFalse,
        ),
      ],
      verify: (_) {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
      },
    );

  });

  group('SearchAbsencesEvent', () {

    final List<Absence> mockAbsences = <Absence>[dummyAbsence];
    final List<Member> mockMembers = <Member>[dummyMember];
    blocTest<AbsenceListBloc, AbsenceListState>(
      'emits [AbsenceLoadingState, AbsenceSuccessState] with filtered absences',
      build: () {
        when(mockGetAbsencesUseCase.execute()).thenAnswer((_) async => SuccessResponse<List<Absence>>(data: mockAbsences, statusCode: AppConst.successCode));
        when(mockGetMembersUseCase.execute()).thenAnswer((_) async => SuccessResponse<List<Member>>(data: mockMembers,statusCode: AppConst.successCode));
        return absenceListBloc;
      },
      act: (AbsenceListBloc bloc) => bloc.add(SearchAbsencesEvent(searchText: 'jhon')),
      wait: const Duration(milliseconds: AppConst.delayTime),
      expect: () => <Object>[
        AbsenceLoadingState(),
        isA<AbsenceSuccessState>(),
      ],
      verify: (_) {
        verify(mockGetAbsencesUseCase.execute()).called(1);
        verify(mockGetMembersUseCase.execute()).called(1);
      },
    );

  });



}
