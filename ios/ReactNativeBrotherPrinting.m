#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(ReactNativeBrotherPrinting, NSObject)

RCT_EXTERN_METHOD(printImageViaWifi: (NSString *)printURI ipAddress:(NSString *)ip modelName:(NSString *)model cb:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(printImageViaBluetooth: (NSString *)printURI modelName:(NSString *)model cb:(RCTResponseSenderBlock)callback)

@end
