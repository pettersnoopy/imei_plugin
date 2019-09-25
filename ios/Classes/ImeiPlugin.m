#import "ImeiPlugin.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation ImeiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"imei_plugin"
            binaryMessenger:[registrar messenger]];
  ImeiPlugin* instance = [[ImeiPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getImei" isEqualToString:call.method]) {
    [self getIdfa:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(void)getIdfa:(FlutterMethodCall*)call result:(FlutterResult)result {
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSUUID *identifier = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        result([identifier UUIDString]);
        return;
    }
    
    NSUUID *identifierForVendor = [[UIDevice currentDevice] identifierForVendor];
    result([identifierForVendor UUIDString]);
}
@end
