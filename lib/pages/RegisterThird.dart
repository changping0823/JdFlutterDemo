import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/tabs/Tabs.dart';
import '../services/Storage.dart';
import '../Config/Config.dart';
import '../widget/JdTextField.dart';
import '../widget/JdButton.dart';
import '../services/ScreenAdapter.dart';

class RegisterThirdPage extends StatefulWidget {
  final Map arguments;
  RegisterThirdPage({Key key,this.arguments}) : super(key: key);

  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel;
  String code;
  String password = '';
  String rpassword = '';

  @override
  void initState() { 
    super.initState();
    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
  }

  doRegister() async{
    if(this.password.length < 6){
      Fluttertoast.showToast(msg: "密码不能小于6位",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    if(this.password != this.rpassword){
      Fluttertoast.showToast(msg: "两次密码不一致",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    var api = '${Config.domain}api/register';
    var response = await Dio().post(api, data: {'tel': this.tel,'code': this.code,'password':this.password});
    if (response.data['success']) {
      Storage.setString('userInfo', json.encode(response.data['userinfo']));
        //返回到根
      Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Tabs()),
            (route) => route == null);
    } else {
      Fluttertoast.showToast(msg: "${response.data['message']}",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第三步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            JdTextField(
              placeholder: "请输入密码",
              secureTextEntry: true,
              onChanged: (value) {
                this.password = value;
              },
            ),
            SizedBox(height: 10),
            JdTextField(
              placeholder: "请输入确认密码",
              secureTextEntry: true,
              onChanged: (value) {
                this.rpassword = value;
              },
            ),
            SizedBox(height: 20),
            JdButton(
              text: "注册",
              color: Colors.red,
              height: 74,
              action: doRegister,
            )
          ],
        ),
      ),
    );
  }
}
