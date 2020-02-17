import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'CartNum.dart';

class CartItem extends StatefulWidget {
  final Map _itmeData;
  CartItem(this._itmeData,{Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

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
            child: Image.network('${this._itmeData['pic']}',fit: BoxFit.cover),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${this._itmeData['title']}',maxLines: 2),
                    Text('${this._itmeData['selectedAttr']}',maxLines: 2),
                    Stack(
                      children: <Widget>[
                        Align(
                          child: Text('￥${this._itmeData['price']}',style: TextStyle(color: Colors.red)),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: CartNum(this._itmeData),
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
