
import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/repository/absence_manager_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetAbsencesUseCase {
  final AbsenceManagerRepository _repository;

  GetAbsencesUseCase(this._repository);

  Future<ApiResponse<List<Absence>>> execute() async {
    return await _repository.getAbsences();
  }
}
