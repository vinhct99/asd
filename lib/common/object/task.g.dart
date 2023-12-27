// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) => Evaluation()
  ..author = json['author'] as String
  ..keyResult = json['keyResult'] as String
  ..effortScore = (json['effortScore'] as num).toDouble()
  ..score = (json['score'] as num).toDouble();

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'author': instance.author,
      'keyResult': instance.keyResult,
      'effortScore': instance.effortScore,
      'score': instance.score,
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task()
  ..type = $enumDecode(_$TaskTypeEnumMap, json['type'])
  ..id = json['id'] as String
  ..parentId = json['parentId'] as String
  ..projectId = json['projectId'] as String
  ..assignee = json['assignee'] as String
  ..author = json['author'] as String
  ..creator = json['creator'] as String
  ..timeCreated = json['timeCreated'] as int
  ..expertises =
      (json['expertises'] as List<dynamic>).map((e) => e as String).toList()
  ..name = json['name'] as String
  ..content = json['content'] as String
  ..target = json['target'] as String
  ..keyResult = json['keyResult'] as String
  ..manhour = json['manhour'] as int
  ..standardManhour = json['standardManhour'] as int
  ..startDate = json['startDate'] as int
  ..dueDate = json['dueDate'] as int
  ..timeComplete = json['timeComplete'] as int
  ..state = $enumDecode(_$TaskStateEnumMap, json['state'])
  ..progressDescription = json['progressDescription'] as String
  ..progressPercent = (json['progressPercent'] as num).toDouble()
  ..impactEvaluation = json['impactEvaluation'] as bool
  ..resultIds =
      (json['resultIds'] as List<dynamic>).map((e) => e as String).toList()
  ..evaluations = (json['evaluations'] as List<dynamic>)
      .map((e) => Evaluation.fromJson(e as Map<String, dynamic>))
      .toList()
  ..customFields =
      (json['customFields'] as List<dynamic>).map((e) => e as String).toList()
  ..actions = (json['actions'] as List<dynamic>)
      .map((e) => FieldChangeAction.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'type': _$TaskTypeEnumMap[instance.type]!,
      'id': instance.id,
      'parentId': instance.parentId,
      'projectId': instance.projectId,
      'assignee': instance.assignee,
      'author': instance.author,
      'creator': instance.creator,
      'timeCreated': instance.timeCreated,
      'expertises': instance.expertises,
      'name': instance.name,
      'content': instance.content,
      'target': instance.target,
      'keyResult': instance.keyResult,
      'manhour': instance.manhour,
      'standardManhour': instance.standardManhour,
      'startDate': instance.startDate,
      'dueDate': instance.dueDate,
      'timeComplete': instance.timeComplete,
      'state': _$TaskStateEnumMap[instance.state]!,
      'progressDescription': instance.progressDescription,
      'progressPercent': instance.progressPercent,
      'impactEvaluation': instance.impactEvaluation,
      'resultIds': instance.resultIds,
      'evaluations': instance.evaluations,
      'customFields': instance.customFields,
      'actions': instance.actions,
    };

const _$TaskTypeEnumMap = {
  TaskType.undefined: 'undefined',
  TaskType.ork: 'ork',
  TaskType.task: 'task',
  TaskType.subtask: 'subtask',
};

const _$TaskStateEnumMap = {
  TaskState.init: 'init',
  TaskState.normal: 'normal',
  TaskState.expired: 'expired',
  TaskState.done: 'done',
  TaskState.deleted: 'deleted',
};
