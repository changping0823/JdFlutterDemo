import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:flutter_jdshop/widget/SrarchAppBar.dart';
import '../../widget/SrarchAppBar.dart';
import 'Home.dart';
import 'Category.dart';
import 'Cart.dart';
import 'User.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _pageController;
  List<Widget> _pageList=[
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage()
  ];

  @override
  void initState() { 
    super.initState();
    this._pageController = new PageController(initialPage:this._currentIndex);
  }


  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    _showAppBar(context,currentIndex){
      if(currentIndex == 0 || currentIndex == 1){
        return SearchAppBar.appBar(context);
      }else if(currentIndex == 2){
        return AppBar(title: Text("购物车"));
      }else if(currentIndex == 3){
        return AppBar(title: Text("用户中心"));
      }
      return AppBar(title: Text(""));
    }


    return Scaffold(
      appBar: _showAppBar(context, this._currentIndex),
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁止pageView滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的"))
        ],
      ),
    );
  }
}