
import '../services/EnDecodeUtil.dart';

class SignServices{
  static getSign(Map json){
    List jsonKeys = json.keys.toList();
    jsonKeys.sort();
    String sign = '';
    for (var i = 0; i < jsonKeys.length; i++) {
      sign += '${jsonKeys[i]}${json[jsonKeys[i]]}';
    }
    return EnDecodeUtil.encodeMd5(sign);
  }
}