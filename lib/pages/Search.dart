import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:flutter_jdshop/services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    _getHistoryListData();
  }

  _getHistoryListData() async {
    var historyListData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = historyListData;
    });
  }

  Widget _historyListWidget() {
    if (this._historyListData.length > 0) {
      return Column(
        children: <Widget>[
          Container(
            
            child: Text(
              '历史搜索',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text('$value'),
                  ),
                  Divider()
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 200),
          InkWell(
            child: Container(
              width: ScreenAdapter.width(600),
              height: ScreenAdapter.height(64),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.delete), Text('清空历史记录')],
              ),
            ),
            onTap: () {
              SearchServices.clearHistoryList();
              _getHistoryListData();
            },
          )
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(60),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(ScreenAdapter.height(25))),
          child: TextField(
            // autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.height(25)),
                    borderSide: BorderSide.none)),
            onChanged: (value) {
              this._keywords = value;
            },
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenAdapter.height(60),
              width: ScreenAdapter.height(60),
              child: Row(children: <Widget>[Text('搜索')]),
            ),
            onTap: () {
              SearchServices.setHistoryData(this._keywords);
              print(this._keywords);
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {'keywords': this._keywords});
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
            child: Text(
              '热搜',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Divider(),
          Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(5)),
                child: Text('女装'),
              )
            ],
          ),
          _historyListWidget()
        ]),
      ),
    );
  }
}
