import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/MethodChannelService.dart';
import '../services/ScreenAdapter.dart';

class SearchAppBar {
  SearchAppBar(BuildContext context);

  static appBar(context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.center_focus_weak,
          size: 28,
          color: Colors.black87,
        ),
        onPressed: null,
      ),
      title: InkWell(
        child: Container(
          height: ScreenAdapter.height(50),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(ScreenAdapter.height(25))),
          padding: EdgeInsets.only(left: ScreenAdapter.height(15)),
          child: Row(
            children: <Widget>[
              Icon(Icons.search),
              Text('笔记本', style: TextStyle(fontSize: ScreenAdapter.size(28)))
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.message, size: 28, color: Colors.black87),
          onPressed: (){
            _pushNativePage();
          },
        )
      ],
    );

    
  }

  static  _pushNativePage() {
    MethodChannelService.pushNative();
  }


}
