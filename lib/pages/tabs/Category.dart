import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../widget/SrarchAppBar.dart';
import '../../services/ScreenAdapter.dart';
import '../../Config/Config.dart';
import '../../Models/CateModel.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[this._selectIndex].sId);
  }

  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
          height: double.infinity,
          width: leftWidth,
          child: ListView.builder(
              itemCount: this._leftCateList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          setState(() {
                            _selectIndex = index;
                            _getRightCateData(this._leftCateList[index].sId);
                          });
                        },
                        child: Container(
                          child: Text('${this._leftCateList[index].title}',textAlign: TextAlign.center),
                          width: double.infinity,
                          height: ScreenAdapter.height(84),
                          padding: EdgeInsets.only(top:ScreenAdapter.height(24)),

                          color: _selectIndex == index ? Color.fromRGBO(240, 240, 240, 1.0) : Colors.white,
                        )),
                    Divider(height: 1)
                  ],
                );
              }));
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if(this._rightCateList.length > 0){
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 240, 240, 1.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: this._rightCateList.length,
              itemBuilder: (context, index) {
                String pic = this._rightCateList[index].pic;
                pic = Config.domain+pic.replaceAll('\\', '/');
                return InkWell(
                  onTap:(){
                    Navigator.pushNamed(context, '/productList',arguments: {
                      'cid':this._rightCateList[index].sId
                    });
                  },
                  child:Container(

                    child: Column(children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network('$pic',fit: BoxFit.cover),
                  ),
                  Container(
                    height: ScreenAdapter.height(25),
                    child: Text(this._rightCateList[index].title),
                  )
                ]))
                );
              }),
        ));

    }else{
      return Expanded(
        flex: 1,
        child: Container(
          padding:EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 240, 240, 1.0),
          child: Text('加载中。。。'),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    /*
    添加AutomaticKeepAliveClientMixin，
    并实现对应的方法bool get wantKeepAlive => true;
    同时build方法实现父方法 super.build(context);
    */ 
    super.build(context);
    ScreenAdapter.init(context);
    var screenWidth = ScreenAdapter.getScreenWidth();
    var leftWidth = screenWidth / 4;
    var rightItemWidth = (screenWidth - leftWidth - 20 - 20) / 3;
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(25);

    return Scaffold(
      appBar: SearchAppBar.appBar(context),
      body: Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    ),
    );
  }
}
