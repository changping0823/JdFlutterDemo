import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../services/ScreenAdapter.dart';
import '../../Models/ProductContentModel.dart';

class ProductContentSecond extends StatefulWidget {
  final ProductContentItem _productContent;
  ProductContentSecond(this._productContent, {Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  String _sId;

  @override
  void initState() {
    super.initState();
    this._sId = widget._productContent.sId;

    // print(this._sId);
    // print('http://jd.itying.com/pcontent?id=${this._sId}');
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    print('http://jd.itying.com/pcontent?id=${this._sId}');

    return Container(
      color: Colors.red,
      width: ScreenAdapter.width(700),
      height: ScreenAdapter.height(700),
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=${this._sId}",
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {},
              initialOptions: InAppWebViewWidgetOptions(),
            ),
          )
        ],
      ),
    );
  }
}