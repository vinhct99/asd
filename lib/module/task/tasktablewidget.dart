import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/task.dart';

class TaskTableWidget extends StatefulWidget {
  final List<Task> taskList;
  final List<String> selectedList;

  const TaskTableWidget(
      {super.key,
      required this.taskList,
      required this.selectedList,
      required double height});

  @override
  State<TaskTableWidget> createState() => _TaskTableWidgetState();
}

class _TaskTableWidgetState extends State<TaskTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> _columnHeaders = [
    '',
    'ID \nDự án',
    'Dự án',
    'Nội dung nhiệm vụ',
    'Mục tiêu',
    'Loại \n nhiệm vụ',
    'Số giờ đối \nvới người\nthực hiện',
    'Ước lượng\nMan-Hour đối\nvới người được giao',
    'Người giao',
    'Người thực hiện',
    'Trạng thái',
    'Bắt đầu',
    'Kết thúc',
    // 'Mô tả \ntrạng thái \n đang hoàn thiện',
    // 'Mô tả % \ntrạng thái \n đang hoàn thiện',
    'Tiêu chí Key \n của nhiệm vụ'
  ];

  List<DataCell> _rowIndextoCellList(int row) {
    final task = widget.taskList[row];
    return [
      _checkBoxCell(row, task),
      _buttonControlCell(task.id),
      _projectCell(task.projectId),
      _nameCell(task.name),
      _shortContentCell(task.content),
      _typeCell(task.type),
      _manHourCell(task.manhour),
      _standardManhourCell(task.standardManhour),
      _authorCell(task.author),
      _assigneeCell(task.assignee),
      _stateCell(task.state),
      _startDateCell(task.startDate),
      _dueDateCell(task.dueDate),
      // _progressDescriptionCell(task.progressDescription),
      // _progressPercentCell(task.progressPercent),
      _keyResultCell(task.keyResult),
    ];
  }

  DataCell _checkBoxCell(int row, task) {
    return DataCell(
      Checkbox(
        value: widget.selectedList.contains(task.id),
        onChanged: (value) {
          setState(() {
            if (value ?? false) {
              widget.selectedList.add(task.id);
            } else {
              widget.selectedList.remove(task.id);
            }
          });
        },
      ),
    );
  }

  DataCell _typeCell(TaskType type) {
    return DataCell(Text(taskTypeToString(type)));
  }

  DataCell _projectCell(String projectId) {
    return DataCell(Text(projectId));
  }

  DataCell _nameCell(String name) {
    return DataCell(SelectableText(name));
  }

  DataCell _assigneeCell(String assignee) {
    return DataCell(Text(assignee));
  }

  DataCell _authorCell(String author) {
    return DataCell(Text(author));
  }

  DataCell _manHourCell(int manhour) {
    return DataCell(Text("$manhour"));
  }

  DataCell _standardManhourCell(int standardManhour) {
    return DataCell(Text("$standardManhour"));
  }

  DataCell _progressPercentCell(double progressPercent) {
    return DataCell(Text("$progressPercent %"));
  }

  DataCell _stateCell(TaskState state) {
    return DataCell(Text(
      taskStateToString(state),
      style: TextStyle(
        color: taskStatetoColor(state),
      ),
    ));
  }

  DataCell _startDateCell(int time) {
    return DataCell(Text(dayMonthFormatFromMs(time)));
  }

  DataCell _dueDateCell(int time) {
    return DataCell(Text(dayMonthFormatFromMs(time)));
  }

  DataCell _shortContentCell(String content) {
    return DataCell(SelectableText(content));
  }

  DataCell _keyResultCell(String keyResult) {
    return DataCell(SelectableText(keyResult));
  }

  DataCell _progressDescriptionCell(String progressDescription) {
    return DataCell(SelectableText(progressDescription));
  }

  DataCell _buttonControlCell(String id) {
    return DataCell(Text(id));
  }

  @override
  Widget build(BuildContext context) {
    // Tạo ra danh sách header mặc định
    final header = _columnHeaders
        .map((e) => DataColumn(
                label: Flexible(
              child: Text(
                e,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppDefine.defaultTableHeaderStyle,
              ),
            )))
        .toList();

    // Tạo danh sách dữ liệu của toàn bộ bảng gồm nhiều DataRow khác nhau,
    // mỗi Row lại gồm nhiều DataCell khác nhau

    final dataRows = List.generate(
        widget.taskList.length,
        (index) => DataRow(
            cells: _rowIndextoCellList(index),
            color: widget.selectedList.contains(widget.taskList[index].id)
                ? MaterialStateColor.resolveWith(
                    (states) => AppDefine.primaryColor)
                : null));

    return DataTable(
        headingRowHeight: AppDefine.defaultHeaderHeight,
        dataRowMinHeight: AppDefine.defaultRowHeight,
        columnSpacing: AppDefine.defaultPadding,
        border: AppDefine.defaultTableBorder,
        headingRowColor: AppDefine.defaultHeaderBackground,
        showCheckboxColumn: true,
        columns: header,
        rows: dataRows);
  }
}
