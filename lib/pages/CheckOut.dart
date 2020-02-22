import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/CheckOutProvider.dart';
import '../services/ScreenAdapter.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {



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
    var checkOutProvider = Provider.of<CheckOutProvider>(context);

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
                    ListTile(
                      leading: Icon(Icons.add_location),
                      title: Center(
                        child: Text('请添加收货地址'),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: (){
                        Navigator.pushNamed(context, '/addressList');
                      },
                    )
                    // ListTile(
                    //   title: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       Text('张三  13918435837'),
                    //       SizedBox(height: ScreenAdapter.height(10)),
                    //       Text('河南省光山县破河镇')
                    //     ],
                    //   ),
                    //   trailing: Icon(Icons.navigate_next),
                    // )
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
                          child: Text('立即下单',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {}),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
