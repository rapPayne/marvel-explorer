#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "SensitiveConstants.h"
@import GoogleMobileAds;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [GADMobileAds configureWithApplicationID: AdMobAppID];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
