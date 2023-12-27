import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/control/maincontrol.dart';
import 'package:taskmanagement/control/usercontrol.dart';

class LoginApi {


  static Future<String> login(String username, String password) async {
    var request = http.Request('POST', Uri.parse('$hostname/login'));
    request.body = json.encode({
      "username": username,
      "password": password
    });
    request.headers.addAll({
      'Content-Type': 'application/json'
    });

    loggerNoStack.d('Start login $request, params ${request.body}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 401){
      loggerNoStack.d('401 Wrong username or password');
      return 'Tên đăng nhập hoặc mật khẩu sai';
    } else if (response.statusCode == 200) {
      final ret = await response.stream.bytesToString();
      loggerNoStack.d('response $ret');
      final retJson = json.decode(ret);
      final data = retJson['data'];
      final myUser = data['my_user'];
      
      final userControl = UserControl();
      final mainControl = MainControl();
      
      userControl.username = myUser['username'];
      userControl.name = myUser['name'];
      userControl.number = myUser['number'];

      mainControl.updateData(data);
      return '';
    } else {
      loggerNoStack.d(response.reasonPhrase);
      return 'Tên đăng nhập hoặc mật khẩu sai';
    }
  }

  static Future<String> logout() async {
    var request = http.Request('GET', Uri.parse('$hostname/logout'));
    request.headers.addAll({
      'Content-Type': 'application/json'
    });

    loggerNoStack.d('Start login $request, params ${request.body}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return '';
    } else {
      final ret = await response.stream.bytesToString();
      return 'Gặp lỗi $ret';
    }
  }
}