



import 'package:flutter/material.dart';
import 'package:taskmanagement/api/loginapi.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/control/maincontrol.dart';
import 'package:taskmanagement/module/login/loginpage.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = MainControl().myUser();
    return Container(
      margin: const EdgeInsets.only(left: AppDefine.defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefine.defaultPadding,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        color: AppDefine.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_account.png",
            height: 28,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefine.defaultPadding / 2),
            child: Text(user.name),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onSelected: (value) {
              if (value == '/signout'){
                LoginApi.logout().then((ret){
                  if (ret.isEmpty){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginApp()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(ret))
                    );
                  }
                });

              }
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  value: '/account',
                  child: Text("Tài khoản"),
                ),
                PopupMenuItem(
                  value: '/signout',
                  child: Text("Đăng xuất"),
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}