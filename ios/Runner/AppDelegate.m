//
//  AppDelegate.m
//  Runner
//
//  Created by Charles on 2020/2/24.
//

#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    
        FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;
        FlutterMethodChannel *batteryChannel = [FlutterMethodChannel
                                                methodChannelWithName:@"samples.flutter.dev/battery"
                                                binaryMessenger:controller];
        
        __weak typeof(self) weakSelf = self;
        [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            if ([@"getBatteryLevel" isEqualToString:call.method]){
                int batteryLevel = [weakSelf getBatteryLevel];
                if (batteryLevel == -1) {
                    result([FlutterError errorWithCode:@"UNAVAILABLE" message:@"Battery info unavailable" details:nil]);
                } else {
                    result(@(batteryLevel));
                }
                
            } else if ([@"getFromOCClientMessage" isEqualToString:call.method])  {
                NSString *testMethod = [weakSelf getFromOCClientMessage];
                result(testMethod);
                    
            } else {
                result(FlutterMethodNotImplemented);
            }
        }];

    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (int)getBatteryLevel {
    
    UIDevice* device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return -1;
    } else {
        return (int)(device.batteryLevel * 100);
    }
}

- (NSString *)getFromOCClientMessage {
    return @"我来自OC client!!!";
}

@end
