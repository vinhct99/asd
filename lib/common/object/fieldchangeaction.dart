import 'package:json_annotation/json_annotation.dart';

part 'fieldchangeaction.g.dart';

@JsonSerializable()
class Field {
  Field();
  String fieldName = '';
  String oldValue = '';
  String newValue = '';

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
  
}

@JsonSerializable()
class FieldChangeAction {
  FieldChangeAction();
  int time = 0;
  String updaterId = '';
  List<Field> fields = [];
  factory FieldChangeAction.fromJson(Map<String, dynamic> json) => _$FieldChangeActionFromJson(json);

  Map<String, dynamic> toJson() => _$FieldChangeActionToJson(this);
}