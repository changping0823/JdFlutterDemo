//
//  JDFMChannel.m
//  Runner
//
//  Created by Charles on 2020/2/26.
//

#import "JDFMChannel.h"


@interface JDFMChannel ()
@property(nonatomic, strong)NSObject<FlutterBinaryMessenger>* messenger;
@end

@implementation JDFMChannel



static JDFMChannel *_instance;

+ (JDFMChannel *)messenger:(NSObject<FlutterBinaryMessenger>*)messenger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        _instance.messenger = messenger;
        _instance.batteryChannel = [FlutterMethodChannel methodChannelWithName:@"samples.flutter.dev/battery" binaryMessenger:_instance.messenger];
        [_instance.batteryChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            _instance.methodCall = call;
            _instance.result = result;
        }];
    });
    return _instance;
}



@end
