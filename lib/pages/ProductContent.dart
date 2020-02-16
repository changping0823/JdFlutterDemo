import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/JdButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jdshop/widget/LoadingWidget.dart';
import '../services/ScreenAdapter.dart';
import '../Config/Config.dart';
import '../Models/ProductContentModel.dart';

import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';


class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);
  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

PopupMenuItem _popupMenuItem(icon, title) {
  return PopupMenuItem(
      child: Row(
    children: <Widget>[Icon(icon), Text(title)],
  ));
}

class _ProductContentPageState extends State<ProductContentPage> {
  ProductContentItem _productContent;

  @override
  void initState() {
    super.initState();
    _getContentData();
  }

  _getContentData() async{
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);
    print(productContent.result);
    setState(() {
      this._productContent = productContent.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(400),
                child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(child: Text('商品')),
                      Tab(child: Text('详情')),
                      Tab(child: Text('评价')),
                    ]),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
                iconSize: 30,
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdapter.width(700), 100, 10, 0),
                      items: [
                        _popupMenuItem(Icons.home, '首页'),
                        _popupMenuItem(Icons.search, '搜索'),
                      ]);
                })
          ],
        ),
        body:this._productContent==null?LoadingWidget():Stack(
          children: <Widget>[
            TabBarView(children: <Widget>[
              ProductContentFirst(this._productContent),
              ProductContentSecond(this._productContent),
              ProductContentThird(),
            ]),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black38,
                      width: 1
                    )
                  ),
                  color: Colors.white
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top:5),
                      width: 100,
                      height: ScreenAdapter.height(100),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Text('购物车')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:JdButton(color: Colors.red,text: '加入购物车',action: (){
                        print('加入购物车');

                      })
                    ),
                    Expanded(
                      flex: 1,
                      child:JdButton(color: Color.fromRGBO(255, 165, 0, 0.9),text: '立即购买',action: (){
                        print('立即购买');

                      })
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
