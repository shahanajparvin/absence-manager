
import 'package:absence_manager/domain/entities/absence/absence.dart';

final Absence dummyAbsence = Absence(
  admitterId: 123,
  admitterNote: "Approved by supervisor",
  confirmedAt: "2024-12-20T10:30:00Z",
  createdAt: "2024-12-18T08:45:00Z",
  crewId: 42,
  endDate: "2024-12-25T17:00:00Z",
  id: 1,
  memberNote: "Family vacation",
  rejectedAt: null,
  startDate: "2024-12-22T09:00:00Z",
  type: "Vacation",
  userId: 456,
);

const String errorMessage = 'Failed to fetch absences';