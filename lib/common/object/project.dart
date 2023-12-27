import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanagement/common/object/fieldchangeaction.dart';
import 'package:http/http.dart' as http;
// dart run build_runner build --delete-conflicting-outputs
part 'project.g.dart';

enum ProjectType { Type1, Type2, Type3 }

String projectTypeToString(ProjectType type) {
  switch (type) {
    case ProjectType.Type1:
      return 'Type1';
    case ProjectType.Type2:
      return 'Type2';
    case ProjectType.Type3:
      return 'Type3';
  }
}

@JsonSerializable()
class Project {
  Project();
  String id = '';
  String name = '';
  String description = '';
  String managerId = '';
  List<String> subManagerId = [];

  //String type = '';
  ProjectType type = ProjectType.Type1;
  String state = '';
  int priority = 0;

  List<FieldChangeAction> actions = [];

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson2(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
//   Future<Project> fetchProject() async {
//   Map<String, String> userHeader = {
//     "Access-Control-Allow-Origin": "*",
//     'Content-Type': 'application/json',
//     'Accept': '*/*',
//     'ngrok-skip-browser-warning': '1111'
//   };
//   var uri = Uri.https('200a-203-113-138-21.ngrok-free.app', 'api/projects');

//   final response = await http.get(uri, headers: userHeader);
//   if (response.statusCode == 200) {
//     return Project.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     throw Exception('Failed to load project');
//   }
// }
Project _$ProjectFromJson2(Map<String, dynamic> json) {
  return Project()
    ..id = json['_id'] as String
    ..name = json['name'] as String
    ..description =
        json.containsKey('description') ? json['description'] as String : '';
}

Future<List<Project>> fetchProject() async {
  Map<String, String> userHeader = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'ngrok-skip-browser-warning': '1111'
  };
  var uri = Uri.https('200a-203-113-138-21.ngrok-free.app', 'api/projects');

  final response = await http.get(uri, headers: userHeader);
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<Project>.from(l.map((model) => Project.fromJson(model)));
  } else {
    throw Exception('Failed to load project');
  }
}

// class Project {

//   final String id ;
//   final String name ;
//   final String description ;
//   final String managerId ;
//   final List<String> subManagerId ;
//   final String type ;
//   final String state;
//   final int priority;
//   const Project({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.managerId,
//     required this.subManagerId,
//     required this.type,
//     required this.state,
//     required this.priority,
//   });

//   factory Project.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'userId': int userId,
//         'id': int id,
//         'title': String title,
//       } =>
//         Project(
//           id: id,
//           id: id,
//           title: title,
//         ),
//       _ => throw const FormatException('Failed to load Project.'),
//     };
//   }
// }

// List<Project> projectListSamplee = [
//   Project()
//     ..id = "veac"
//     ..name = "VEA-C"
//     ..description = 'Hệ thống trinh sát chế áp UAV'
//     ..managerId = 'PhuPD2'
//     ..subManagerId = ["LongDV9", "BinhNT42"]
//     ..type = 'Type1'
//     ..priority = 1
//     ..state = 'Normal',
//   Project()
//     ..id = "velint18"
//     ..name = "VELINT18"
//     ..description = "Hệ thống trinh sát thụ động"
//     ..managerId = 'TungDM'
//     ..type = '123'
//     ..priority = 5
//     ..state = 'Normal',
//   Project()
//     ..id = "wbhf"
//     ..name = "WBHF"
//     ..description = "Hệ thống liên lạc sóng ngắn"
//     ..managerId = 'ThanhDD9'
//     ..type = '123'
//     ..priority = 2
//     ..state = 'Normal',
//   Project()
//     ..id = "vsm3"
//     ..name = "VSM3"
//     ..description = "Hệ thống liên lạc"
//     ..managerId = 'PhuPD2'
//     ..type = '123'
//     ..priority = 4
//     ..state = 'Normal',
// ];

final projectListSample = {
  "VEAC": Project()
    ..id = "VEAC"
    ..name = "VEA-C"
    ..description = 'Hệ thống trinh sát chế áp UAV'
    ..managerId = 'PhuPD2'
    ..subManagerId = ["LongDV9", "BinhNT42"]
    //..type = 'Type1'
    ..type = ProjectType.Type1
    ..priority = 1
    ..state = 'Normal',
  "VELINT18": Project()
    ..id = "VELINT18"
    ..name = "VELINT-18"
    ..description = "Hệ thống trinh sát thụ động"
    ..managerId = 'TungDM'
    //..type = '123'
    ..type = ProjectType.Type1
    ..priority = 3
    ..state = 'Normal',
  "WBHF": Project()
    ..id = "WBHF"
    ..name = "WBH-F"
    ..description = "Hệ thống liên lạc sóng ngắn"
    ..managerId = 'ThanhDD9'
    // ..type = '123'
    ..type = ProjectType.Type2
    ..priority = 2
    ..state = 'Normal',
  "VSM3": Project()
    ..id = "VSM3"
    ..name = "VSM-3"
    ..description = "Hệ thống liên lạc"
    // ..type = '123'
    ..type = ProjectType.Type3
    ..priority = 4
    ..state = 'Normal',
};
