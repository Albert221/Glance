#import "AdmobNativeAdPlugin.h"
#import <admob_native_ad/admob_native_ad-Swift.h>

@implementation AdmobNativeAdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdmobNativeAdPlugin registerWithRegistrar:registrar];
}
@end
