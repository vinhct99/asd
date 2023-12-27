// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as String
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..number = json['number'] as int
  ..timeJoin = json['timeJoin'] as int
  ..jobTitle = json['jobTitle'] as String
  ..teamId = json['teamId'] as String
  ..position = $enumDecode(_$JobPositionEnumMap, json['position'])
  ..projectOwnList =
      (json['projectOwnList'] as List<dynamic>).map((e) => e as String).toList()
  ..state = $enumDecode(_$UserStateEnumMap, json['state'])
  ..customFields =
      (json['customFields'] as List<dynamic>).map((e) => e as String).toList()
  ..actions = (json['actions'] as List<dynamic>)
      .map((e) => FieldChangeAction.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'number': instance.number,
      'timeJoin': instance.timeJoin,
      'jobTitle': instance.jobTitle,
      'teamId': instance.teamId,
      'position': _$JobPositionEnumMap[instance.position]!,
      'projectOwnList': instance.projectOwnList,
      'state': _$UserStateEnumMap[instance.state]!,
      'customFields': instance.customFields,
      'actions': instance.actions,
    };

const _$JobPositionEnumMap = {
  JobPosition.staff: 'staff',
  JobPosition.leader: 'leader',
  JobPosition.director: 'director',
  JobPosition.pa: 'pa',
  JobPosition.admin: 'admin',
};

const _$UserStateEnumMap = {
  UserState.intern: 'intern',
  UserState.normal: 'normal',
  UserState.quit: 'quit',
  UserState.outsource: 'outsource',
};
