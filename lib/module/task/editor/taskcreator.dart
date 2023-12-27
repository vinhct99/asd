// import 'package:flutter/material.dart';
// import 'package:taskmanagement/common/appdefine.dart';
// import 'package:taskmanagement/common/object.dart';


// class TaskCreatorDialog extends StatefulWidget {
//   const TaskCreatorDialog({super.key});

//   @override
//   State<TaskCreatorDialog> createState() => _TaskCreatorDialogState();
// }

// class _TaskCreatorDialogState extends State<TaskCreatorDialog> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width * 0.7;
//     double height = MediaQuery.of(context).size.height * 0.7;
//     return AlertDialog(
//     backgroundColor: const Color(0xff3B3C47),
//     contentPadding: const EdgeInsets.all(AppDefine.defaultPadding),
//     title: const Text(
//       'Thêm nhiệm vụ mới',
//       style: AppDefine.headerTextStyle,
//     ),

//     content: SizedBox(
//         width: width,
//         height: height,

//     )
//     );
//   }
// }