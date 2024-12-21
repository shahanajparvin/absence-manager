class AbsenceListModel{
  final int id;
  final String employeeName;
  final String type;
  final String startDate;
  final String endDate;
  final String status;

  AbsenceListModel({
    required this.id,
    required this.employeeName,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  // Placeholder constructor for shimmer effect
  factory AbsenceListModel.placeholder() {
    return AbsenceListModel(
      employeeName: '',
      startDate: '',
      endDate: '',
      status: '',
      type: '',
      id: 0,
    );
  }
}
