import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'CartNum.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Container(
      height: ScreenAdapter.height(160),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(80),
            child: Checkbox(
              value: true,
              onChanged: (check) {},
              activeColor: Colors.pink,
            ),
          ),
          Container(
            height: ScreenAdapter.height(120),
            child: Image.network(
                'http://www.itying.com/images/flutter/list2.jpg',
                fit: BoxFit.cover),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('在设置按钮弹出的菜单中,选择【Settings】选项,此处是整个vscode的设置入口',maxLines: 2),
                    Stack(
                      children: <Widget>[
                        Align(
                          child: Text('￥23',style: TextStyle(color: Colors.red)),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: CartNum(),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
