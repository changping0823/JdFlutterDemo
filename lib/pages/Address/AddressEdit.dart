import 'package:flutter/material.dart';

class AddressEditPage extends StatefulWidget {
  AddressEditPage({Key key}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址'),
      ),
    );
  }
}