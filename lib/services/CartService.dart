import 'dart:convert';
import '../Config/Config.dart';
import 'Storage.dart';

class CartService {
  static addProduct(item) async {
    item = formatProduct(item);
    print('----->$item');

    try {
      List cartList = json.decode(await Storage.getString('cartList'));
      bool hasData = cartList.any((value) {
        if (value['_id'] == item['_id'] &&
            value['selectedAttr'] == item['selectedAttr']) {
          return true;
        }
        return false;
      });

      if (hasData) {
        for (var i = 0; i < cartList.length; i++) {
          if (cartList[i]['_id'] == item['_id'] &&
              cartList[i]['selectedAttr'] == item['selectedAttr']) {
            cartList[i]['count'] += 1;
          }
          await Storage.setString('cartList', json.encode(cartList));
        }
      } else {
        cartList.add(item);
        await Storage.setString('cartList', json.encode(cartList));
      }
    } catch (e) {
      List tempList = [];
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  static formatProduct(item) {
    String pic = item.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    if (item.price is int || item.price is double || item.price is num) {
      data['price'] = item.price;
    } else {
      data['price'] = double.parse(item.price);
    }
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = pic;

    /// 是否选中
    data['checked'] = true;
    return data;
  }
}
