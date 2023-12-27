import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';

import 'package:taskmanagement/module/main/header/messagenotificationbutton.dart';

import 'notificationbutton.dart';
import 'profilecard.dart';

/// Mô tả tiêu đề phía trên của app / web
class Header extends StatelessWidget {
  final String title;
  final Function() notificationClicked;
  const Header(
      {Key? key, required this.title, required this.notificationClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppDefine.secondaryColor,
      child: Row(
        children: [
          const SizedBox(
            width: AppDefine.defaultPadding,
          ),
          const Text(
            AppDefine.title,
            maxLines: 3,
            overflow: TextOverflow.visible,
            style: AppDefine.headerTextStyle,
          ),
          Expanded(child: Container()),
          MessageNotificationButton(onPressed: () {}),
          NotificationButton(onPressed: notificationClicked),
          const ProfileCard()
        ],
      )
    );
  }
}
