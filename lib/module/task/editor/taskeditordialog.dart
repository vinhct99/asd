import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object.dart';
import 'package:taskmanagement/common/object/project.dart';
import 'package:taskmanagement/common/object/task.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/common/widget/oneselect/selectfieldwidget.dart';
import 'package:taskmanagement/common/widget/oneselect/selectitem.dart';
import 'package:taskmanagement/control/maincontrol.dart';
import 'package:taskmanagement/control/usercontrol.dart';
import 'package:taskmanagement/module/task/editor/projecteditorfield.dart';

import 'usereditorfield.dart';

class TaskEditorDialog extends StatefulWidget {
  final Task initTask;
  final Function(Task) onConfirm;
  final EditorType editorType;
  const TaskEditorDialog(
      {super.key,
      required this.editorType,
      required this.initTask,
      required this.onConfirm});

  @override
  State<TaskEditorDialog> createState() => _TaskEditorDialogState();
}

class _TaskEditorDialogState extends State<TaskEditorDialog> {
  late Task _currentTask;
  late List<User> _users;
  late List<User> _author;
  late List<Project> _project = [];
  TaskType _type = TaskType.ork;
  bool _isAllTime = true;
  // DateTimeRange _timeRange = DateTimeRange(
  //     start: DateTime.now().subtract(const Duration(days: 10)),
  //     end: DateTime.now());
  DateTimeRange? _timeRange;

  @override
  void dispose() {
    _txtNameTask.dispose();
    _txtTarget.dispose();
    _txtAssignee.dispose();
    _txtAuthor.dispose();
    _txtkeyResult.dispose();
    _txtID.dispose();
    _txtstandardManhour.dispose();
    _txtmanhour.dispose();
    // _txtprogressDescription.dispose();
    // _txtprogressPercent.dispose();
    super.dispose();
  }

  final _text = '';
  final _number = '';
  final _txtAuthor = TextEditingController();
  final _txtID = TextEditingController();
  final _txtNameTask = TextEditingController();
  final _txtAssignee = TextEditingController();
  final _txtkeyResult = TextEditingController();
  final _txtTarget = TextEditingController();
  final _txtstandardManhour = TextEditingController();
  final _txtmanhour = TextEditingController();
  // final _txtprogressDescription = TextEditingController();
  // final _txtprogressPercent = TextEditingController();
  final control = MainControl();
  bool validate = false;

  String? validateText(TextEditingController controller) {
    // return validate && controller.text.isEmpty && controller.text.length < 4
    //     ? _errorText
    //     : null;
    if (controller.text.isEmpty) {
      return 'Không được để trống';
    }
    if (controller.text.length < 5) {
      return 'Nội dung quá ngắn';
    }
    return null;
  }

