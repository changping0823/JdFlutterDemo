import 'package:flutter/material.dart';

class CheckOutProvider with ChangeNotifier {
  List _checkOutList = [];
  List get checkOutList => this._checkOutList;

  changeCheckOutListData(data){
    this._checkOutList = data;
    notifyListeners();
  }
}