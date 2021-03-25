import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context) {
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // ScreenUtilInit(builder: builder);
    // ScreenUtil.init(width: 750, height: 1334);
    // ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
    // ScreenUtil.init(context, designSize: Size(750, 1334));

    // ScreenUtil.init(constraints)

  }


  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }


  static bottomSafeHeight() {
    return ScreenUtil().bottomBarHeight;
  }

  static statusHeight() {
    return ScreenUtil().statusBarHeight;
  }



    static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
