import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object.dart';
import 'package:taskmanagement/common/object/project.dart';
import 'package:taskmanagement/control/maincontrol.dart';
import 'package:taskmanagement/module/project/editor/projectEditorField.dart';
import 'package:taskmanagement/module/project/projecttablewidget.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final control = MainControl();
  List<String> selectedList = [];
  List<Project> projectListApi = [];
  @override
  void initState() {
    super.initState();
    getProjects();
  }

  Widget _titlePage() {
    return Row(
      children: [
        const Text('Dự án', style: AppDefine.headerTextStyle),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  void showAddProjectDialogAndProcessResult(BuildContext ctx) {
    showDialog(
        context: ctx,
        //barrierDismissible: false,
        builder: (dialogCtx) {
          return ProjectEditorDialog(
            editorType: EditorType.creator,
            initProject: Project(),
            onConfirm: (project) {
              setState(() {
                if (projectListSample.containsKey(project.id)) return;
                projectListSample
                    .addEntries(<String, Project>{project.id: project}.entries);
                print(projectListSample);
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

  void showEditProjectDialogAndProcessResult(BuildContext ctx) {
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
      var projectEdit = control
          .projectList()
          .where((element) => element.id == selectedList[0])
          .first;
      showDialog(
          context: context,
          builder: (dialogCtx) {
            return ProjectEditorDialog(
                editorType: EditorType.editor,
                initProject: projectEdit,
                onConfirm: (project) {
                  setState(() {
                    var projectEdit = control
                        .projectList()
                        .where((element) => element.id == project.id)
                        .firstOrNull;
                    if (projectEdit == null) {
                      return;
                    }
                    projectEdit = project;
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
                                          "Sửa thành công nhiệm vụ",
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
                });
          });
    }
  }

  void showDeleteProjectDialogAndProcessResult(BuildContext ctx) {
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
                    projectListSample.removeWhere(
                        (key, element) => selectedList.contains(element.id));

                    selectedList.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Stack(
                        children: [
                          Container(
                              width: 300,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(185, 43, 77, 46),
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

  Widget _controlButton(BuildContext ctx) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () => showAddProjectDialogAndProcessResult(ctx),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.add), Text('Thêm')],
            )),
        AppDefine.hpadding2,
        ElevatedButton(
            onPressed: () => showEditProjectDialogAndProcessResult(ctx),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.edit), Text('Sửa')],
            )),
        AppDefine.hpadding2,
        ElevatedButton(
            onPressed: () {
              showDeleteProjectDialogAndProcessResult(ctx);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.remove), Text('Xóa')],
            )),
      ],
    );
  }

  Future<void> getProjects() async {
    var lsData = await fetchProject();
    lsData.sort((a, b) => a.priority.compareTo(b.priority));
    setState(() {
      projectListApi = lsData;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
        padding: const EdgeInsets.all(AppDefine.defaultPadding),
        decoration: const BoxDecoration(
          color: AppDefine.secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _titlePage(),
              AppDefine.vpadding2,
              AppDefine.vpadding2,
              AppDefine.vpadding2,
              _controlButton(ctx),
              AppDefine.vpadding2,
              AppDefine.vpadding2,
              Flexible(
                flex: 80,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: SingleChildScrollView(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ProjectTableWidget(
                              projectList: projectListApi,
                              selectedList: selectedList,
                            ))),
                  ),
                ]),
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
