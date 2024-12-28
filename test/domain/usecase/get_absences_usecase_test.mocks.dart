// Mocks generated by Mockito 5.4.4 from annotations
// in absence_manager/test/domain/usecase/get_absences_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:absence_manager/core/network/api_response.dart' as _i2;
import 'package:absence_manager/domain/entities/absence/absence.dart' as _i5;
import 'package:absence_manager/domain/entities/member/member.dart' as _i6;
import 'package:absence_manager/domain/repository/absence_manager_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApiResponse_0<T> extends _i1.SmartFake
    implements _i2.ApiResponse<T> {
  _FakeApiResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AbsenceManagerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAbsenceManagerRepository extends _i1.Mock
    implements _i3.AbsenceManagerRepository {
  MockAbsenceManagerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ApiResponse<List<_i5.Absence>>> getAbsences() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAbsences,
          [],
        ),
        returnValue: _i4.Future<_i2.ApiResponse<List<_i5.Absence>>>.value(
            _FakeApiResponse_0<List<_i5.Absence>>(
          this,
          Invocation.method(
            #getAbsences,
            [],
          ),
        )),
      ) as _i4.Future<_i2.ApiResponse<List<_i5.Absence>>>);

  @override
  _i4.Future<_i2.ApiResponse<List<_i6.Member>>> getMembers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getMembers,
          [],
        ),
        returnValue: _i4.Future<_i2.ApiResponse<List<_i6.Member>>>.value(
            _FakeApiResponse_0<List<_i6.Member>>(
          this,
          Invocation.method(
            #getMembers,
            [],
          ),
        )),
      ) as _i4.Future<_i2.ApiResponse<List<_i6.Member>>>);
}
