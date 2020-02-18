import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class JdTextField extends StatelessWidget {
  final String placeholder;/// 占位文字
  final bool secureTextEntry;/// 文本是否加密
  final ValueChanged<String> onChanged;
  JdTextField({Key key,this.placeholder='输入内容',this.secureTextEntry=false,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(60),
      padding: EdgeInsets.only(top:ScreenAdapter.height(0)),
      decoration: BoxDecoration(
          // color: Color.fromRGBO(233, 233, 233, 0.8),
          // borderRadius: BorderRadius.circular(ScreenAdapter.height(25))
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
      ),
      child: TextField(
        obscureText: this.secureTextEntry,
          decoration: InputDecoration(
            hintText: this.placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenAdapter.height(25)),
                borderSide: BorderSide.none
                )
              ),
          onChanged: this.onChanged,
        ),
    );
  }
}
