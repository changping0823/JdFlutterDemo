import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Provider/CartCounter.dart';
import '../../services/CartService.dart';
import '../../Config/Config.dart';
import '../../Models/ProductContentModel.dart';
import '../../widget/JdButton.dart';
import 'ProductNum.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/EventBus.dart';

class ProductContentFirst extends StatefulWidget {
  final ProductContentItem _productContent;
  ProductContentFirst(this._productContent, {Key key}) : super(key: key);

  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  List<Attr> _attr = [];
  ProductContentItem _productContent;
  String _selectedAttr;
  var actionEventBus;
  CartCounter _cartCounter;

  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContent;
    this._attr = this._productContent.attr;
    print('xxxxxxxxxx-------');
    _initAttr();

    /// 监听广播
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      this._attrBottomSheet();
    });
  }

  void dispose() {
    super.dispose();
    print('dispose');

    /// 取消监听事件
    this.actionEventBus.cancel();
  }

  _initAttr() {
    var attr = this._attr;
    for (Attr item in attr) {
      item.attrList.clear();
      for (var i = 0; i < item.list.length; i++) {
        var v = item.list[i];
        item.attrList.add({'title': v, 'checked': i == 0});
      }
    }

    _getSelectedAttrValue();
  }

  _changeAttr(cate, title, setBottomState) {
    List<Attr> attr = this._attr;
    for (Attr item in attr) {
      if (item.cate == cate) {
        for (var a in item.attrList) {
          a['checked'] = a['title'] == title;
        }
      }
    }
    setBottomState(() {
      this._attr = attr;
    });

    _getSelectedAttrValue();
  }

  _getSelectedAttrValue() {
    var attr = this._attr;
    List tempArr = [];
    for (var item in attr) {
      for (var a in item.attrList) {
        if (a['checked'] == true) {
          tempArr.add(a['title']);
        }
      }
    }
    // print(tempArr);
    setState(() {
      this._selectedAttr = tempArr.join(',');
      this._productContent.selectedAttr = this._selectedAttr;
    });
  }

  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (contex) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                //解决showModalBottomSheet点击消失的问题
                onTap: () {
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(20)),
                      child: ListView(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: this._attr.map((value) {
                                return Wrap(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenAdapter.width(100),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenAdapter.height(22)),
                                        child: Text("${value.cate}: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    _attrWidget(value, setBottomState)
                                  ],
                                );
                              }).toList()),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Text("数量: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              ProductNum(this._productContent)
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(100),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: JdButton(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "加入购物车",
                                action: () async {
                                  await CartService.addProduct(
                                      this._productContent);

                                  /// 关闭筛选弹出框
                                  Navigator.pop(context);

                                  ///调用provider更新数据
                                  this._cartCounter.updateProductList();
                                  Fluttertoast.showToast(msg: "加入购物车成功",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER,);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: JdButton(
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  text: "立即购买",
                                  action: () {
                                    print('立即购买');
                                  },
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  _attrWidget(Attr value, setBottomState) {
    return Container(
      width: ScreenAdapter.width(610),
      child: Wrap(
        children: value.attrList.map((item) {
          return InkWell(
            onTap: () {
              _changeAttr(value.cate, item['title'], setBottomState);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Chip(
                label: Text("${item['title']}",
                    style: TextStyle(color: Colors.white)),
                padding: EdgeInsets.all(10),
                backgroundColor: item['checked'] ? Colors.red : Colors.black26,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    this._cartCounter = Provider.of<CartCounter>(context);

    ScreenAdapter.init(context);
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network("$pic", fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("${this._productContent.title}",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdapter.size(36))),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("${this._productContent.subTitle}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.size(28)))),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text("¥${this._productContent.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text("¥${this._productContent.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("已选: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${this._selectedAttr}")
                      ],
                    ),
                  ),
                )
              : Text(''),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
