import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/task.dart';
import 'package:taskmanagement/common/object/taskfilter.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/common/widget/multiselect/multiselectfieldwidget.dart';
import 'package:taskmanagement/common/widget/multiselect/multiselectitem.dart';
import 'package:taskmanagement/control/maincontrol.dart';

class TaskFilterWidget extends StatefulWidget {
  final Function setValue;
  const TaskFilterWidget(this.setValue, {super.key});

  @override
  State<TaskFilterWidget> createState() => _TaskFilterWidgetState();
}

class _TaskFilterWidgetState extends State<TaskFilterWidget> {
  final _txtKeyword = TextEditingController();
  List<String> _projects = [];
  List<TaskType> _types = [];
  List<TaskState> _states = [];
  List<String> _assignees = [];
  List<String> _teams = [];
  List<String> _authors = [];

  bool _isAllTime = true;
  DateTimeRange _timeRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 10)),
      end: DateTime.now());

  @override
  void initState() {
    super.initState();
    final mainControl = MainControl();
    // Các bộ lọc mặc định khác nhau đối với các chức vụ khác nhau
    switch (mainControl.myUser().position) {
      case JobPosition.staff:
        _projects = mainControl.projectList().map((e) => e.id).toList();
        _types = [TaskType.task, TaskType.subtask];
        _states = [TaskState.init, TaskState.normal, TaskState.expired];
        _assignees = [mainControl.myUser().id];
        _teams = [mainControl.myUser().teamId];
        _authors = mainControl.userList().map((e) => e.id).toList();
        break;
      case JobPosition.leader:
      case JobPosition.pa:
      case JobPosition.director:
      case JobPosition.admin:
    }
  }

  Widget _keywordField() {
    return SizedBox(
        height: 36,
        child: TextField(
          controller: _txtKeyword,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppDefine.borderColor, width: 1),
            ),
            labelText: 'Từ khóa',
            suffixIcon: IconButton(
              onPressed: _txtKeyword.clear,
              icon: const Icon(Icons.clear, size: defaultIconSize),
            ),
          ),
        ));
  }

  Widget _selectProjectField() {
    final mainControl = MainControl();
    final items = mainControl
        .projectList()
        .map((project) => MultiSelectItem(project.id, project.id))
        .toList();
    return MultiSelectFieldWidget(
      icon: const Icon(Icons.assessment_outlined, size: defaultIconSize),
      title: const Text('Dự án'),
      onConfirm: (List<String> results) {
        _projects = results;
      },
      items: items,
      initialSelectedItems: _projects,
    );
  }

  Widget _selectTypeField() {
    final mainControl = MainControl();
    final items = mainControl
        .taskTypeList()
        .map((type) => MultiSelectItem(type, taskTypeToString(type)))
        .toList();
    return MultiSelectFieldWidget(
      icon: const Icon(Icons.abc, size: defaultIconSize),
      title: const Text('Loại'),
      onConfirm: (List<TaskType> results) {
        _types = results;
      },
      items: items,
      initialSelectedItems: _types,
    );
  }

  Widget _selectStateField() {
    final mainControl = MainControl();
    final items = mainControl
        .taskStateList()
        .map((state) => MultiSelectItem(state, taskStateToString(state)))
        .toList();
    return MultiSelectFieldWidget(
      icon: const Icon(Icons.abc, size: defaultIconSize),
      title: const Text('Trạng thái'),
      onConfirm: (List<TaskState> results) {
        _states = results;
      },
      items: items,
      initialSelectedItems: _states,
    );
  }

  Widget _selectAssigneeField() {
    final mainControl = MainControl();
    final items = mainControl
        .userList()
        .map((user) => MultiSelectItem(user.id, user.id))
        .toList();
    return MultiSelectFieldWidget(
      icon: const Icon(Icons.abc, size: defaultIconSize),
      title: const Text('Người thực hiện'),
      onConfirm: (List<String> results) {
        _assignees = results;
      },
      items: items,
      initialSelectedItems: _assignees,
    );
  }

  Widget _selectTeamField() {
    final mainControl = MainControl();
    final items = mainControl
        .teamList()
        .map((team) => MultiSelectItem(team.id, team.name))
        .toList();
    return MultiSelectFieldWidget(
      icon: const Icon(Icons.abc, size: defaultIconSize),
      title: const Text('Nhóm'),
      onConfirm: (List<String> results) {
        _teams = results;
      },
      items: items,
      initialSelectedItems: _teams,
    );
  }

  Widget _authorField() {
    final mainControl = MainControl();
    final items = mainControl
        .userList()
        .map((user) => MultiSelectItem(user.id, user.id))
        .toList();
    return MultiSelectFieldWidget(
      icon: const Icon(Icons.abc, size: defaultIconSize),
      title: const Text('Người giao'),
      onConfirm: (List<String> results) {
        _authors = results;
      },
      items: items,
      initialSelectedItems: _authors,
    );
  }

  void _showTimeRangeDialog(BuildContext ctx) {
    showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: ctx,
      locale: const Locale('vi', 'VN'),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      fieldStartLabelText: 'Bắt đầu',
      fieldEndLabelText: 'Kết thúc',
      cancelText: 'Bỏ qua',
      helpText:
          'Tìm kiếm bất kỳ nhiệm vụ nào trong khoảng thời gian\nChọn lần lượt ngày bắt đầu & ngày kết thúc để tìm kiếm',
      confirmText: 'Thiết lập',
      errorFormatText: 'Lỗi sai định dạng',
      errorInvalidText: 'Lỗi không hợp lệ',
      errorInvalidRangeText: 'Lỗi khoảng thời gian không hợp lệ',
      saveText: 'Thiết lập',
      initialDateRange: _isAllTime ? null : _timeRange,
      builder: (context, child) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 600,
                width: 700,
                child: child,
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _isAllTime = false;
          _timeRange = value;
        });
      }
    });
  }

  Widget _timeField(BuildContext ctx) {
    String textTime;
    if (_isAllTime) {
      textTime = 'Toàn bộ';
    } else {
      textTime =
          '${dayMonthFormat(_timeRange.start)} - ${dayMonthFormat(_timeRange.end)}';
    }
    List<Widget> timeDisplayWidgets = [
      Container(
        padding: const EdgeInsets.all(1),
        child: Container(
          height: 32,
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: AppDefine.borderColor),
          child: Text(
            textTime,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      )
    ];
    if (!_isAllTime) {
      timeDisplayWidgets.add(IconButton(
          onPressed: () {
            setState(() {
              _isAllTime = true;
            });
          },
          icon: const Icon(
            Icons.close,
            size: defaultIconSize,
          )));
    }
    return Column(
      children: [
        InkWell(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: AppDefine.borderColor),
            ),
            padding: const EdgeInsets.all(8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.date_range, size: defaultIconSize),
                SizedBox(width: 6),
                Expanded(child: Text('Thời gian')),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                )
              ],
            ),
          ),
          onTap: () {
            _showTimeRangeDialog(ctx);
          },
        ),
        AppDefine.vpadding4,
        Row(
          children: timeDisplayWidgets,
        )
      ],
    );
  }

 Widget _resetFilter() {
    return IconButton(
      onPressed: () {
        setState(() {
          _txtKeyword.clear();
          _projects.clear();
          _assignees.clear();
          _authors.clear();
          _projects.clear();
          _types.clear();
          _states.clear();
          _isAllTime = true;
          showMessage(context, 'Reset bộ lọc');
        });
      },
      icon: const Icon(Icons.restart_alt_rounded),
      tooltip: 'Reset bộ lọc',
    );
  }

  Widget _createAddButton() {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.add),
          tooltip: 'Thêm bộ lọc',
        );
      },
      menuChildren: [
        MenuItemButton(
          child: const Text('Lĩnh vực'),
          onPressed: () {},
        ),
        MenuItemButton(child: const Text('Người tạo'), onPressed: () {}),
        MenuItemButton(child: const Text('Man hour'), onPressed: () {}),
        MenuItemButton(child: const Text('Tiến độ (%)'), onPressed: () {}),
      ],
    );
  }

  void showMessage(BuildContext ctx, String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext ctx) {
    List<Widget> widgets = [
      AppDefine.vpadding2,
      _keywordField(),
      AppDefine.vpadding2,
      _selectProjectField(),
      AppDefine.vpadding2,
      _selectTypeField(),
      AppDefine.vpadding2,
      _selectStateField(),
      AppDefine.vpadding2,
      _selectAssigneeField(),
      AppDefine.vpadding2,
      _selectTeamField(),
      AppDefine.vpadding2,
      _authorField(),
      AppDefine.vpadding2,
      _timeField(ctx),
    ];

    return SizedBox(
        width: 250,
        child: Column(children: [
          const Text('Bộ lọc', style: AppDefine.headerTextStyle),
          AppDefine.vpadding2,
          Expanded(
              child: ListView(
            children: widgets,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             _resetFilter(),
              AppDefine.hpadding2,
              _createAddButton(),
              AppDefine.hpadding2,
              ElevatedButton(
                  onPressed: () {
                    final filter = TaskFilter();
                    filter.keyword = _txtKeyword.text;
                    filter.projects = _projects;
                    filter.types = _types;
                    filter.states = _states;
                    filter.assignees = _assignees;
                    filter.teams = _teams;
                    filter.authors = _authors;
                    filter.isAllTime = _isAllTime;
                    filter.timeRange = _timeRange;

                    final control = MainControl();
                    control.applyFilter(filter).then((success) {
                      if (success) {
                        widget.setValue(filter);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Stack(
                            children: [
                              Container(
                                  //width: 300,
                                  //sheight: 10,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(186, 45, 204, 58),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 40,
                                      ),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                              "Thành công",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "Tim",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ]))
                                    ],
                                  )),
                              const Positioned(
                                  bottom: 10,
                                  child: Icon(
                                    Icons.assignment_turned_in,
                                    size: defaultIconSize,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));
                      } else {
                        showMessage(ctx, 'Có lỗi xảy ra ');
                      }
                    });

                    if (kDebugMode) {
                      // loggerNoStack.d('Apply filter ${filter.toJson()}');
                    }
                  },
                  child: const Text('Tìm kiếm'))
            ],
          )
        ]));
  }
}
