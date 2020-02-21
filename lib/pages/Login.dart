import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../services/EventBus.dart';
import '../Config/Config.dart';
import '../widget/JdButton.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdTextField.dart';
import '../services/Storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  _doLigin() async{
    RegExp regexp = new RegExp(r'^1\d{10}$');
    if (!regexp.hasMatch(this.username)) {
      Fluttertoast.showToast(msg: "手机号不正确",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    if (this.password.length <6 ) {
      Fluttertoast.showToast(msg: "密码不能小于6位",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }

     var api = '${Config.domain}api/doLogin';
      var response = await Dio().post(api,data:{'username':this.username,'password':this.password});
      if(response.data['success']){
        Storage.setString('userInfo', json.encode(response.data['userinfo']));

        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "${response.data['message']}",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      }

  }

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(new UserEvent('登陆成功'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        // title: Text('登录界面'),
        actions: <Widget>[FlatButton(onPressed: () {}, child: Text('客服'))],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
                width: ScreenAdapter.width(160),
                height: ScreenAdapter.width(160),
                child: Image.asset(
                  'images/login.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: ScreenAdapter.height(40)),
            JdTextField(
              placeholder: '请输入用户名',
              onChanged: (value) {
                this.username = value;
              },
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            JdTextField(
              placeholder: '请输入密码',
              secureTextEntry: true,
              onChanged: (value) {
                this.password = value;
              },
            ),

            SizedBox(height: ScreenAdapter.height(20)),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/registerFirst");
                      },
                      child: Text('忘记密码'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/registerFirst");
                      },
                      child: Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: ScreenAdapter.height(20)),
            
            JdButton(
              text: '登录',
              height: ScreenAdapter.height(110),
              color: Colors.red,
              action: _doLigin,
            )
          ],
        ),
      ),
    );
  }
}
