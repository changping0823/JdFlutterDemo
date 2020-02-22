import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';



class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;


}


final parser = RSAKeyParser();

class DecodeUtil {
  
  //生成16字节的随机密钥
  // static Future<String> aesKey = FlutterAesEcbPkcs5.generateDesKey(128);
   static String aesKey = '346B786233326C317663353037757977';
  /// md5 加密
  static String encodeMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /// Base64编码
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    return base64Encode(content);
  }

  /// Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  //AES加密
  static Future<String> encodeAES(String data) async {
    return await FlutterAesEcbPkcs5.encryptString(data, aesKey);
  }
  static Future<String> encodeAESWithKey(String data,String key) async {
    return await FlutterAesEcbPkcs5.encryptString(data, key);
  }

  //AES解密
  static Future<String> decodeAES(String data) async {
    return await FlutterAesEcbPkcs5.decryptString(data, aesKey);
  }
  static Future<String> decodeAESWithKey(String data,String key) async {
    return await FlutterAesEcbPkcs5.decryptString(data, key);
  }

  //RSA加密
  static Future<String> encodeRSA(String data) async {
    // String publicKeyString = 'jiami公钥';/// 加密公钥
    String publicKeyString = await rootBundle.loadString('images/rsa_public_key.pem');
    RSAPublicKey publicKey = RSAKeyParser().parse(publicKeyString);
    //创建加密器
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(data).base64;
  }

  //RSA解密
  static Future<String> decodeRSA(String data) async {
    String privateKeyString = await rootBundle.loadString('images/rsa_private_key.pem');/// 加密公钥
    RSAPrivateKey privateKey = RSAKeyParser().parse(privateKeyString);
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt(Encrypted.fromBase64(data));
  }
}