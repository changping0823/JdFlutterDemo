import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EnDecodeUtil {

  static String aesKey = 'xxxxxxx';


  /// md5 加密
  static String encodeMd5(String data) {
    //在这里面写
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /// Base64编码
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  //AES加密
  static Future<String> encodeAES(String data) async{
    return await FlutterAesEcbPkcs5.encryptString(data, aesKey);
  }

  //AES解密
  static Future<String> decodeAES(String data) async{
    return await FlutterAesEcbPkcs5.decryptString(data, aesKey);
  }

  //RSA加密
  static Future<String> encodeRSA(String text) async {
    String publicKeyString = 'jiami公钥';/// 加密公钥
    RSAPublicKey publicKey = RSAKeyParser().parse(publicKeyString);
    //创建加密器
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(text).base64;
  }
  //RSA解密
  static Future<String> decodeRSA(String text) async {
    String publicKeyString = 'jiami私钥';/// 加密公钥
    RSAPrivateKey privateKey = RSAKeyParser().parse(publicKeyString);
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt(Encrypted.fromBase64(text));
  }
}