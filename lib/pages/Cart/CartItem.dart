import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('data'),
    );
  }
}