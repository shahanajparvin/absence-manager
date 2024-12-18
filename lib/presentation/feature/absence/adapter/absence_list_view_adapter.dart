import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';

class AbsenceListViewAdapter {
  final List<Absence> absences;
  final List<Member> members;

  AbsenceListViewAdapter({required this.absences, required this.members});

  List<AbsenceListModel> adapt() {
    final Map<int, String> memberMap  = _createMemberMap();
    return absences.map((Absence absence) {
      return AbsenceListModel(
        id: absence.id,
        employeeName: _getEmployeeName(memberMap, absence.userId),
        type: absence.type!=null?absence.type!:'Not defined',
        startDate: absence.startDate!,
        endDate: absence.endDate!,
        status: _getAbsenceStatus(absence),
      );
    }).toList();
  }

  Map<int, String> _createMemberMap(){
    final Map<int, String> memberMap = {for (final Member member in members) member.userId: member.name};
    return memberMap;
  }


  String _getEmployeeName( Map<int, String> memberMap, int userId){
    final String employeeName = memberMap[userId] ?? "Unknown";
    return employeeName;
  }

  String _getAbsenceStatus(Absence absence) {
    if (absence.confirmedAt != null) {
      return "Confirmed";
    } else if (absence.rejectedAt != null) {
      return "Rejected";
    } else {
      return "Pending";
    }
  }

}