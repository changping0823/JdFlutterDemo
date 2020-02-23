import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../services/EventBus.dart';
import '../../Config/Config.dart';
import '../../services/SignServices.dart';
import '../../services/UserServices.dart';
import '../../services/ScreenAdapter.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];

  /// 获取收货地址列表
  _getAddressList() async {
    Map userInfo = await UserServices.userInfo();

    var json = {'uid': userInfo['_id'], 'salt': userInfo['salt']};

    String sign = SignServices.getSign(json);

    var api =
        '${Config.domain}api/addressList?uid=${userInfo['_id']}&sign=$sign';
    var respones = await Dio().get(api);
    if (respones.data['success']) {
      setState(() {
        this.addressList = respones.data['result'];
      });
    }
  }
  
  /// 修改默认收货地址
  _changeDefaultAddress(addressId) async{
    Map userInfo = await UserServices.userInfo();
    var json = {'uid': userInfo['_id'],'id': addressId, 'salt': userInfo['salt']};
    String sign = SignServices.getSign(json);
    var api = '${Config.domain}api/changeDefaultAddress';
    var respones = await Dio().post(api,data: {
      'uid': userInfo['_id'],
      'id':addressId,
      'sign': sign
    });


    if (respones.data['success']) {
      Navigator.pop(context);
    }
  }

    /// 删除收货地址
  _deleteAddress(addressId) async{
    Map userInfo = await UserServices.userInfo();
    var json = {'uid': userInfo['_id'],'id': addressId, 'salt': userInfo['salt']};
    String sign = SignServices.getSign(json);
    var api = '${Config.domain}api/deleteAddress';
    await Dio().post(api,data: {
      'uid': userInfo['_id'],
      'id':addressId,
      'sign': sign
    });
    _getAddressList();


  }

  _showAlertDialog(addressId) async{
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('您确定要删除吗？'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('取消')
              ),
              FlatButton(
                onPressed: (){
                  _deleteAddress(addressId);
                  Navigator.pop(context);
                },
                child: Text('确定')
              )
            ],
          );
        }
    );

  }

  @override
  void initState() {
    super.initState();
    _getAddressList();
    eventBus.on<AddressEvent>().listen((event){
      _getAddressList();
    });
     eventBus.on<EditAddressEvent>().listen((event){
      _getAddressList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(new ChangeAddressEvent('修改默认收货地址'));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: this.addressList.length,
                itemBuilder: (context, index) {
                  Map address = this.addressList[index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: address['default_address'] == 1?Icon(Icons.check, color: Colors.red):null,
                        title: InkWell(
                          highlightColor: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${address['name']}  ${address['phone']}'),
                              SizedBox(height: ScreenAdapter.height(10)),
                              Text(address['address'])
                            ],
                          ),
                          onTap: () async{
                            if (address['default_address'] == 0) {
                              await _changeDefaultAddress(address['_id']);
                             }else{
                               Navigator.pop(context);
                             }
                          },
                          onLongPress: ()async{
                            await _showAlertDialog(address['_id']);
                          },
                        ),
                        trailing: IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: (){
                          Navigator.pushNamed(context, '/addressEdit',arguments: address);
                        }),
                      ),
                      Divider(),
                    ],
                  );
                }),
            Positioned(
                bottom: ScreenAdapter.bottomSafeHeight(),
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(88),
                child: Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(30)),
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(88),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black12))),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white),
                        Text('增加收货地址', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
