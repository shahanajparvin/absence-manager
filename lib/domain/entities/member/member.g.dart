// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      crewId: (json['crewId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      image: json['image'] as String,
      name: json['name'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'crewId': instance.crewId,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'userId': instance.userId,
    };
