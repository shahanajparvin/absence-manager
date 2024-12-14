
import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/repository/absence_manager_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetMembersUseCase {
  final AbsenceManagerRepository _repository;

  GetMembersUseCase(this._repository);

  Future<ApiResponse<List<Member>>> execute() async {
    return await _repository.getMembers();
  }
}