// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fieldchangeaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field()
  ..fieldName = json['fieldName'] as String
  ..oldValue = json['oldValue'] as String
  ..newValue = json['newValue'] as String;

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'fieldName': instance.fieldName,
      'oldValue': instance.oldValue,
      'newValue': instance.newValue,
    };

FieldChangeAction _$FieldChangeActionFromJson(Map<String, dynamic> json) =>
    FieldChangeAction()
      ..time = json['time'] as int
      ..updaterId = json['updaterId'] as String
      ..fields = (json['fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FieldChangeActionToJson(FieldChangeAction instance) =>
    <String, dynamic>{
      'time': instance.time,
      'updaterId': instance.updaterId,
      'fields': instance.fields,
    };
