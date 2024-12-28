
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';

final Absence dummyAbsence = Absence(
  admitterId: 123,
  admitterNote: 'Approved by supervisor',
  confirmedAt: '2024-12-20T10:30:00Z',
  createdAt: '2024-12-18T08:45:00Z',
  crewId: 42,
  endDate: '2024-12-25T17:00:00Z',
  id: 1,
  memberNote: 'Family vacation',
  startDate: '2024-12-22T09:00:00Z',
  type: 'Vacation',
  userId: 456,
);

final Member dummyMember = Member(
  crewId: 1,
  id: 101,
  image: 'https://example.com/images/member101.jpg',
  name: 'John Doe',
  userId: 1001,
);

final AbsenceListModel dummyAbsenceListModel = AbsenceListModel(
id: 1,
employeeName: 'John Doe',
type: 'Sick Leave',
startDate: '2024-12-01',
endDate: '2024-12-05',
status: 'Approved',
);

const String dummyErrorMessage = 'Failed to fetch absences';