import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdapter.dart';
import '../../Models/FocusModel.dart';
import '../../Models/ProductModel.dart';

import '../../Config/Config.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  /// 获取轮播图数据
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      this._focusData = focusList.result;
    });
  }

  /// 获取猜你喜欢数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductList = hotProductList.result;
    });
  }

  /// 获取热门推荐数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                String pic = this._focusData[index].pic;
                return new Image.network(
                  '${Config.domain}${pic.replaceAll('\\', '/')}',
                  fit: BoxFit.fill,
                );
              },
              itemCount: this._focusData.length,
              pagination: new SwiperPagination(),
              autoplay: true),
        ),
      );
    } else {
      return Text('加载中。。。');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(10)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenAdapter.width(5)))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  /// 猜你喜欢
  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
          height: ScreenAdapter.height(205),
          padding: EdgeInsets.all(ScreenAdapter.width(10)),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this._hotProductList.length,
            itemBuilder: (context, index) {
              String pic = this._hotProductList[index].sPic;
              return Column(children: <Widget>[
                Container(
                  width: ScreenAdapter.width(140),
                  height: ScreenAdapter.height(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(10)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                        '${Config.domain}${pic.replaceAll('\\', '/')}',
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(5)),
                  height: ScreenAdapter.height(40),
                  child: Text(
                    '￥${this._hotProductList[index].price}',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ]);
            },
          ));
    } else {
      return Text('加载中。。。');
    }
  }

  /// 热门推荐
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 34) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: this._bestProductList.map((value) {
            String sPic = value.sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return InkWell(
              child: Container(
                padding: EdgeInsets.all(10),
                width: itemWidth,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: Image.network(sPic, fit: BoxFit.cover)),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                      child: Text(
                        '${value.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '￥${value.price}',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('￥${value.oldPrice}',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/productContent',arguments: {
                  'id':value.sId
                });
              },
            );
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(children: <Widget>[
      _swiperWidget(),
      SizedBox(height: ScreenAdapter.width(10)),
      _titleWidget('猜你喜欢'),
      SizedBox(height: ScreenAdapter.width(10)),
      _hotProductListWidget(),
      SizedBox(height: ScreenAdapter.width(10)),
      _titleWidget('热门推荐'),
      SizedBox(height: ScreenAdapter.width(10)),
      _recProductListWidget(),
    ]);
  }
}
