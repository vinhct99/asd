


import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/control/maincontrol.dart';

class UserTableWidget extends StatefulWidget {
  final List<User> users;
  final Function(int) onSelectionChanged;
  const UserTableWidget({super.key, required this.users, required this.onSelectionChanged});

  @override
  State<UserTableWidget> createState() => _UserTableWidgetState();
}

class _UserTableWidgetState extends State<UserTableWidget> {
  int _currentSelectionIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  final List<String> _columnHeaders = [
    'ID',
    'Họ tên',
    'Mã NV',
    'Trạng thái',
    'Chức vụ',
    'Nhóm',
  ];

  List<DataCell> _rowIndextoCellList(int row) {
    final control = MainControl();
    final user = widget.users[row];
    final team = control.getTeamById(user.id);
    if (team != null){

    }
    
    return [
      DataCell(
        Text(user.id)
      ),
      DataCell(
        Text(user.name),
      ),
      DataCell(
        Text('${user.number}')
      ),
      DataCell(
        Text(user.state.toDisplay())
      ),
      DataCell(
        Text(user.jobTitle)
      ), 
      DataCell(
        Text(team != null ? team.name : user.teamId)
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Tạo ra danh sách header mặc định
    final headers = _columnHeaders
        .map((e) => DataColumn(
            label: Text(e, style: AppDefine.defaultTableHeaderStyle)))
        .toList();

    // Tạo danh sách dữ liệu của toàn bộ bảng gồm nhiều DataRow khác nhau,
    // mỗi Row lại gồm nhiều DataCell khác nhau
    final dataRows = List.generate(
        widget.users.length,
        (index) => DataRow(
            cells: _rowIndextoCellList(index),
            onSelectChanged: (value){
              setState(() {
                if (value != null && value){
                  _currentSelectionIndex = index;
                } else {
                  _currentSelectionIndex = -1;
                }
              });
            },
            color: _currentSelectionIndex == index
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
      rows: dataRows
    );
  }
}
