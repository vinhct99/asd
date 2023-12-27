import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);
var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

final hostname = "http://127.0.0.1:3001";

class AppDefine {
  AppDefine._();

  static const appName = 'MiniVECO';
  static const title =
      "HỆ THỐNG QUẢN LÝ CÔNG VIỆC TT&TCĐT";

  static const int = 12;
  static const defaultPadding = 12.0;
  static const defaultPadding1 = 1.0;
  static const defaultPadding2 = 8.0;
  static const defaultPadding4 = 10.0;
  static const defaultPadding5 = 20.0;
  static const defaultMargin = 30.0;

  static const hpadding = SizedBox(
    width: defaultPadding,
  );
  static const hmargin = SizedBox(
    height: defaultMargin,
  );
  static const vpadding = SizedBox(
    height: defaultPadding,
  );
  static const hpadding2 = SizedBox(
    width: defaultPadding2,
  );
  static const vpadding2 = SizedBox(
    height: defaultPadding2,
  );
  static const hpadding4 = SizedBox(
    width: defaultPadding4,
  );
  static const vpadding4 = SizedBox(
    height: defaultPadding4,
  );
  static const vpadding5 = SizedBox(
    height: defaultPadding5,
  );

  static const primaryColor = Color(0xFF2697FF);
  static const secondaryColor = Color.fromARGB(255, 39, 43, 63);
  static const accentColor = Color(0xFFff8f26);
  static const bgColor = Color(0xFF212332);
  static const bgColorr = Color(0xff1A1C33);
  static const alertColor = Color(0xffcc0000);

  static const borderColor = Colors.white12;

  static const defaultFontSize = 13.0;

  static const TextStyle titleTextStyle = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w900,
    fontSize: 25,
  );
  static const TextStyle subTitleTextStyle = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle headerTextStyle = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w900,
    fontSize: 23,
  );

  static const defaultDecorator = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(8)
  );

  static const defaultBorderSide = BorderSide(
    color: borderColor,
    width: 1,
  );
  static const defaultHeaderHeight = 65.0;
  static const defaultHeaderWidth = 65.0;
  static const defaultRowHeight = 30.0;
  static const defaultTableBorder = TableBorder(
    top: defaultBorderSide,
    bottom: defaultBorderSide,
    left: defaultBorderSide,
    right: defaultBorderSide,
    verticalInside: defaultBorderSide,
  );
  static final defaultHeaderBackground =
      MaterialStateColor.resolveWith((states) => primaryColor.withAlpha(80));

  static const defaultTableHeaderStyle = TextStyle(
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );

  static Widget createGroupBox(String title, Widget widget) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppDefine.headerTextStyle),
          const SizedBox(height: defaultPadding),
          widget
        ]));
  }
}

String dayMonthFormat(DateTime dt) {
  return DateFormat('dd/MM/yyyy').format(dt);
}

String dayMonthFormatFromMs(int t) {
  return dayMonthFormat(DateTime.fromMillisecondsSinceEpoch(t));
}

const double defaultIconSize = 20;
