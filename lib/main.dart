import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmanagement/module/main/mainscreen.dart';

import 'common/widget/mymaterialapp.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // runApp(const MyMaterialApp(
    //   content: LoginPage(),
    // ));
    runApp(const MyMaterialApp(
      content: MainScreen(),
    ));
  });
}
