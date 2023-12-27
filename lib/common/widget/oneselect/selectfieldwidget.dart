import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/widget/oneselect/selectchipdisplay.dart';
import 'package:taskmanagement/common/widget/oneselect/selectdialog.dart';

import 'selectitem.dart';

// ignore: must_be_immutable
class SelectFieldWidget<V> extends StatefulWidget {
  /// The text at the top of the dialog.
  final Widget title;

  final Widget icon;

  /// Fires when confirm is tapped.
  final void Function(List<V>) onConfirm;

  /// List of items to select from.
  final List<SelectItem<V>> items;

  final List<V> initialSelectedItems;

  const SelectFieldWidget(
      {super.key,
      required this.title,
      required this.onConfirm,
      required this.items,
      required this.icon,
      required this.initialSelectedItems});

  @override
  State<SelectFieldWidget<V>> createState() => _SelectFieldWidgetState<V>();
}

class _SelectFieldWidgetState<V> extends State<SelectFieldWidget<V>> {
  List<V> _selectedItems = [];

  // Widget _buildInheritedChipDisplay() {
  //   List<SelectItem<V>?> chipDisplayItems = [];
  //   chipDisplayItems = _selectedItems
  //       .map((e) =>
  //           widget.items.firstWhereOrNull((element) => e == element.value))
  //       .toList();
  //   chipDisplayItems.removeWhere((element) => element == null);
  //   return SelectChipDisplay<V>(
  //     items: chipDisplayItems,
  //   );
  // }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SelectDialog(
            items: widget.items,
            initialValue: _selectedItems,
            title: widget.title,
            onConfirm: (values) {
              setState(() {
                _selectedItems = values;
              });
              widget.onConfirm(values);
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.initialSelectedItems;
  }

  @override
  Widget build(BuildContext context) {
    List<SelectItem<V>?> chipDisplayItems = [];
    chipDisplayItems = _selectedItems
        .map((e) =>
            widget.items.firstWhereOrNull((element) => e == element.value))
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: AppDefine.borderColor),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                widget.icon,
                const SizedBox(width: 6),
                Expanded(
                    child: chipDisplayItems.isEmpty
                        ? widget.title
                        : Text(chipDisplayItems.first!.label)),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
