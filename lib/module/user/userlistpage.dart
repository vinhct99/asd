import 'package:flutter/material.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/object/user.dart';
import 'package:taskmanagement/module/user/usertablewidget.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

enum UserSinglePageViewType { personal, team, project }

extension UserSinglePageViewTypeExt on UserSinglePageViewType {
  String toDisplay() {
    switch (this) {
      case UserSinglePageViewType.personal:
        return 'Cá nhân';
      case UserSinglePageViewType.team:
        return 'Nhóm';
      case UserSinglePageViewType.project:
        return 'Dự án';
    }
  }
}

class _UserListPageState extends State<UserListPage> {
  UserSinglePageViewType _type = UserSinglePageViewType.personal;
  int _row = -1;
  Widget _titlePage() {
    return Row(
      children: [
        const Text('Nhiệm vụ', style: AppDefine.headerTextStyle),
        Expanded(
          child: Container(),
        ),
        Wrap(
          spacing: 5.0,
          children: UserSinglePageViewType.values.map((e) {
            return ChoiceChip(
              label: Text(e.toDisplay()),
              selectedColor: AppDefine.primaryColor,
              backgroundColor: Colors.grey,
              selected: e == _type,
              onSelected: (v) {
                setState(() {
                  _type = e;
                });
              },
            );
          }).toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              const Text('Nhân sự', style: AppDefine.headerTextStyle),
              AppDefine.vpadding2,
              AppDefine.vpadding2,
              AppDefine.vpadding2,
              Row(
                children: [
                  UserTableWidget(
                    users: userSampleList.values.toList(),
                    onSelectionChanged: (int index) {
                      setState(() {
                        _row = index;
                      });
                    },
                  ),
                  AppDefine.hpadding2,
                  AppDefine.vpadding2,
                  Expanded(
                      child: _row == -1
                          ? const Text(
                              '    Chọn nhân sự bất kỳ để theo dõi',
                            )
                          : Column(mainAxisSize: MainAxisSize.max, children: [
                              _titlePage(),
                            ]))
                ],
              )
            ]));
  }
}
