import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object.dart';
import 'package:taskmanagement/common/object/task.dart';
import 'package:taskmanagement/common/object/taskfilter.dart';
import 'package:taskmanagement/module/task/editor/taskeditordialog.dart';
import 'package:taskmanagement/module/task/filter/taskfilterwidget.dart';

import 'tasktablewidget.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  TaskListViewType _type = TaskListViewType.list;
  TaskFilter _filter = TaskFilter();
  bool _showFilter = false;
  List<String> selectedList = [];

  @override
  void initState() {
    super.initState();
  }

  void showAddTaskDialogAndProcessResult(BuildContext ctx) {
    showDialog(
        context: ctx,
        //barrierDismissible: false,
        builder: (dialogCtx) {
          return TaskEditorDialog(
            editorType: EditorType.creator,
            initTask: Task(),
            onConfirm: (task) {
              setState(() {
                taskListSample.add(task);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Stack(
                    children: [
                      Container(
                          width: 300,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(186, 45, 204, 58),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 40,
                              ),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                      "Thành công",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      "Thêm thành công nhiệm vụ",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]))
                            ],
                          )),
                      const Positioned(
                          bottom: 10,
                          child: Icon(
                            Icons.assignment_turned_in,
                            size: defaultIconSize,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ));
              });
            },
          );
        });
  }

  void showEditTaskDialogAndProcessResult(BuildContext ctx) {
    if (selectedList.isEmpty || selectedList.length > 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Stack(
          children: [
            Container(
                width: 300,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(187, 204, 55, 45),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 40,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            "Lỗi",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            "Chọn 1 để sửa",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]))
                  ],
                )),
            const Positioned(
                bottom: 10,
                child: Icon(
                  Icons.announcement,
                  size: defaultIconSize,
                  color: Color.fromARGB(206, 255, 255, 255),
                ))
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
      return;
    } else {
      var itemEdit = taskListSample
          .where((element) => element.id == selectedList[0])
          .first;
      showDialog(
          context: ctx,
          builder: (dialogCtx) {
            return TaskEditorDialog(
              editorType: EditorType.editor,
              //initTask: taskListSample[selectedList[0]],
              initTask: itemEdit,
              onConfirm: (task) {
                setState(() {
                  var itemEdit = taskListSample
                      .where((element) => element.id == task.id)
                      .firstOrNull;
                  if (itemEdit == null) return;
                  itemEdit = task;
                  // taskListSample.add(task);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Stack(
                      children: [
                        Container(
                            width: 300,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(186, 45, 204, 58),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(
                                        "Thành công",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        "Sửa thành công nhiệm vụ",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]))
                              ],
                            )),
                        const Positioned(
                            bottom: 10,
                            child: Icon(
                              Icons.assignment_turned_in,
                              size: defaultIconSize,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ));
                });
              },
            );
          });
    }
  }

  void showDeleteTaskDialogAndProcessResult(BuildContext ctx) {
    if (selectedList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Stack(
          children: [
            Container(
                width: 300,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(187, 204, 55, 45),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 40,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            "Lỗi",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            "Tích chọn 1 hoặc nhiều hàng để xóa",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]))
                  ],
                )),
            const Positioned(
                bottom: 10,
                child: Icon(
                  Icons.announcement,
                  size: defaultIconSize,
                  color: Color.fromARGB(206, 255, 255, 255),
                ))
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
      return;
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text('Thông báo'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Bạn có chắc muốn xóa không?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:
                    const Text('Không', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Có', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    taskListSample.removeWhere(
                        (element) => selectedList.contains(element.id));
                    selectedList.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Stack(
                        children: [
                          Container(
                              width: 300,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(186, 45, 204, 58),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 40,
                                  ),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                          "Thành công",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Xóa thành công nhiệm vụ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]))
                                ],
                              )),
                          const Positioned(
                              bottom: 10,
                              child: Icon(
                                Icons.assignment_turned_in,
                                size: defaultIconSize,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ));
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _titlePage() {
    return Row(
      children: [
        const Text('Nhiệm vụ', style: AppDefine.headerTextStyle),
        Expanded(
          child: Container(),
        ),
        Wrap(
            spacing: 12.0,
            children: TaskListViewType.values.map((e) {
              return ChoiceChip(
                label: Text(taskListViewTypeToString(e)),
                selected: e == _type,
                onSelected: (bool selected) {
                  setState(() {
                    _type = e;
                  });
                },
                selectedColor: AppDefine.primaryColor,
                backgroundColor: Colors.grey,
              );
            }).toList()),
      ],
    );
  }

  Widget _controlButton(BuildContext ctx) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () => showAddTaskDialogAndProcessResult(ctx),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.add), Text('Thêm')],
            )),
        AppDefine.hpadding2,
        ElevatedButton(
            onPressed: () => showEditTaskDialogAndProcessResult(ctx),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.edit), Text('Sửa')],
            )),
        AppDefine.hpadding2,
        ElevatedButton(
            onPressed: () {
              // _showMyDialog(ctx);
              showDeleteTaskDialogAndProcessResult(ctx);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.remove), Text('Xóa')],
            )),
        Expanded(child: Container()),
        Checkbox(
          value: _showFilter,
          onChanged: (e) {
            setState(() {
              _showFilter = e ?? false;
            });
          },
        ),
        const Text('Bộ lọc')
      ],
    );
  }

  void setFilter(TaskFilter value) {
    setState(() {
      _filter = value;
    });
  }

  List<Task> doFilter() {
    List<Task> results = taskListSample;

    if (_filter.projects.isNotEmpty) {
      results = results
          .where((element) => _filter.projects.contains(element.projectId))
          .toList();
    }
    //theo id
    if (_filter.keyword.isNotEmpty) {
      results =
          results.where((element) => element.id == _filter.keyword).toList();
    }
    if (_filter.types.isNotEmpty) {
      results = results
          .where((element) => _filter.types.contains(element.type))
          .toList();
    }
    if (_filter.states.isNotEmpty) {
      results = results
          .where((element) => _filter.states.contains(element.state))
          .toList();
    }
    if (_filter.assignees.isNotEmpty) {
      results = results
          .where((element) => _filter.assignees.contains(element.assignee))
          .toList();
    }
    if (_filter.authors.isNotEmpty) {
      results = results
          .where((element) => _filter.authors.contains(element.author))
          .toList();
    }

    return results;
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
        padding: const EdgeInsets.all(AppDefine.defaultPadding),
        decoration: const BoxDecoration(
          color: AppDefine.secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _titlePage(),
          AppDefine.vpadding2,
          _controlButton(ctx),
          AppDefine.vpadding2,
          AppDefine.vpadding2,
          Flexible(
            flex: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: TaskTableWidget(
                            height: MediaQuery.of(ctx).size.height,
                            taskList: doFilter(),
                            selectedList: selectedList,
                          ))),
                ),
                _showFilter ? AppDefine.hpadding2 : null,
                _showFilter ? TaskFilterWidget(setFilter) : null,
              ].where((e) => e != null).map((e) => e!).toList(),
            ),
          ),
          Flexible(
            flex: 20,
            child: SizedBox(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
            ),
          )
        ]));
  }
}
