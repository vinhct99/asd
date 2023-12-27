import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmanagement/api/loginapi.dart';
import 'package:taskmanagement/common/appdefine.dart';
import 'package:taskmanagement/common/widget/mymaterialapp.dart';
import 'package:taskmanagement/module/main/mainscreen.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MiniVECO",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppDefine.secondaryColor,
        canvasColor: AppDefine.secondaryColor,
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Poppins',
        )
      ),
      home: const Scaffold(
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _onApplying = false;
  var focusNode = FocusNode();
  final _txtUsername = TextEditingController();
  final _txtPassword = TextEditingController();

  bool _isLoginEnable = true;
  
  String _notification = '';
  bool _notiIsWarn = true;

  void setNotification(String noti, bool isWarn){
    setState(() {
      _notification = noti;
      _notiIsWarn = isWarn;
    });
  }

  void doLogin(BuildContext context) {
    try {
      final username = _txtUsername.text;
      final password = _txtPassword.text;

      loggerNoStack.d('Start do login to server with username $username, password $password, time = ${DateTime.now().microsecondsSinceEpoch}');

      if (username.isEmpty || username.isEmpty){
        setNotification('Vui lòng nhập tên đăng nhập và mật khẩu', true);
        focusNode.requestFocus();
        return;
      }

      setState(() {
        _onApplying = true;
        _isLoginEnable = false;
      });

      LoginApi.login(username, password)
        .then((value){
          loggerNoStack.d('Login success time = ${DateTime.now().microsecondsSinceEpoch}');
          setState(() {
            _onApplying = false;
            _isLoginEnable = value.isNotEmpty;
          });
          if (value.isEmpty){
            setNotification('Đăng nhập thành công, đang chuyển hướng...', false);
            Timer(const Duration(milliseconds: 50), () => 
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyMaterialApp(
                  content: MainScreen(),
                ))
              )
            );
          } else {
            setNotification(value, true);
            focusNode.requestFocus();
          }
        });

    } catch (err) {
      _isLoginEnable = true;
      setNotification('Có lỗi đăng nhập trên hệ thống $err', true);
      focusNode.requestFocus();
      loggerNoStack.e(err);
    }
  }

  @override
  void initState() {
    super.initState();
    _txtPassword.text = 'khainv9';
    _txtUsername.text = 'khainv9';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppDefine.bgColor
        ),
        child: Center(
          child: Card(
            color: AppDefine.secondaryColor,
            child: Container(
              width: 320,
              margin: const EdgeInsets.only(
                  left: 48, right: 48, top: 48, bottom: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/ic_logo.png",
                        width: 64,
                        height: 64,
                        fit: BoxFit.fitWidth,
                      ),
                      AppDefine.hpadding,
                      const Text(
                        AppDefine.appName, 
                        style: AppDefine.titleTextStyle
                      ),
                    ],
                  ),
                  
                  AppDefine.vpadding2,
                  const Text('Tên đăng nhập'),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _txtUsername,
                    focusNode: focusNode,
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      if (_isLoginEnable) {
                        doLogin(context);
                      }
                    },
                    decoration: AppDefine.defaultDecorator,
                  ),
                  const SizedBox(height: 8),
                  const Text('Mật khẩu'),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _txtPassword,
                    onChanged: (value) {},
                    textInputAction: TextInputAction.go,
                    decoration: AppDefine.defaultDecorator,
                    obscureText: true,
                    onSubmitted: (value) {
                      if (_isLoginEnable){
                        doLogin(context);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  _notification.isEmpty ? null : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefine.defaultPadding2,
                      vertical: AppDefine.defaultPadding2
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _notiIsWarn ? Colors.red : Colors.green,
                      ),
                      color: _notiIsWarn ? const Color(0x66ff0000) : const Color(0x6600ff00),
                    ),
                    child: Row(children: [
                      Expanded(child: Text(_notification)), 
                      IconButton(onPressed: (){
                        setState(() {
                          _notification = '';
                        });
                      }, icon: const Icon(Icons.close))
                    ]),
                  ),
                  _notification.isEmpty ? null : AppDefine.vpadding2,
                  AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 1),
                    width: _onApplying ? 80 : 200,
                    height: 42,
                    child: ElevatedButton(
                      
                      onPressed: _isLoginEnable ? () {
                        doLogin(context);
                      } : null,
                      
                      child: _onApplying
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : const Text(
                              "Đăng nhập",
                              
                              style: TextStyle(color: Color(0xffffffff)),
                            ),
                    ),
                  ),
                ].where((e) => e != null).map((e) => e!).toList(),
              )
            )
          )
        ),
      )
    );
  }
}
