
const int nullIndex = -1;


class AlarmCount {
  bool ok = true;
  int high = 0;
  int med = 0;
  int low = 0;
  int get total => high + med + low;
}


enum TaskListViewType { list, grantt, kanban }

String taskListViewTypeToString(TaskListViewType type) {
  switch (type) {
    case TaskListViewType.list:
      return 'Danh sách';
    case TaskListViewType.grantt:
      return 'Biểu đồ gantt';
    case TaskListViewType.kanban:
      return 'Kanban';
  }
}

enum EditorType {
  creator,
  editor
}
