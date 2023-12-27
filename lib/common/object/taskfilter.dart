import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanagement/common/object/task.dart';

// part 'taskfilter.g.dart';

// @JsonSerializable()
class TaskFilter {
  TaskFilter();
  String keyword = '';
  List<String> projects = [];
  List<TaskType> types = [];
  List<TaskState> states = [];
  List<String> assignees = [];
  List<String> teams = [];
  List<String> authors = [];
  bool isAllTime = true;
  //DateTimeRange? timeRange;
  DateTimeRange timeRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 10)),
      end: DateTime.now());
}
