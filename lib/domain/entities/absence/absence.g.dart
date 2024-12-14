// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbsenceImpl _$$AbsenceImplFromJson(Map<String, dynamic> json) =>
    _$AbsenceImpl(
      admitterId: (json['admitterId'] as num?)?.toInt(),
      admitterNote: json['admitterNote'] as String?,
      confirmedAt: json['confirmedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      crewId: (json['crewId'] as num).toInt(),
      endDate: json['endDate'] as String?,
      id: (json['id'] as num).toInt(),
      memberNote: json['memberNote'] as String?,
      rejectedAt: json['rejectedAt'] as String?,
      startDate: json['startDate'] as String?,
      type: json['type'] as String?,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$AbsenceImplToJson(_$AbsenceImpl instance) =>
    <String, dynamic>{
      'admitterId': instance.admitterId,
      'admitterNote': instance.admitterNote,
      'confirmedAt': instance.confirmedAt,
      'createdAt': instance.createdAt,
      'crewId': instance.crewId,
      'endDate': instance.endDate,
      'id': instance.id,
      'memberNote': instance.memberNote,
      'rejectedAt': instance.rejectedAt,
      'startDate': instance.startDate,
      'type': instance.type,
      'userId': instance.userId,
    };
