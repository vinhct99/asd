


import 'package:taskmanagement/common/object/task.dart';

class TaskControl {
  static final TaskControl _singleton = TaskControl._internal();
  factory TaskControl() {
    return _singleton;
  }
  TaskControl._internal();

  void addTask(Task task){

  }

  void editTask(int id){}

  //List<Task> _currentTaskList = taskListSample;

}