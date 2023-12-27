

import 'package:flutter/material.dart';

import '../appdefine.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {

  int defaultPageSize = 30;
  int currentPage = 1;
  int countPage = 1;
  
  

  List<Widget> createPageButton() {
    List<Widget> output = [];
    for (int i = 1; i <= countPage; i++) {
      if (i == currentPage) {
        final currentPageText = SizedBox(
          width: 40,
          child: Center(
            child: Text(i.toString()),
          ),
        );
        output.add(currentPageText);
      } else {
        if (i > 2 && i < countPage - 1 && (i - currentPage).abs() > 2) {
          continue;
        }
        final btPage = ElevatedButton(
          child: Text(i.toString()),
          onPressed: () {
            currentPage = i;
            // getSystemEventThenUpdate();
          },
        );
        output.add(btPage);
      }
      output.add(const SizedBox(width: AppDefine.defaultPadding2));
    }
    output.add(Expanded(child: Container()));
    output.add(const Text('Số trang'));
    output.add(const SizedBox(width: AppDefine.defaultPadding));
    output.add(DropdownButton<int>(
        value: defaultPageSize,
        items: [10, 30, 50, 100]
            .map((e) =>
                DropdownMenuItem<int>(value: e, child: Text(e.toString())))
            .toList(),
        onChanged: (val) {
          if (val == null) return;
          defaultPageSize = val;
          currentPage = 1;
          // getSystemEventThenUpdate();
        }));
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }


}