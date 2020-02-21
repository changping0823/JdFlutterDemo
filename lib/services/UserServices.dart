import '../services/Storage.dart';
import 'dart:convert';

class UserServices{
  static userInfo() async{
     List userinfo;
     try {
      List userInfoData = json.decode(await Storage.getString('userInfo'));
      userinfo = userInfoData;
    } catch (e) {
     return null;
    }
    return userinfo.first;      
  }
  static userLoginState() async{    
      var userInfo=await UserServices.userInfo();
      if(userInfo != null && userInfo["username"]!=""){
        return true;
      }
      return false;
  }
  static loginOut(){
    Storage.remove('userInfo');
  }
}