import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
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
            ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.check, color: Colors.red),
                  title: Text('xxxx'),
                  subtitle: Text('aaaaaaaa'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.red),
                  title: Text('xxxx'),
                  subtitle: Text('aaaaaaaa'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.red),
                  title: Text('xxxx'),
                  subtitle: Text('aaaaaaaa'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.red),
                  title: Text('xxxx'),
                  subtitle: Text('aaaaaaaa'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
              ],
            ),
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
