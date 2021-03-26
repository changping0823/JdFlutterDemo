
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/EventBus.dart';
import '../../Config/Config.dart';
import '../../services/SignServices.dart';
import '../../services/UserServices.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdTextField.dart';
import '../../widget/JdButton.dart';

class AddressAddPage extends StatefulWidget {
  AddressAddPage({Key key}) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';

  _addAddress() async {
    if (this.name.length == 0) {
      Fluttertoast.showToast(msg: '请输入收货人姓名',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    if (this.phone.length == 0) {
      Fluttertoast.showToast(msg: '请输入收货人手机号',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    if (this.area.length == 0) {
      Fluttertoast.showToast(msg: '请选择收获省市区',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    if (this.address.length == 0) {
      Fluttertoast.showToast(msg: '请输入收货人详细地址',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    Map userInfo = await UserServices.userInfo();
    Map json = {
      'uid': userInfo['_id'],
      'name': this.name,
      'phone': this.phone,
      'address': this.address,
      'salt': userInfo['salt']
    };
    String sign = SignServices.getSign(json);

    var api = '${Config.domain}api/addAddress';
    var result = await Dio().post(api,data: {
      'uid': userInfo['_id'],
      'name': this.name,
      'phone': this.phone,
      'address': this.address,
      'sign': sign
    });
    if (result.data['success']) {
      eventBus.fire(new ChangeAddressEvent('修改默认收货地址'));
      Navigator.pop(context);
    }
    // var hotProductList = ProductModel.fromJson(result.data);
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(new AddressEvent('新增收货地址成功'));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('新增收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            JdTextField(
                placeholder: '收货人姓名',
                onChanged: (value) {
                  this.name = value;
                }),
            SizedBox(height: ScreenAdapter.height(20)),
            JdTextField(
                placeholder: '收货人电话',
                onChanged: (value) {
                  this.phone = value;
                }),
            SizedBox(height: ScreenAdapter.height(20)),
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
              height: ScreenAdapter.height(60),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    Text(this.area.length == 0 ? '省/市/区' : this.area,
                        style: TextStyle(color: Colors.black54))
                  ],
                ),
                onTap: () async {
                  // Result result = await CityPickers.showCityPicker(
                  //     context: context,
                  //     cancelWidget:
                  //         Text('取消', style: TextStyle(color: Colors.black54)),
                  //     confirmWidget:
                  //         Text('确定', style: TextStyle(color: Colors.red)));
                  // if (result != null) {
                  //   setState(() {
                  //     this.area =
                  //         '${result.provinceName}/${result.cityName}/${result.areaName}';
                  //   });
                  // }
                },
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
            ),
            JdTextField(
                placeholder: '详细地址',
                onChanged: (value) {
                  this.address = this.area + value;
                },
                maxLines: 4,
                height: 100),
            SizedBox(height: ScreenAdapter.height(60)),
            JdButton(text: '增加', color: Colors.red, action: _addAddress)
          ],
        ),
      ),
    );
  }
}
