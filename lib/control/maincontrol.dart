import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/project.dart';
import 'package:taskmanagement/common/object/task.dart';
import 'package:taskmanagement/common/object/taskfilter.dart';
import 'package:taskmanagement/common/object/team.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/common/random.dart';

class MainControl {
  static final MainControl _singleton = MainControl._internal();
  factory MainControl() {
    return _singleton;
  }
  MainControl._internal();
  dynamic _data;

  void updateData(dynamic data) {
    _data = data;

    _tableProjects.clear();

    // Convert project
    final dProjects = _data['projects'];
    for (var dProject in dProjects) {
      dProject['id'] = dProject['_id'];
      final pSample = Project();
      final pSampleJson = pSample.toJson();
      for (final sampleKey in pSampleJson.keys) {
        if (dProject.containsKey(sampleKey)) {
          pSampleJson[sampleKey] = dProject[sampleKey];
        }
      }
      final project = Project.fromJson(pSampleJson);
      _tableProjects[project.id] = project;
    }

    // Convert user
    final dUsers = _data['users'];
    for (var dUser in dUsers) {
      dUser['id'] = dUser['_id'];
      final pSample = User();
      final pSampleJson = pSample.toJson();
      for (final sampleKey in pSampleJson.keys) {
        if (dUser.containsKey(sampleKey)) {
          pSampleJson[sampleKey] = dUser[sampleKey];
        }
      }
      final user = User.fromJson(pSampleJson);
      _tableUsers[user.id] = user;
    }

    // Conver team

    final dTeams = _data['teams'];
    for (var dTeam in dTeams) {
      dTeam['id'] = dTeam['_id'];
      final pSample = Team();
      final pSampleJson = pSample.toJson();
      for (final sampleKey in pSampleJson.keys) {
        if (dTeam.containsKey(sampleKey)) {
          pSampleJson[sampleKey] = dTeam[sampleKey];
        }
      }
      final team = Team.fromJson(pSampleJson);
      _tableTeams[team.id] = team;
    }
  }

  // Trả về danh sách project theo thứ tự ưu tiên
  List<Project> projectList() {
    final l = _tableProjects.values.toList();
    // final l = _tableProjects;
    l.sort((a, b) => a.priority.compareTo(b.priority));
    return l;
  }

  List<TaskType> taskTypeList() {
    return [TaskType.ork, TaskType.task, TaskType.subtask];
  }

  List<TaskState> taskStateList() {
    return [
      TaskState.init,
      TaskState.normal,
      TaskState.done,
      TaskState.expired,
      TaskState.deleted
    ];
  }

  List<User> userList() {
    final l = _tableUsers.values.toList();
    l.sort((a, b) => a.name.compareTo(b.name));
    return l;
  }

  User? getUserById(String id) {
    if (_tableUsers.containsKey(id)) {
      return _tableUsers[id];
    } else {
      return null;
    }
  }

  List<Team> teamList() {
    final l = _tableTeams.values.toList();
    l.sort((a, b) => a.name.compareTo(b.name));
    return l;
  }

  Team? getTeamById(String id) {
    if (_tableTeams.containsKey(id)) {
      return _tableTeams[id];
    } else {
      return null;
    }
  }

  Future<bool> applyFilter(TaskFilter filter) async {
    return true;
  }

  String createRandomTaskID() {
    return getRandomString(5);
  }

  String createRandomProjectID() {
    return getRandomString(5);
  }


  User myUser() => _myUser;

  final User _myUser = myUserSample;
  final Map<String, Project> _tableProjects = projectListSample;
  final Map<String, User> _tableUsers = userSampleList;
  final Map<String, Team> _tableTeams = teamSample;
}
