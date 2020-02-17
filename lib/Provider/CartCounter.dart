import 'package:flutter/material.dart';
import 'dart:convert';

import '../services/Storage.dart';

class CartCounter with ChangeNotifier {
  List _cartList = [];

  List get cartList=>this._cartList;
  int get cartNum=>this._cartList.length;

  CartCounter(){
    this.init();
  }
  
  init() async{
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    notifyListeners();
  }

  addList(value) {
    this._cartList.add(value);
    notifyListeners();
  }

  updateCartList(){
    this.init();
  }
}
