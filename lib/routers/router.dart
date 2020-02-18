
import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/Search.dart';
import '../pages/ProductList.dart';
import '../pages/ProductContent.dart';
import '../pages/tabs/Cart.dart';
// 配置路由
final routers = {
  '/': (context) => Tabs(),
  '/search': (context) => SearchPage(),
  '/cart': (context) => CartPage(),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments:arguments)

};




// 固定写法
var onGenerateRouter = (RouteSettings settings){
  final String name = settings.name;
  final Function pageContentBuilder = routers[name];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context, arguments:settings.arguments));
      return route;  
    }else{
      final Route route = MaterialPageRoute(builder: (context)=> pageContentBuilder(context));
      return route;
    }
  }
};