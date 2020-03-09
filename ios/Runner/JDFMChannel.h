//
//  JDFMChannel.h
//  Runner
//
//  Created by Charles on 2020/2/26.
//

#import <Foundation/Foundation.h>
#import "GeneratedPluginRegistrant.h"


@interface JDFMChannel : NSObject
+ (JDFMChannel *)messenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@property(nonatomic, strong)FlutterMethodChannel *batteryChannel;
@property(nonatomic, strong)FlutterMethodCall* methodCall;
@property(nonatomic, copy)FlutterResult result;

@end

