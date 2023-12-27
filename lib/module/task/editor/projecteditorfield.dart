import 'package:flutter/material.dart';
import 'package:taskmanagement/common/object/project.dart';

class ProjectListDropdown extends StatefulWidget {
  final List<Project> projects;
  final String idValue;
  final Function(Project?) projectSelection;
  const ProjectListDropdown(this.projects, this.idValue, this.projectSelection,
      {super.key});

  @override
  State<ProjectListDropdown> createState() => _ProjectListDropdown();
}

class _ProjectListDropdown extends State<ProjectListDropdown> {
  Project? dropdownValue;

  @override
  void initState() {
    if (widget.projects.isNotEmpty) {
      if (widget.idValue.isNotEmpty) {
        dropdownValue = widget.projects
            .where((element) => element.id == widget.idValue)
            .firstOrNull;
      }
      dropdownValue ??= widget.projects.firstOrNull;
      widget.projectSelection(dropdownValue);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: const InputDecoration(
            // contentPadding: EdgeInsets.all(8),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(8)),
            // ),
            ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<Project>(
          value: dropdownValue,
          onChanged: (Project? value) {
            widget.projectSelection(value);
            setState(() {
              dropdownValue = value!;
            });
          },
          items:
              widget.projects.map<DropdownMenuItem<Project>>((Project value) {
            return DropdownMenuItem<Project>(
              value: value,
              child: Text(value.id),
            );
          }).toList(),
        )));
  }
}
