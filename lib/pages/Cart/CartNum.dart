import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  final Map _itmeData;
  CartNum(this._itmeData,{Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  Map _itmeData;

  @override
  void initState() { 
    super.initState();
    this._itmeData = widget._itmeData;
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: ScreenAdapter.width(160),
      height: ScreenAdapter.height(40),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _leftButton(),
          _centerArea(),
          _rightButton()
        ],
      ),
    );
  }

  // 左边按钮
  Widget _leftButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        child: Text('-'),
      ),
    );
  }

  // 右边按钮
  Widget _rightButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        child: Text('+'),
      ),
    );
  }

  // 中间区域
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(66),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(width: 1, color: Colors.black12),
        right: BorderSide(width: 1, color: Colors.black12),
      )),
      child: Text('${this._itmeData['count']}'),
    );
  }
}
