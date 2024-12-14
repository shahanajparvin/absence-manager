import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_view.dart';

class AbsenceAdapter {
  final List<Absence> absences;
  final List<Member> members;

  AbsenceAdapter({required this.absences, required this.members});

  List<AbsenceView> adapt() {

    final memberMap = {for (var member in members) member.crewId: member.name};


    return absences.map((absence) {
      final employeeName = memberMap[absence.crewId] ?? "Unknown";
      final status = absence.confirmedAt != null
          ? "Confirmed"
          : absence.rejectedAt != null
          ? "Rejected"
          : "Pending";

      return AbsenceView(
        employeeName: employeeName,
        type: absence.type!=null?absence.type!:'not defined',
        startDate: absence.startDate!,
        endDate: absence.endDate!,
        status: status, employeeProfile: '',
      );
    }).toList();
  }
}