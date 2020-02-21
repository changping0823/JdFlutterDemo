import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Config/Config.dart';
import '../widget/JdTextField.dart';
import '../widget/JdButton.dart';
import '../services/ScreenAdapter.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel;

  sendCode() async{
    RegExp regexp = new RegExp(r'^1\d{10}$');
    if (regexp.hasMatch(this.tel)) {
      var api = '${Config.domain}api/sendCode';
      print(api);
      var response = await Dio().post(api,data:{'tel':this.tel});
      if(response.data['success']){
        Navigator.pushNamed(context, '/registerSecond',arguments: {'tel':this.tel,'code':response.data['code']});
      }else{
        Fluttertoast.showToast(msg: "${response.data['message']}",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      }
    } else {
      Fluttertoast.showToast(msg: "手机号不正确",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第一步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            JdTextField(
              placeholder: "请输入手机号",
              onChanged: (value) {
                this.tel = value;
              },
            ),
            SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              action: () {
                sendCode();
                // Navigator.pushNamed(context, '/registerSecond');
              },
            )
          ],
        ),
      ),
    );
  }
}

