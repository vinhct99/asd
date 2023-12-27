import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';

import 'selectitem.dart';

// ignore: must_be_immutable
class SelectChipDisplay<V> extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  SelectChipDisplay({super.key, this.items});

  /// The source list of selected items.
  final List<SelectItem<V>?>? items;
  Widget _buildItem(SelectItem<V> item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      child: Container(
        height: 32,
        padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppDefine.borderColor),
        child: Text(
          item.label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32,
        alignment: Alignment.centerLeft,
        child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: items!.length,
              itemBuilder: (ctx, index) {
                return _buildItem(items![index]!, context);
              },
            )));
  }
}