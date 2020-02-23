import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../Config/Config.dart';
import '../Provider/CheckOutProvider.dart';
import '../Provider/CartCounter.dart';
import '../services/CartService.dart';
import '../services/CheckOutService.dart';
import '../services/SignServices.dart';
import '../services/UserServices.dart';
import '../services/ScreenAdapter.dart';
import '../services/EventBus.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Map _defaultAddress;
  CheckOutProvider checkOutProvider;
  CartCounter cartProvider;

  _getDefaultAddress()async{
    Map userInfo = await UserServices.userInfo();
    var json = {'uid': userInfo['_id'], 'salt': userInfo['salt']};
    String sign = SignServices.getSign(json);
    var api ='${Config.domain}api/oneAddressList?uid=${userInfo['_id']}&sign=$sign';
    var respones = await Dio().get(api);
    if (respones.data['success']) {
      List addressList = respones.data['result'];
      setState(() {
        this._defaultAddress = addressList.first;
      });
    }
  }
  
  _submitOrders() async{
    if(this._defaultAddress == null){
      Fluttertoast.showToast(msg: '请填写收货地址',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    Map userInfo = await UserServices.userInfo();
    String allPrice = CheckOutService.computTotalPrice(checkOutProvider.checkOutList).toStringAsFixed(1);
    var sign = SignServices.getSign({
       'uid': userInfo['_id'],
       'salt': userInfo['salt'],
       'phone':this._defaultAddress['phone'],
       'name':this._defaultAddress['name'],
       'address':this._defaultAddress['address'],
       'products':json.encode(checkOutProvider.checkOutList),
       'all_price':allPrice
       }
     );

    var api ='${Config.domain}api/doOrder';
    var respones = await Dio().post(api,data: {
       'uid': userInfo['_id'],
       'sign': sign,
       'phone':this._defaultAddress['phone'],
       'name':this._defaultAddress['name'],
       'address':this._defaultAddress['address'],
       'products':json.encode(checkOutProvider.checkOutList),
       'all_price':allPrice
       });

    if (respones.data['success']) {

      await CartService.removeCheckOutItem();
      cartProvider.updateProductList();
      Navigator.pushNamed(context, '/pay',arguments: respones.data['result']);
    }

  }

  @override
  void initState() { 
    super.initState();
    _getDefaultAddress();
    eventBus.on().listen((event){
      _getDefaultAddress();
    });
  }



  Widget _checkOutItem(value) {
    return Row(
      children: <Widget>[
        Container(
          height: ScreenAdapter.height(120),
          child: Image.network('${value['pic']}',fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${value['title']}', maxLines: 2),
                  Text('${value['selectedAttr']}', maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        child:
                            Text('￥${value['price']}', style: TextStyle(color: Colors.red)),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        child: Text('x${value['count']}'),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    checkOutProvider = Provider.of<CheckOutProvider>(context);
    cartProvider = Provider.of<CartCounter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('结算'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    this._defaultAddress == null ? ListTile(
                      leading: Icon(Icons.add_location),
                      title: Center(
                        child: Text('请添加收货地址'),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: (){
                        Navigator.pushNamed(context, '/addressAdd');
                      },
                    ):ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${this._defaultAddress['name']}  ${this._defaultAddress['phone']}'),
                          SizedBox(height: ScreenAdapter.height(10)),
                          Text('${this._defaultAddress['address']}')
                        ],
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: (){
                        Navigator.pushNamed(context, '/addressList');
                      },
                    )
                    
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  children: checkOutProvider.checkOutList.map((value){
                    return Column(
                      children: <Widget>[
                        this._checkOutItem(value),
                        Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('商品总金额：￥1000'),
                    Divider(),
                    Text('商品总金额：￥10'),
                    Divider(),
                    Text('运费：￥10'),
                  ],
                ),
              )
            ],
          ),
          Positioned(
              bottom: ScreenAdapter.bottomSafeHeight(),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(98),
              child: Container(
                padding: EdgeInsets.all(ScreenAdapter.width(30)),
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(98),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black12))),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('总价：￥140', style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                          color: Colors.red,
                          child: Text('立即下单',style: TextStyle(color: Colors.white)),
                          onPressed: _submitOrders
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
