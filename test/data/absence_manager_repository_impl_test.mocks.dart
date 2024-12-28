// Mocks generated by Mockito 5.4.4 from annotations
// in absence_manager/test/data/absence_manager_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:absence_manager/core/network/api_exceptions.dart' as _i5;
import 'package:absence_manager/core/network/api_response.dart' as _i2;
import 'package:api/api.dart' as _i3;
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

class _FakeApiResponse_0<T1> extends _i1.SmartFake
    implements _i2.ApiResponse<T1> {
  _FakeApiResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Api].
///
/// See the documentation for Mockito's code generation for more information.
class MockApi extends _i1.Mock implements _i3.Api {
  MockApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<dynamic>?> absences() => (super.noSuchMethod(
        Invocation.method(
          #absences,
          [],
        ),
        returnValue: _i4.Future<List<dynamic>?>.value(),
      ) as _i4.Future<List<dynamic>?>);

  @override
  _i4.Future<List<dynamic>?> members() => (super.noSuchMethod(
        Invocation.method(
          #members,
          [],
        ),
        returnValue: _i4.Future<List<dynamic>?>.value(),
      ) as _i4.Future<List<dynamic>?>);
}

/// A class which mocks [ApiExceptionHandlingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiExceptionHandlingService extends _i1.Mock
    implements _i5.ApiExceptionHandlingService {
  MockApiExceptionHandlingService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ApiResponse<T>> handleApiCall<T>(
          _i4.Future<_i2.ApiResponse<T>> Function()? apiCall) =>
      (super.noSuchMethod(
        Invocation.method(
          #handleApiCall,
          [apiCall],
        ),
        returnValue: _i4.Future<_i2.ApiResponse<T>>.value(_FakeApiResponse_0<T>(
          this,
          Invocation.method(
            #handleApiCall,
            [apiCall],
          ),
        )),
      ) as _i4.Future<_i2.ApiResponse<T>>);

  @override
  void logError(
    String? title,
    String? details,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #logError,
          [
            title,
            details,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
