import 'package:flutter/material.dart';
import '../../Models/ProductContentModel.dart';

class ProductContentSecond extends StatefulWidget {

  final ProductContentItem _productContent;
  ProductContentSecond(this._productContent,{Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('商品详情'),
    );
  }
}