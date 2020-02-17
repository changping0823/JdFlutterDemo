import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../Provider/CartCounter.dart';
import '../Cart/CartItem.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var cartCounter = Provider.of<CartCounter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[IconButton(icon: Icon(Icons.edit), onPressed: null)],
      ),
      body: Stack(
        
        children: <Widget>[
          cartCounter.cartList.length > 0?ListView(
            children: <Widget>[
              Column(
                children: cartCounter.cartList.map((value){
                  return CartItem(value);
                }).toList(),
              ),
              SizedBox(height: ScreenAdapter.height(88))
            ],
          ):Center(child: Text('暂无数据')),
          Positioned(
            bottom: ScreenAdapter.bottomSafeHeight(),
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(88),
            child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(60),
                            child: Checkbox(
                                value: true,
                                activeColor: Colors.pink,
                                onChanged: (check) {}),
                          ),
                          Text('全选')
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                          color: Colors.red,
                          child:
                              Text('结算', style: TextStyle(color: Colors.white)),
                          onPressed: () {}),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
