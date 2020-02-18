import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/JdButton.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdTextField.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                print(value);
              },
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            JdTextField(
              placeholder: '请输入密码',
              secureTextEntry: true,
              onChanged: (value) {
                print(value);
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
              action: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
