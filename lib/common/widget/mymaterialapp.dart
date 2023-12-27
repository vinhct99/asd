


import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskmanagement/common/appdefine.dart';

class MyMaterialApp extends StatelessWidget {
  final Widget content;
  const MyMaterialApp({super.key, required this.content});

  TextTheme _buildTextTheme() {
    return const TextTheme(
      
      bodyMedium: TextStyle(
        // fontSize: AppDefine.defaultFontSize,
        fontFamily: 'Poppins'
      ),
      bodySmall: TextStyle(
        // fontSize: 10,
        fontFamily: 'Poppins'
      ),
      // Các thuộc tính khác ở đây...
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'US'), //
        Locale('vi', 'VN'), // English, UK
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: AppDefine.appName,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppDefine.secondaryColor,
        canvasColor: AppDefine.secondaryColor,
        brightness: Brightness.dark,
        textTheme: _buildTextTheme(),
      ),
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: AppDefine.secondaryColor,
      //   canvasColor: AppDefine.secondaryColor,
      //   textTheme: ThemeData.dark().textTheme.apply(
      //     fontFamily: 'Poppins',
          
      //   )
      // ),
      home: content
    );
  }
}