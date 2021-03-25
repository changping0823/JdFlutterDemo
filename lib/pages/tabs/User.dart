import 'package:flutter/material.dart';
import '../../widget/JdButton.dart';
import '../../services/EventBus.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/UserServices.dart';


class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLogin = false;
  Map userInfo;


  @override
  void initState() { 
    super.initState();
    _getUserInfo();
    eventBus.on<UserEvent>().listen((event){
     _getUserInfo();
    });
  }

  _getUserInfo() async{
    var isLogin = await UserServices.userLoginState();
    var userInfo = await UserServices.userInfo();
    setState(() {
      this.isLogin = isLogin;
      this.userInfo = userInfo;
    });

  }
  @override
  Widget build(BuildContext context) {
    // ScreenAdapter.init(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(220),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/user_bg.jpg'),fit: BoxFit.cover),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset('images/user.png',fit: BoxFit.cover,width: ScreenAdapter.width(100),height: ScreenAdapter.width(100)),
                  ),
                ),
                this.isLogin?Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('用户名：${this.userInfo['username']}',style: TextStyle(fontSize: ScreenAdapter.size(32),color: Colors.white)),
                      Text('普通会员',style: TextStyle(fontSize: ScreenAdapter.size(24), color: Colors.white)),
                    ],
                  )
                ):
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('登录/注册',style: TextStyle(color: Colors.white)),
                  )
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment,color: Colors.red),
            title: Text('全部订单'),
            onTap: (){
              Navigator.pushNamed(context, '/order');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.green),
            title: Text('待付款'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash,color: Colors.orange),
            title: Text('待收货'),
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, 0.9)
          ),
          ListTile(
            leading: Icon(Icons.favorite,color: Colors.lightGreen),
            title: Text('我的收藏'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people,color: Colors.black54),
            title: Text('在线客服'),
          ),
          Divider(),
          this.isLogin?Container(
            padding: EdgeInsets.all(20),
            child: JdButton(text: '退出登录',color: Colors.red,action: (){
              UserServices.loginOut();
              this._getUserInfo();
            })

          ):Text('')
        ],
      ),
    );
  }
}