  String? validateNum(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  @override
  void initState() {
    final control = MainControl();
    _currentTask = widget.initTask;
    _users = control.userList();
    _author = control.userList();
    _project = control.projectList();

    final userControl = UserControl();
    _txtAuthor.text = userControl.username;
    _txtAssignee.text = userControl.username;

    fillData();

    super.initState();
  }

  List<Widget> _createTextField(
    String title,
    TextEditingController controller,
    bool editable,
  ) {
    return [
      Text(title),
      SizedBox(
          height: 36,
          child: TextField(
            //style: const TextStyle(color: Colors.white, fontSize: 30),
            enabled: editable,
            controller: controller,

            decoration: InputDecoration(
              //    border: InputBorder.none,

              errorText: validate ? validateText(controller) : null,
              // contentPadding:
              //     const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              // border: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(8)),
              //   borderSide: BorderSide(color: AppDefine.borderColor, width: 1),
              // ),
              //labelText: 'Từ khóa',

              // suffixIcon: (editable)
              //     ? IconButton(
              //         onPressed: controller.clear,
              //         icon: const Icon(
              //           Icons.clear,
              //           size: defaultIconSize,
              //           color: Colors.white,
              //         ),
              //       )
              //     : null,
            ),
            onChanged: (text) => setState(() => _text),
          )),
      AppDefine.vpadding4,
    ];
  }

  List<Widget> _createUserField(
      String title, TextEditingController controller, bool editable) {
    return [
      Text(title),
      AppDefine.vpadding4,
      SizedBox(
          height: 36,
          child: UserField(_author, _users, controller, editable, validate)),
      AppDefine.vpadding4,
    ];
  }

  // List<Widget> _createProjectField(
  //     String title, TextEditingController controller, bool editable) {
  //   return [
  //     Text(title),
  //     AppDefine.vpadding4,
  //     SizedBox(
  //         height: 36,
  //         child: ProjectListDropdown(_project, controller.text, (project) {
  //           controller.text = project?.id ?? '';
  //         })),
  //     AppDefine.vpadding4,
  //   ];
  // }

 

  void fillData() {
    _txtID.text = _currentTask.id.isEmpty
        ? control.createRandomTaskID()
        : _currentTask.id;

    _type = _currentTask.type;
   //  control.projectList().= _currentTask.projectId ;
    _txtmanhour.text = _currentTask.manhour.toString();
    if (_currentTask.manhour == 0) {
      _txtmanhour.text = '';
    }

    _txtstandardManhour.text = _currentTask.standardManhour.toString();
    if (_currentTask.standardManhour == 0) {
      _txtstandardManhour.text = '';
    }

    // _txtprogressPercent.text = _currentTask.progressPercent.toString();
    // if (_currentTask.progressPercent == 0) {
    //   _txtprogressPercent.text = '';
    // }

    if (_currentTask.startDate > 0 && _currentTask.dueDate > 0) {
      _isAllTime = false;
      _timeRange = DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(_currentTask.startDate),
        end: DateTime.fromMillisecondsSinceEpoch(_currentTask.dueDate),
      );
    }

    _txtTarget.text = _currentTask.content;

    _txtAssignee.text = _currentTask.assignee;
    _txtAuthor.text = _currentTask.author;

    _txtkeyResult.text = _currentTask.keyResult;

    _txtNameTask.text = _currentTask.name;
  }

  void _showTimeRangeDialog(BuildContext ctx) {
    showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: ctx,
      locale: const Locale('vi', 'VN'),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
              padding: const EdgeInsets.only(top: 50.0),
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
      textTime = 'dd/MM/yyyy-dd/MM/yyyy';
    } else {
      textTime =
          '${dayMonthFormat(_timeRange?.start ?? DateTime.now())} - ${dayMonthFormat(_timeRange?.end ?? DateTime.now())}';
    }

