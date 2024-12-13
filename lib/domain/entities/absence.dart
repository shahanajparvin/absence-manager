import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence.freezed.dart';
part 'absence.g.dart';

@freezed
class Absence with _$Absence {
  factory Absence({
     String? admitterId,
     required String admitterNote,
     required String confirmedAt,
     required String createdAt,
     required int crewId,
     required String endDate,
     required int id,
     required String memberNote,
     String? rejectedAt,
     required String startDate,
     required String type,
     required int userId,
  }) = _Absence;

  factory Absence.fromJson(Map<String, Object?> json) =>
      _$AbsenceFromJson(json);
}
