import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../Models/ProductContentModel.dart';

class ProductNum extends StatefulWidget {
  final ProductContentItem _productContent;
  ProductNum(this._productContent, {Key key}) : super(key: key);

  @override
  _ProductNumState createState() => _ProductNumState();
}

class _ProductNumState extends State<ProductNum> {
  ProductContentItem _productContent;
  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContent;
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
        children: <Widget>[_leftButton(), _centerArea(), _rightButton()],
      ),
    );
  }

  // 左边按钮
  Widget _leftButton() {
    return InkWell(
      onTap: () {
        if (this._productContent.count > 1) {
          setState(() {
            this._productContent.count--;
          });
        }
      },
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
      onTap: () {
        setState(() {
          this._productContent.count++;
        });
      },
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
      child: Text('${this._productContent.count}'),
    );
  }
}
