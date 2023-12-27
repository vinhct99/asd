
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/widget/multiselect/multiselectchipdisplay.dart';
import 'package:taskmanagement/common/widget/multiselect/multiselectdialog.dart';
import 'multiselectitem.dart';

// ignore: must_be_immutable
class MultiSelectFieldWidget<V> extends StatefulWidget {
  /// The text at the top of the dialog.
  final Widget title;

  final Widget icon;

  /// Fires when confirm is tapped.
  final void Function(List<V>) onConfirm;
  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  final List<V> initialSelectedItems;

  const MultiSelectFieldWidget({
   
    super.key, 
    required this.title, 
    required this.onConfirm, 
    required this.items,
    required this.icon,
    required this.initialSelectedItems
  });

  @override
  State<MultiSelectFieldWidget<V>> createState() => _MultiSelectFieldWidgetState<V>();
}

class _MultiSelectFieldWidgetState<V> extends State<MultiSelectFieldWidget<V>> {
  List<V> _selectedItems = [];

  Widget _buildInheritedChipDisplay() {
    List<MultiSelectItem<V>?> chipDisplayItems = [];
    if (_selectedItems.length == widget.items.length && widget.items.isNotEmpty){
      chipDisplayItems = [
        MultiSelectItem(_selectedItems[0], 'Toàn bộ')
      ];
    } else {
      chipDisplayItems = _selectedItems
          .map((e) => widget.items.firstWhereOrNull((element) => e == element.value))
          .toList();
    }
    chipDisplayItems.removeWhere((element) => element == null);
    return MultiSelectChipDisplay<V>(
      items: chipDisplayItems,
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context){
        return MultiSelectDialog(
          items: widget.items, 
          initialValue: _selectedItems, 
          title: widget.title,
          onConfirm: (values){
            setState(() {
              _selectedItems = values;
            });
            widget.onConfirm(values);
          },
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.initialSelectedItems;
  }
  
  @override
  Widget build(BuildContext context) {
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
                Expanded( child: widget.title ),
                const Icon(Icons.arrow_drop_down, size: 20,)
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        _buildInheritedChipDisplay(),
      ],
    );
  }

  
}