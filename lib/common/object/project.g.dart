// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project()
  ..id = json['id'] as String
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..managerId = json['managerId'] as String
  ..subManagerId =
      (json['subManagerId'] as List<dynamic>).map((e) => e as String).toList()
  ..type = $enumDecode(_$ProjectTypeEnumMap, json['type'])
  ..state = json['state'] as String
  ..priority = json['priority'] as int
  ..actions = (json['actions'] as List<dynamic>)
      .map((e) => FieldChangeAction.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'managerId': instance.managerId,
      'subManagerId': instance.subManagerId,
      'type': instance.type,
      'state': instance.state,
      'priority': instance.priority,
      'actions': instance.actions,
    };
const _$ProjectTypeEnumMap = {
  ProjectType.Type1: 'Type1',
  ProjectType.Type2: 'Type2',
  ProjectType.Type3: 'Type3',
};