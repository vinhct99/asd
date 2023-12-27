import 'dart:core';


import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/widget/oneselect/selectitem.dart';

class SelectDialog<T> extends StatefulWidget {
  final List<SelectItem<T>> items;

  /// The list of selected values before interaction.
  final List<T> initialValue;

  final Widget title;
  final Function(List<T>) onConfirm;
  const SelectDialog(
      {super.key,
      required this.title,
      required this.items,
      required this.initialValue,
      required this.onConfirm});

  List<T> onItemCheckedChange(
      List<T> selectedValues, T itemValue, bool checked) {
    selectedValues.clear();
    selectedValues.add(itemValue);
    return selectedValues;
  }

  /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<SelectItem<T>> updateSearchQuery(
      String? val, List<SelectItem<T>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<SelectItem<T>> filteredItems = [];
      for (var item in allItems) {
        if (item.label.toLowerCase().contains(val.toLowerCase())) {
          filteredItems.add(item);
        }
      }
      return filteredItems;
    } else {
      return allItems;
    }
  }

  @override
  // ignore: no_logic_in_create_state
  State<SelectDialog<T>> createState() => _SelectDialogState<T>(items);
}

class _SelectDialogState<T> extends State<SelectDialog<T>> {
  List<SelectItem<T>> _items;
  List<T> _selectedValues = [];
  bool _showSearch = false;
  //bool _checkAll = false;

  _SelectDialogState(this._items);

  Widget _searchField() {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              onChanged: (val) {
                List<SelectItem<T>> filteredList = [];
                filteredList = widget.updateSearchQuery(val, widget.items);
                setState(() {
                  _items = filteredList;
                });
              },
            )));
  }

  /// Returns a CheckboxListTile
  // Widget _buildListItem(SelectItem<T> item) {
  //   return Theme(
  //     data: ThemeData(
  //       unselectedWidgetColor: Colors.white,
  //     ),
  //     child: CheckboxListTile(
  //       side: const BorderSide(color: Colors.white, width: 2),
  //       checkColor: Colors.white,
  //       activeColor: AppDefine.accentColor,
  //       value: item.selected,
  //       title: Text(item.label, style: const TextStyle(color: Colors.white)),
  //       controlAffinity: ListTileControlAffinity.leading,
  //       onChanged: (checked) {
  //         setState(() {
  //           _selectedValues = widget.onItemCheckedChange(
  //               _selectedValues, item.value, checked!);
  //           for (var e in _items) {
  //             e.selected = false;
  //           }
  //           if (checked) {
  //             item.selected = true;
  //           } else {
  //             item.selected = false;
  //           }
  //         });
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _selectedValues.addAll(widget.initialValue);
    for (int i = 0; i < _items.length; i++) {
      _items[i].selected = false;
      if (_selectedValues.contains(_items[i].value)) {
        _items[i].selected = true;
      }
    }
  }

Widget _buildListItems(BuildContext context) {
  return Column(
    children: _items.map((e) => RadioListTile(
        title: Text(e.label),
        activeColor: AppDefine.accentColor,
        value:e.label,
        selected: e.selected,
        groupValue:_items.firstWhere((element) => element.selected).label, 
        onChanged: (value) => {
          setState(() {         
            _selectedValues = widget.onItemCheckedChange(
              _selectedValues, e.value, true);
            for (var e in _items) {
              e.selected = false;
            }
              e.selected = true;
          
          })
        },
            ))
        .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff3B3C47),
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _showSearch ? _searchField() : widget.title,
          IconButton(
            icon: _showSearch
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                _items = widget.items;
              });
            },
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child:_buildListItems(context)
            )
          ],
        )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Bỏ qua')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              widget.onConfirm(_selectedValues);
            },
            child: const Text('Xác nhận')),
      ],
    );
  }
}
