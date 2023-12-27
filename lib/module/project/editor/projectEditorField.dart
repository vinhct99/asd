import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object.dart';
import 'package:taskmanagement/common/object/project.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/control/maincontrol.dart';


class ProjectEditorDialog extends StatefulWidget {
  final Project initProject;
  final Function(Project) onConfirm;
  final EditorType editorType;
  const ProjectEditorDialog(
      {super.key,
      required this.editorType,
      required this.initProject,
      required this.onConfirm});

  @override
  State<ProjectEditorDialog> createState() => _ProjectEditorDialogState();
}


class _ProjectEditorDialogState extends State<ProjectEditorDialog> {
  late final Project _currentProject;
  final _txtID = TextEditingController();
  final _text = '';
  final _txtmanagerId = TextEditingController();
  final _txtsubManagerId = TextEditingController();
  final _txtnameProject = TextEditingController();
  final _txtdescription = TextEditingController();
  ProjectType _typeProject = ProjectType.Type1;
  final _txtstate = TextEditingController();
  final _txtpriority = TextEditingController();
  final control = MainControl();
  bool validate = false;


  String? validateText(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'Không được để trống';
    }
    if (controller.text.length < 2) {
      return 'Tên quá ngắn';
    }
    return null;
  }
  String? validateNumber(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }
   @override
  void dispose() {
    _txtID.dispose();
    _txtmanagerId.dispose();
    _txtsubManagerId.dispose();
    _txtnameProject.dispose();
    _txtdescription.dispose();
    _txtstate.dispose();
    _txtpriority.dispose();
    super.dispose();
  }
    @override
  void initState() {
  //  final control = MainControl();
    _currentProject = widget.initProject;
 

   

    fillData();

    super.initState();
  }
  void fillData(){
    _txtID.text = _currentProject.id.isEmpty ? control.createRandomProjectID() : _currentProject.id;
    _typeProject = _currentProject.type;
    _txtnameProject.text = _currentProject.name;
    _txtsubManagerId.text = _currentProject.subManagerId.toString().replaceAll("[", "").replaceAll("]", "");
    _txtmanagerId.text = _currentProject.managerId;
    _txtstate.text = _currentProject.state;
    _txtpriority.text = _currentProject.priority.toString();
    if(_currentProject.priority == 0){
      _txtpriority.text = '';
    }
    
   _txtdescription.text = _currentProject.description;
   _typeProject = _currentProject.type;
  }

  Widget _createLeftColumn() {
    List<Widget> fields = [];
    // ID field
    fields.add(const Text('ID'));
    fields.add(const SizedBox(height: 1));
    fields.add(SizedBox(
        height: 60,
        child: TextField(
          enabled: false,
          controller: _txtID,
          decoration: InputDecoration(
          errorText: validate ? validateText(_txtID) : null,
          hintMaxLines: 1,
          hintText: 'veac',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        )));
    fields.add(AppDefine.vpadding);

    // Name Project
    fields.add(const Row(
      children: [
        Text('Tên dự án'),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
      height: 60,
      child: TextField(
        controller: _txtnameProject,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtnameProject) : null,
          hintMaxLines: 1,
          hintText: 'WBHF',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    // ID trưởng nhóm
    fields.add(const Row(
      children: [
        Text('ID trưởng nhóm'),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
      height: 60,
      child: TextField(
        controller: _txtmanagerId,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtmanagerId) : null,
          hintMaxLines: 1,
          hintText: 'Dung21',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    // ID phó nhóm
    fields.add(const Row(
      children: [
        Text('ID phó nhóm'),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
      height: 60,
      child: TextField(
        controller: _txtsubManagerId,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtsubManagerId) : null,
          hintMaxLines: 1,
          hintText: 'Dung21,Khanh12',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    fields.add(AppDefine.vpadding);
    fields.add(Expanded(child: Container()));
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields);
  }

  Widget _createRightColumn() {
    List<Widget> fields = [];
    // Mô tả dự án
    fields.add(const Row(
      children: [
        Text('Mô tả dự án'),
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
        controller: _txtdescription,
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: validate ? validateText(_txtdescription) : null,
          hintMaxLines: 3,
          hintText: 'Vd:Hệ thống liên lạc sóng ngắn',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        onChanged: (text) => setState(() => _text),
      ),
    ));
    fields.add(AppDefine.vpadding);

    // Loại
    fields.add(const Row(
      children: [
        Text('Loại'),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(
      Wrap(
          spacing: AppDefine.defaultPadding2,
          children: ProjectType.values.map((e) {
            return ChoiceChip(
              label: Text(projectTypeToString(e)),
              selected: e == _typeProject,
              onSelected: (bool selected) {
                setState(() {
                  _typeProject = e;
                });
              },
              selectedColor: AppDefine.primaryColor,
              backgroundColor: Colors.grey,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList()),
    );
    fields.add(AppDefine.vpadding);

    // Trạng thái
     fields.add(const Row(
      children: [
        Text('Trạng thái'),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
        height: 60,
        child: TextField(
          enabled: true,
          controller: _txtstate,
          decoration: InputDecoration(
          errorText: validate ? validateText(_txtdescription) : null,
          hintMaxLines: 3,
          hintText: 'Bình thường',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        onChanged: (text) => setState(() => _text),
        )));
    fields.add(AppDefine.vpadding);

    // Độ ưu tiên
      fields.add(const Row(
      children: [
        Text('Độ ưu tiên'),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    ));
    fields.add(const SizedBox(height: 2));
    fields.add(SizedBox(
        height: 60,
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
          ],
          enabled: true,
          controller: _txtpriority,
          decoration: InputDecoration(
          errorText: validate ? validateNumber(_txtpriority) : null,
          hintMaxLines: 1,
          hintText: 'Vd:1',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        onChanged: (text) => setState(() => _text),
        )));
    fields.add(AppDefine.vpadding);

    fields.add(Expanded(child: Container()));
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields);
  }

  @override
  Widget build(BuildContext context) {
    double width = 1000;
    double height = MediaQuery.of(context).size.height * 0.5;

    return AlertDialog(
      backgroundColor: AppDefine.bgColorr,
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        widget.editorType == EditorType.creator
            ? 'Thêm dự án mới'
            : 'Cập nhật dự án',
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
                _currentProject.id  = _txtID.text;
                _currentProject.name = _txtnameProject.text;
                _currentProject.managerId = _txtmanagerId.text;
               // _currentProject.subManagerId = _txtsubManagerId;
                _currentProject.description = _txtdescription.text;
                _currentProject.state = _txtstate.text;
                _currentProject.priority = int.tryParse(_txtpriority.text) ?? 0;
              //setState(() {
                  // if(_txtmanagerId.text.isEmpty || 
                  // _txtID.text.isEmpty ||
                 // _txtsubManagerId.text.isEmpty ||
                  // _txtnameProject.text.isEmpty ||
                  // _txtdescription.text.isEmpty ||
                  // _txtstate.text.isEmpty ||
                  // _txtpriority.text.isEmpty){
                  //   validate = true;
                //  }else{
                     Navigator.pop(context);
                    widget.onConfirm(_currentProject);
                    print(_currentProject);
                //  }
             // });
            },
            child: const Text('Xác nhận', style: TextStyle(fontSize: 18))),
      ],
    );
  }
}
