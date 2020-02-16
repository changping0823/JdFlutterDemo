import 'package:flutter/material.dart';

class CartCounter with ChangeNotifier {
  List _cartList = [];

  List get cartList=>this._cartList;
  int get cartNum=>this._cartList.length;

  addList(value) {
    this._cartList.add(value);
    notifyListeners();
  }
}
