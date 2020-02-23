import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class JdTextField extends StatelessWidget {
  final String placeholder;
  final String text;

  /// 占位文字
  final bool secureTextEntry;

  /// 文本是否加密
  final ValueChanged<String> onChanged;
  final int maxLines;
  final double height;
  final TextEditingController controller;
  JdTextField(
      {Key key,
      this.placeholder = '输入内容',
      this.secureTextEntry = false,
      this.onChanged,
      this.maxLines = 1,
      this.height = 60,
      this.controller,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(this.height),
      padding: EdgeInsets.only(top: ScreenAdapter.height(0)),
      decoration: BoxDecoration(
          // color: Color.fromRGBO(233, 233, 233, 0.8),
          // borderRadius: BorderRadius.circular(ScreenAdapter.height(25))
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
            text: '${this.text == null ? "" : this.text}', //判断keyword是否为空
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.text}'.length)))),
        maxLines: this.maxLines,
        obscureText: this.secureTextEntry,
        // 保持光标在最后

        decoration: InputDecoration(
            hintText: this.placeholder,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenAdapter.height(25)),
                borderSide: BorderSide.none)),
        onChanged: this.onChanged,
      ),
    );
  }
}
