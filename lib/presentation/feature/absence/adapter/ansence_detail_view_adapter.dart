import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';


class AbsenceDetailViewAdapter {
  final Absence absence;
  final Member member;

  AbsenceDetailViewAdapter({required this.absence, required this.member});

  AbsenceDetailModel adapt() {
    return AbsenceDetailModel(
        employeeName: member.name,
        type: absence.type!=null?absence.type!:'not defined',
        startDate: absence.startDate!,
        endDate: absence.endDate!,
        status: _getAbsenceStatus(absence),
        employeeProfile: member.image,
        admitterNote: absence.admitterNote!=null?absence.admitterNote!:'',
        memberNote: absence.memberNote!=null?absence.memberNote!:'',
      );

  }


  String _getAbsenceStatus(Absence absence) {
    if (absence.confirmedAt != null) {
      return 'Confirmed';
    } else if (absence.rejectedAt != null) {
      return 'Rejected';
    } else {
      return 'Pending';
    }
  }

}