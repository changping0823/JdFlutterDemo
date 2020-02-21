import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../Config/Config.dart';
import '../widget/JdTextField.dart';
import '../widget/JdButton.dart';
import '../services/ScreenAdapter.dart';

class RegisterSecondPage extends StatefulWidget {
  final Map arguments;
  RegisterSecondPage({Key key, this.arguments}) : super(key: key);

  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String tel = '';
  String code;
  bool sendCodeBtn = false;
  int seconds = 10;

  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments['tel'];
    this._showTimer();
    Fluttertoast.showToast(msg: "${widget.arguments['code']}",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);

  }

  _showTimer() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
        timer.cancel();

        ///清除定时器
        this.sendCodeBtn = true;
      }
    });
  }

  sendCode() async {
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {'tel': this.tel});
    if (response.data['success']) {
      print('${response.data}');
      setState(() {
        this.sendCodeBtn = false;
        this.seconds = 10;
        _showTimer();
      });
    } else {
      Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

  validateCode() async{
    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {'tel': this.tel,'code': this.code});
    if (response.data['success']) {
      Navigator.pushNamed(context, '/registerThird',arguments:{'tel':this.tel,'code':this.code});
    } else {
      Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第二步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("验证码已发送到您的${this.tel}手机号,请输入${this.tel}手机收到的验证码"),
            ),
            SizedBox(height: 40),
            Stack(
              children: <Widget>[
                JdTextField(
                  placeholder: "请输入验证码",
                  onChanged: (value) {
                    this.code = value;
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: this.sendCodeBtn
                      ? RaisedButton(
                          child: Text('重新发送'),
                          onPressed: () {
                            sendCode();
                          })
                      : RaisedButton(
                          child: Text('${this.seconds}秒后重发'), onPressed: () {}),
                )
              ],
            ),
            SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              action: validateCode,
            )
          ],
        ),
      ),
    );
  }
}
