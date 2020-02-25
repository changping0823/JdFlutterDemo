import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelService {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  static getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
      print('11111------>$batteryLevel');
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      print('22222------>$batteryLevel');
    }
    return batteryLevel;
  }
    
    /// 跳转原生
    static pushNative() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
      print('11111------>$batteryLevel');
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      print('22222------>$batteryLevel');
    }
    return batteryLevel;
  }
}
