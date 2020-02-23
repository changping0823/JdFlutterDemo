import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdButton.dart';

class PayPage extends StatefulWidget {
  final Map arguments;
  PayPage({Key key, this.arguments}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "chekced": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "chekced": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];

  

  @override
  void initState() {
    super.initState();
    print(widget.arguments);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('支付'),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: this.payList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: Image.network(this.payList[index]['image']),
                          title: Text(this.payList[index]['title']),
                          trailing: this.payList[index]['chekced']
                              ? Icon(Icons.check)
                              : null,
                          onTap: () {
                            setState(() {
                              for (var i = 0; i < this.payList.length; i++) {
                                this.payList[i]['chekced'] = i == index;
                              }
                            });
                          },
                        ),
                        Divider()
                      ],
                    );
                  })),
          JdButton(
              text: '支付',
              color: Colors.red,
              height: ScreenAdapter.height(98),
              action: () async{
                Navigator.pop(context, '/cart');
              })
        ],
      ),
    );
  }
}