    // String textTime = _timeRange == null && _isAllTime
    //     ? 'dd/MM/yyyy-dd/MM/yyyy'
    //     : '${dayMonthFormat(_timeRange?.start ?? DateTime.now())} - ${dayMonthFormat(_timeRange?.end ?? DateTime.now())}';
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
                  Icons.arrow_drop_up,
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
        ),
        Stack(children: <Widget>[
          Positioned(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  width: 100,
                  height: 20.0,
                  color: Colors.transparent,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    (validate && _timeRange == null ? 'Nhập thời gian' : ''),
                    style: const TextStyle(
                      color: Color.fromARGB(204, 255, 68, 68),
                      fontSize: 12.5,
                    ),
                  )),
            ),
          ),
          // Container(
          //   width: 100,
          //   height: 20.0,
          //   color: Color.fromARGB(242, 194, 19, 19),
          //   alignment: Alignment.bottomLeft,
          // ),
          // Positioned(
          //   child: Align(
          //       alignment: Alignment.bottomLeft,
          //       child: Text(
          //         (validate && _timeRange == null ? 'Nhập thời gian' : ''),
          //         style: const TextStyle(
          //           color: Color.fromARGB(206, 248, 247, 247),
          //           fontSize: 12.5,
          //         ),
          //       )),
          // )
        ])
      ],
    );
  }

  List<Widget> _createNumberField(
      String title, TextEditingController controller, bool editable) {
    return [
      Text(title),
      AppDefine.vpadding4,
      SizedBox(
          height: 36,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
            ],
            enabled: editable,
            controller: controller,
            decoration: InputDecoration(
              errorText: validate ? validateNum(controller) : null,
            ),
            onChanged: (number) => setState(() => _number),
          )),
      AppDefine.vpadding4,
    ];
  }

  Widget _createLeftColumn() {
    List<Widget> fields = [];

    // Type filed
    fields.add(const Text('Phân loại nhiệm vụ'));
    fields.add(const SizedBox(height: 2));
    fields.add(
      Wrap(
          spacing: AppDefine.defaultPadding2,
          children: TaskType.values.map((e) {
            return ChoiceChip(
              label: Text(taskTypeToString(e)),
              selected: e == _type,
              onSelected: (bool selected) {
                setState(() {
                  _type = e;
                });
              },
              selectedColor: AppDefine.primaryColor,
              backgroundColor: Colors.grey,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList()),
    );
    fields.add(AppDefine.vpadding);

    // Project field
   List<Project> projectSelected(){
    if(_currentTask.projectId.isEmpty){
      setState(() {
        _currentTask.projectId = _project.first.id;
      });
      return [control.projectList().first];
    }else{
      return [control.projectList().firstWhere((element) => element.id == _currentTask.projectId)];
    }
   }
 
    fields.add(const Text('Dự án'));
    fields.add(SelectFieldWidget(
      icon: const Icon(Icons.abc, size: defaultIconSize),
      title: const Text('Loại'),
        onConfirm: (List<Project> results) {
        _currentTask.projectId = results.firstOrNull?.id ?? '';

      },
      items: control
          .projectList()
          .map((project) => SelectItem(project, project.id))
          .toList(),
      initialSelectedItems: projectSelected(),
    
    ));

    fields.add(AppDefine.vpadding);

    // ID field
    fields.add(const Text('ID'));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
        height: 36,
        child: TextField(
          enabled: false,
          controller: _txtID,
          decoration: AppDefine.defaultDecorator,
        )));
    fields.add(AppDefine.vpadding);

    // Parent ID field
    if (_type == TaskType.task || _type == TaskType.subtask) {
      if (_type == TaskType.task) {
        fields.add(const Text('ORK cha '));
        fields.add(const SizedBox(height: 2));
        fields.add(SizedBox(
            height: 36,
            child: TextField(
              enabled: false,
              controller: _txtID,
              decoration: AppDefine.defaultDecorator,
            )));
        fields.add(AppDefine.vpadding);
      } else {
        fields.add(const Text('Nhiệm vụ cha '));
        fields.add(const SizedBox(height: 2));
        fields.add(SizedBox(
            height: 36,
            child: TextField(
              enabled: false,
              controller: _txtID,
              decoration: AppDefine.defaultDecorator,
            )));
        fields.add(AppDefine.vpadding);
      }
    }

    // Author field
    fields.add(const Row(
      children: [
        Text('Người giao '),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
        height: 60,
        child: UserField(_author, _users, _txtAuthor, true, validate)));
    fields.add(AppDefine.vpadding);

    // Assignee field
    fields.add(const Row(
      children: [
        Text('Người thực hiện '),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
        height: 60,
        child: UserField(_author, _users, _txtAssignee, true, validate)));
    fields.add(AppDefine.vpadding);

    fields.add(Expanded(child: Container()));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }

  Widget _createRightColumn() {
    List<Widget> fields = [];
    // children: [Text('ID'), AppDefine.hpadding2, Text('*', style: TextStyle(color: Colors.red),)],

    // Name field
    fields.add(const Row(
      children: [
        Text('Nội dung nhiệm vụ '),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
      height: 72,
      child: TextField(
        controller: _txtNameTask,
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtNameTask) : null,
          hintMaxLines: 3,
          hintText:
              'Vd: Xây dựng module A, thiết kế mạch B, tờ trình mua sắm thủ tục C...',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    // Content field
    fields.add(const Row(
      children: [
        Text('Mục tiêu '),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
      height: 72,
      child: TextField(
        controller: _txtTarget,
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtTarget) : null,
          hintMaxLines: 3,
          hintText:
              'Vd: Hoàn thiện source code A, tài liệu B, layout mạch C, hồ sơ D,...',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    // Key result field
    fields.add(const Row(
      children: [
        Text('Tiêu chí key '),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
      height: 72,
      child: TextField(
        controller: _txtkeyResult,
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtkeyResult) : null,
          hintMaxLines: 3,
          hintText:
              'Vd: Đạt chỉ tiêu x/y testcase, đảm bảo hiệu năng trễ < A ms, độ chính xác B %,...',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    fields.add(const Text('7. Thời gian'));
    fields.add(_timeField(context));

    fields.addAll(_createNumberField(
        '8. Hour chuẩn (đối với bậc 13)', _txtmanhour, true));
    fields.addAll(_createNumberField(
        '9. Ước lượng Man-Hour đối với người thực hiện',
        _txtstandardManhour,
        true));

    // fields.addAll(_createTextField(
    //     '10. Mô tả trạng thái đang hoàn thiện', _txtprogressDescription, true));
    // fields.addAll(_createNumberField(
    //     '11. Mô tả % trạng thái đang hoàn thiện', _txtprogressPercent, true));

    fields.add(Expanded(child: Container()));
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields);
  }

  @override
  Widget build(BuildContext context) {
    double width = 1000;
    double height = MediaQuery.of(context).size.height * 0.7;

    return AlertDialog(
      backgroundColor: AppDefine.bgColorr,
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        widget.editorType == EditorType.creator
            ? 'Thêm nhiệm vụ mới'
            : 'Cập nhật nhiệm vụ',
        style: AppDefine.headerTextStyle,
      ),
      content: SizedBox(
          width: width,
          height: height,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(flex: 1, child: _createLeftColumn()),
              const SizedBox(width: 50),
              Flexible(
                flex: 1,
                child: _createRightColumn(),
              )
            ],
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Bỏ qua',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _currentTask.id = _txtID.text;
              _currentTask.type = _type;
             //  _currentTask.projectId = _project.s;
              _currentTask.name = _txtNameTask.text;
              _currentTask.manhour = int.tryParse(_txtmanhour.text) ?? 0;
              _currentTask.standardManhour =
              int.tryParse(_txtstandardManhour.text) ?? 0;
              _currentTask.assignee = _txtAssignee.text;
              _currentTask.author = _txtAuthor.text;
              _currentTask.content = _txtTarget.text;

              _currentTask.keyResult = _txtkeyResult.text;
              _currentTask.startDate =
                  _timeRange?.start.millisecondsSinceEpoch ?? 0;
              _currentTask.dueDate =
                  _timeRange?.end.millisecondsSinceEpoch ?? 0;

              setState(() {
                if (_txtNameTask.text.isEmpty && _txtNameTask.text.length < 5 ||
                    _txtTarget.text.isEmpty && _txtTarget.text.length < 5 ||
                    _txtkeyResult.text.isEmpty &&
                    _txtkeyResult.text.length < 5 ||
                    _txtstandardManhour.text.isEmpty ||
                    _txtmanhour.text.isEmpty ||
                    _timeRange == null ||
                    _txtAssignee.text.isEmpty ||
                    _txtAuthor.text.isEmpty ) {
                  validate = true;
                } else {
                  Navigator.pop(context);
                  if (kDebugMode) {
                    print(_currentTask.projectId);
                  }
                  widget.onConfirm(_currentTask);
               }
              });
            },
            child: const Text('Xác nhận', style: TextStyle(fontSize: 18))),
      ],
    );
  }
}
