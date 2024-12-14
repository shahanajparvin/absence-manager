import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';

abstract class AbsenceManagerRepository {

  Future<ApiResponse<List<Absence>>> getAbsences();

  Future<ApiResponse<List<Member>>> getMembers();
}
