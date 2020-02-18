import 'package:flutter/material.dart';
import 'dart:convert';

import '../services/Storage.dart';

class CartCounter with ChangeNotifier {
  List _cartList = [];

  /// 是否全选
  bool _isCheckAll = false;

  /// 总价
  double _totalPrice = 0.0;

  List get cartList => this._cartList;
  int get cartNum => this._cartList.length;
  bool get isCheckAll => this._isCheckAll;
  double get totalPrice => this._totalPrice;

  CartCounter() {
    this.init();
  }

  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    this._isCheckAll = isCheckedAll();
    /// 计算总价
    this.computTotalPrice();
    notifyListeners();
  }

  addProduct(value) {
    this._cartList.add(value);
    /// 计算总价
    this.computTotalPrice();
    notifyListeners();
  }

  updateProductList() {
    this.init();
  }

  productCountChange(){
    Storage.setString('cartList', json.encode(this._cartList));
    /// 计算总价
    this.computTotalPrice();
    notifyListeners();
  }

  checkedAll(value) {
    for (var item in this._cartList) {
      item['checked'] = value;
    }
    this._isCheckAll = value;
    Storage.setString('cartList', json.encode(this._cartList));
    /// 计算总价
    this.computTotalPrice();
    notifyListeners();
  }

  bool isCheckedAll() {
    if (this._cartList.length > 0) {
      for (var i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]['checked'] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  productChecked(){
    this._isCheckAll = this.isCheckedAll();
    Storage.setString('cartList', json.encode(this._cartList));
    /// 计算总价
    this.computTotalPrice();
    notifyListeners();
  }

  /// 计算总价
  computTotalPrice() {
    double tempPrice = 0;
    for (var i = 0; i < this._cartList.length; i++) {
      Map map = this._cartList[i];
      if (map['checked'] == true) {
        tempPrice += map['price'] * map['count'];
      }
    }
    this._totalPrice = tempPrice;
    notifyListeners();
  }

    /// 删除数据
  removeProduct(){
    List tempList = [];
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]['checked'] == false) {
        tempList.add(this._cartList[i]);
      }
    }
    this._cartList = tempList;
    Storage.setString("cartList", json.encode(this._cartList));
    //计算总价
    this.computTotalPrice();
  }
}
