import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/control/maincontrol.dart';
import 'package:taskmanagement/module/task/tasklistpage.dart';
import 'package:taskmanagement/module/user/userlistpage.dart';
import 'package:taskmanagement/module/project/projectlistpage.dart';
import 'header/header.dart';
import 'sidemenu.dart';

class ScreenData {
  String name;
  String image;
  Widget screen;
  ScreenData(
      {
      required this.name,
      required this.image,
      required this.screen});
}

var overviewScreen = ScreenData(
  name: "Nhiệm vụ",
  image: "assets/icons/menu_dashbord.svg",
  screen: const TaskListPage(),
);

var userScreen = ScreenData(
  name: "Nhân sự",
  image: "assets/icons/menu_store.svg",
  screen: const UserListPage(),
);
var projectScreen = ScreenData(
  name: "Dự án",
  image: "assets/icons/menu_store.svg",
  screen: const ProjectListPage(),
);
var accountScreen = ScreenData(
  name: "Tài khoản",
  image: "assets/icons/menu_profile.svg",
  screen: Container(),
);

var helpScreen = ScreenData(
  name: "Trợ giúp",
  image: "assets/icons/menu_doc.svg",
  screen: Container(),
);

var adminScreen = ScreenData(
  name: "Quản trị",
  image: "assets/icons/menu_notification.svg",
  screen: Container(),
);

var screenList = [
  overviewScreen,
  userScreen,
  projectScreen,
  accountScreen,
  helpScreen,
];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _stackIndex = 0;
  void setStackIndex(int index) {
    // final userControl = UserControl();
    // if (userControl.role != "Administrator" && index == settingIndex){
    //     context.read<MenuController>().closeMenu();
    //     final snackBar = SnackBar(
    //       content: Text(
    //         'Chỉ Quản trị viên mới có quyền truy cập quản lý tài khoản'
    //       ),
    //     );
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     return;
    // }
    setState(() {
      _stackIndex = index;
    });
    // userControl.setCurrentStackIndex(index);
  }

  @override
  void initState() {
    super.initState();

    final control = MainControl();
    final myUser = control.myUser();
    if (myUser.position.isAdmin()) {
      screenList.add(adminScreen);
    }

    // Timer(Duration(seconds: 1), (){
    //   setStackIndex(reportIndex );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        requestChangeStackIndex: setStackIndex,
        currentStackIndex: _stackIndex,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: SideMenu(
                requestChangeStackIndex: setStackIndex,
                currentStackIndex: _stackIndex,
              ),
            ),
            Expanded(
                child: Container(
                    padding:
                        const EdgeInsets.all(AppDefine.defaultPadding2),
                    child: Column(
                      children: [
                        Header(
                          title: 'test',
                          notificationClicked: () {
                            // setStackIndex(eventScreen.index);
                          },
                        ),
                        AppDefine.vpadding2,
                        Expanded(
                            child: IndexedStack(
                          index: _stackIndex,
                          children:
                              screenList.map((e) => e.screen).toList(),
                        )),
                      ],
                    )))
          ],
        ),
      ),
    );
    
  }
}
