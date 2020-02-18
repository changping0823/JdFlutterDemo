import 'package:flutter/material.dart';

class JdButton extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  final GestureTapCallback action;
  JdButton({Key key,this.color=Colors.black,this.text='按钮',this.action,this.height=80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: InkWell(
        onTap: this.action,
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text('$text', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
