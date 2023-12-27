import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/project.dart';
import 'package:taskmanagement/control/maincontrol.dart';

class ProjectTableWidget extends StatefulWidget {
  final List<Project> projectList;
  final List<String> selectedList;

  const ProjectTableWidget(
      {super.key, required this.projectList, required this.selectedList});

  @override
  State<ProjectTableWidget> createState() => _ProjectTableWidgetState();
}

class _ProjectTableWidgetState extends State<ProjectTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> _columnHeaders = [
    '',
    'ID dự án',
    'Tên dự án',
    'Mô tả',
    'ID trưởng nhóm',
    'ID phó nhóm',
    'Loại',
    'Trạng thái',
    'Độ ưu tiên',
  ];

  List<DataCell> _rowIndextoCellList(int row) {
    final project = widget.projectList[row];
    return [
      _checkBoxCell(row, project),
      _projectIdCell(project.id),
      _projectNameCell(project.name),
      _projectDescriptionCell(project.description),
      _managerIdCell(project.managerId),
      _subManagerIdCell(project.subManagerId
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")),
      // .replaceAll(",", "\n ")),
      _projectTypeCell(project.type),
      _projectStateCell(project.state),
      _projectpriorityCell(project.priority),
    ];
  }

  DataCell _checkBoxCell(int row, project) {
    return DataCell(
      Checkbox(
        value: widget.selectedList.contains(project.id),
        onChanged: (value) {
          setState(() {
            if (value ?? false) {
              widget.selectedList.add(project.id);
            } else {
              widget.selectedList.remove(project.id);
            }
          });
        },
      ),
    );
  }

  DataCell _projectIdCell(String id) {
    return DataCell(Text(id));
  }

  DataCell _projectNameCell(String name) {
    return DataCell(Text(name));
  }

  DataCell _projectDescriptionCell(String description) {
    return DataCell(SelectableText(description));
  }

  DataCell _managerIdCell(String managerId) {
    return DataCell(Text(managerId));
  }

  DataCell _subManagerIdCell(String subManagerId) {
    return DataCell(Text(subManagerId));
  }

  DataCell _projectTypeCell(ProjectType type) {
    return DataCell(Text(projectTypeToString(type)));
  }

  DataCell _projectStateCell(String state) {
    return DataCell(Text(state));
  }

  DataCell _projectpriorityCell(int priority) {
    return DataCell(Text("$priority"));
  }

  @override
  Widget build(BuildContext context) {
    final headers = _columnHeaders
        .map((e) => DataColumn(
                label: Flexible(
                    child: Text(
              e,
              textAlign: TextAlign.justify,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppDefine.defaultTableHeaderStyle,
            )))) //)
        .toList();

    final dataRows = List.generate(
        widget.projectList.length,
        (index) => DataRow(
            cells: _rowIndextoCellList(index),
            color: widget.selectedList.contains(widget.projectList[index].id)
                ? MaterialStateColor.resolveWith(
                    (states) => AppDefine.primaryColor)
                : null));

    return DataTable(
        headingRowHeight: AppDefine.defaultHeaderHeight,
        dataRowMinHeight: AppDefine.defaultRowHeight,
        columnSpacing: AppDefine.defaultPadding,
        border: AppDefine.defaultTableBorder,
        headingRowColor: AppDefine.defaultHeaderBackground,
        showCheckboxColumn: false,
        columns: headers,
        rows: dataRows);
  }
}
