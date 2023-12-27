

import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/widget/multiselect/multiselectitem.dart';

class MultiSelectDialog<T> extends StatefulWidget {
  final List<MultiSelectItem<T>> items;

  /// The list of selected values before interaction.
  final List<T> initialValue;

  final Widget title;
  final Function(List<T>) onConfirm;
  const MultiSelectDialog({
    super.key, 
    required this.title,
    required this.items, 
    required this.initialValue,
    required this.onConfirm


  });

  List<T> onItemCheckedChange(
      List<T> selectedValues, T itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    return selectedValues;
  }
    /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<MultiSelectItem<T>> updateSearchQuery(
      String? val, List<MultiSelectItem<T>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<MultiSelectItem<T>> filteredItems = [];
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
  State<MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>(items);
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  
  List<MultiSelectItem<T>> _items;
  List<T> _selectedValues = [];
  bool _showSearch = false;
  bool _checkAll = false;

  _MultiSelectDialogState(this._items);

  Widget _searchField(){
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
            List<MultiSelectItem<T>> filteredList = [];
            filteredList = widget.updateSearchQuery(val, widget.items);
            setState(() {
              _items = filteredList;
            });
          },
        )
      )
    );
    
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<T> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor:Colors.white,
      ),
      child: CheckboxListTile(
        activeColor: AppDefine.accentColor,
        value: item.selected,
        title: Text(
          item.label,
          style: const TextStyle(color: Colors.white)
        ),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked!);

            if (checked) {
              item.selected = true;
            } else {
              item.selected = false;
            }
            
            if (_selectedValues.length == _items.length && _items.isNotEmpty) {
              _checkAll = true;
            } else {
              _checkAll = false;
            } 
          });
        },
      ),
    );
  }

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
    
    if (_selectedValues.length == _items.length && _items.isNotEmpty) {
      _checkAll = true;
    } else {
      _checkAll = false;
    }
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
            icon: _showSearch ? const Icon(Icons.close) : const Icon(Icons.search),
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
            CheckboxListTile(
              activeColor: AppDefine.accentColor,
              value: _checkAll,
              title: const Text(
                'Toàn bộ',
                style: TextStyle(color: Colors.white)
              ),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (checked) {
                setState(() {
                  _checkAll = !_checkAll;

                  _selectedValues.clear();
                  if (_checkAll){
                    for (var item in _items) {
                      item.selected = true;
                      _selectedValues.add(item.value);
                    }
                  } else {
                    for (var item in _items) {
                      item.selected = false;
                    }
                  }
                });
              },
            ),
            Expanded(child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return _buildListItem(_items[index]);
                      }))
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          child: const Text('Bỏ qua')
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            widget.onConfirm(_selectedValues);
          }, 
          child: const Text('Xác nhận')
        ),
        
      ],
    );
  }
}