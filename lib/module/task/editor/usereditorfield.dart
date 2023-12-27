import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/common/vietnamesetext.dart';

// ignore: must_be_immutable
class UserField extends StatefulWidget {
  final List<User> users;
  final List<User> author;
  final TextEditingController controller;
  bool editable;
  bool validate;

  UserField(
      this.author, this.users, this.controller, this.editable, this.validate,
      {super.key});

  @override
  State<UserField> createState() => _UserField();
}

class _UserField extends State<UserField> {
  String? _text;

  String? validateText(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'Không được để trống';
    }
    if (controller.text.length < 2) {
      return 'Chưa đúng';
    }
    return null;
  }

  @override
  void initState() {
    widget.validate = false;

    if (kDebugMode) {
      print(widget.validate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<User>(
        focusNode: FocusNode(),
        textEditingController: widget.controller,
        displayStringForOption: (user) => user.id,
        onSelected: (user) => {setState(() => _text)},
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Nhập tên nhân sự',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(8),
              errorText: widget.validate ? validateText(controller) : null,
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
            ),
            child: SizedBox(
              height: 52.0 * options.length,
              width: constraints.biggest.width, // <-- Right here !
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                shrinkWrap: false,
                itemBuilder: (BuildContext context, int index) {
                  final user = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(user),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          '[${user.id} ${user.number}] ${user.name} - ${user.jobTitle}'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<User>.empty();
          } else {
            final v = toLowerCaseNonAccentVietnamese(textEditingValue.text);
            return widget.users.where((e) {
              return e.id.toLowerCase().contains(v) ||
                  toLowerCaseNonAccentVietnamese(e.name).contains(v) ||
                  e.number.toString().contains(v);
            });
          }
        },
      ),
    );
  }
}
