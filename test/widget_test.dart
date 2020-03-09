
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/Calculator.dart';
import '../lib/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  test('adds one to input values', () async{
    // final calculator = Calculator();
    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
  // calculator

// flutter: encodeAES ---- > 95DFA83EA0955A691CBB6F952EBA2B08
// flutter: decodeAES ---- > liyouxiu
// flutter: encodeRSA ---- > NLCI0UmB/NjgEnlH/yX7b6s1+w4scScCqwB+p5rIIiGIMI8hTQM4q7dkpuWUw8THprFj1Donj1dNXDNFAdUmhh48SFnjjcLSrkosq28kAgazvWQEYDkSHCHbdJiouPhidQld0aDHHmp8ZXD5wISKlPgFusUU3erAf5veRVLG0kI=
// flutter: decodeRSA ---- > liyouxiu
    String encodeRSAText = await DecodeUtil.encodeRSA('liyouxiu');
    print('encodeRSA ---- > $encodeRSAText');
    String decodeRSA = await DecodeUtil.decodeRSA(encodeRSAText);
    print('decodeRSA ---- > $decodeRSA');

//        String encodeAES = await DecodeUtil.encodeAES('liyouxiu');
//    print('encodeAES ---- > $encodeAES');
//
//    String decodeAES =await DecodeUtil.decodeAES('$encodeAES');
//    print('decodeAES ---- > $decodeAES');



    // expect(await DecodeUtil().decodeRSA('NLCI0UmB/NjgEnlH/yX7b6s1+w4scScCqwB+p5rIIiGIMI8hTQM4q7dkpuWUw8THprFj1Donj1dNXDNFAdUmhh48SFnjjcLSrkosq28kAgazvWQEYDkSHCHbdJiouPhidQld0aDHHmp8ZXD5wISKlPgFusUU3erAf5veRVLG0kI='),'liyouxiu');
    // print(response.request.headers['token']);


  });
}
