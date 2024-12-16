import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_view.dart';

class AbsenceListViewAdapter {
  final List<Absence> absences;
  final List<Member> members;

  AbsenceListViewAdapter({required this.absences, required this.members});

  List<AbsenceListView> adapt() {

    final memberMap = {for (var member in members) member.userId: member.name};


    return absences.map((absence) {
      final employeeName = memberMap[absence.userId] ?? "Unknown";
      final status = absence.confirmedAt != null
          ? "Confirmed"
          : absence.rejectedAt != null
          ? "Rejected"
          : "Pending";

      return AbsenceListView(
        employeeName: employeeName,
        type: absence.type!=null?absence.type!:'not defined',
        startDate: absence.startDate!,
        endDate: absence.endDate!,
        status: status
      );
    }).toList();
  }
}