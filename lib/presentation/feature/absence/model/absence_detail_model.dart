class AbsenceDetailModel{
  final String employeeName;
  final String employeeProfile;
  final String type;
  final String startDate;
  final String endDate;
  final String status;
  final String admitterNote;
  final String memberNote;

  AbsenceDetailModel( {
    required this.employeeName,
    required this.employeeProfile,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.admitterNote,
    required this.memberNote,
  });
}
