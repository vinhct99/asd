
import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanagement/common/object/fieldchangeaction.dart';

// dart run build_runner build --delete-conflicting-outputs
part 'team.g.dart';
class Expertise {
  String id = '';
  String name = '';
}

final expertiseSample = {
  'sw': Expertise() ..id = 'sw' ..name = 'Phần mềm',
  'hw': Expertise() ..id = 'hw' ..name = 'Phần cứng số'
};


/// Thông tin về một nhóm bất kỳ
@JsonSerializable()
class Team {
  Team();

  String id = '';

  String name = '';

  String leaderId = '';

  // List<Expertise> expertise = [];

  /// Lưu lại các thay đổi
  List<FieldChangeAction> actions = [];

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

final teamSample = {
  'pmpc': Team()
    ..id = 'pmpc'
    ..name = 'Phần mềm PC'
    ..leaderId = 'KhaiNV9',
  'fpga': Team()
    ..id = 'fpga'
    ..name = 'FPGA'
    ..leaderId = 'ThoNV10',
  'hw1': Team()
    ..id = 'hw1'
    ..name = 'Phần cứng số 1'
    ..leaderId = 'NghiaDT4'
    
};