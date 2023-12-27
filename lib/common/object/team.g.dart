// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team()
  ..id = json['id'] as String
  ..name = json['name'] as String
  ..leaderId = json['leaderId'] as String
  ..actions = (json['actions'] as List<dynamic>)
      .map((e) => FieldChangeAction.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'leaderId': instance.leaderId,
      'actions': instance.actions,
    };
