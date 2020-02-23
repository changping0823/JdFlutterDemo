import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/Config/Config.dart';
import 'package:flutter_jdshop/Models/OrderModel.dart';
import '../services/SignServices.dart';
import '../services/UserServices.dart';
import '../services/ScreenAdapter.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderModel _orderModel;

  _getOrderList() async {
    Map userInfo = await UserServices.userInfo();
    var tempJson = {'uid': userInfo['_id'], 'salt': userInfo['salt']};

    var sign = SignServices.getSign(tempJson);

    var api = '${Config.domain}api/orderList?uid=${userInfo['_id']}&sign=$sign';

    var response = await Dio().get(api);

    setState(() {
      this._orderModel = OrderModel.fromJson(response.data);
      print(this._orderModel.result);
    });
  }

  @override
  void initState() {
    super.initState();
    _getOrderList();
  }

  List<Widget> _orderItemWidget(value) {
    List<Widget> tempList = [];
    for (OrderItem item in value) {
      tempList.add(Column(
        children: <Widget>[
          SizedBox(height: 10),
          ListTile(
              leading: Container(
                width: ScreenAdapter.width(80),
                height: ScreenAdapter.width(80),
                child: Image.network('${item.productImg}', fit: BoxFit.cover),
              ),
              title: Text('${item.productTitle}'),
              trailing: Text('x${item.productCount}'))
        ],
      ));
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(76)),
            child: ListView(
              children: this._orderModel.result.map((value) {
                return InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('订单编号：${value.sId}',
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Divider(),
                        Column(
                          children: this._orderItemWidget(value.orderItem),
                        ),
                        ListTile(
                          leading: Text('合计：￥${value.allPrice}'),
                          trailing: FlatButton(
                            onPressed: () {},
                            child: Text('申请售后'),
                            color: Colors.grey[100],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/orderInfo');
                  }
                );
              }).toList(),
            ),
          ),
          Positioned(
              top: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(76),
              child: Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(76),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("全部", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("待付款", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("待收货", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("已完成", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("已取消", textAlign: TextAlign.center),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
