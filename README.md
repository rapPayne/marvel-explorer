# marvel-explorer
A Flutter app to lookup Marvel Comics info by Rap Payne and Rafael Rincón.

# How to use
This is a lot easier than it sounds. Just give it a try. You'll do great.
1. Clone this repo.
2. [Get Marvel API developer keys (public and private).](#to-Get-a-Marvel-API-developer-key)
3. Put them in a new file, lib/sensitiveConstants.dart. Call your private key privateKey and your public key publicKey. Call your AdMob app ID adMobAppId.
4. Create a gradle.properties file in your home/user directory. Make sure it contains the line MarvelExplorerGoogleAdmobAppID="<app_id>" where app_id is your AdMob App ID.
5. Create SensitiveConstants.h in app/ios.

    The the only code it should have in it is the following: 
  
```
#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString *const AdMobAppID;
```
6. Create SensitiveConstants.m in app/ios.

    The the only code it should have in it is the following: 
  
```
#import "SensitiveConstants.h"

NSString *const AdMobAppID = @"<app_id>";
```
<app_id> should be yout AdMob App ID.

7. Compile and run


# To get a Marvel API developer key
1. Go to https://developer.marvel.com/ and hit the big "Get Started" button.
2. Click the "Create a Marvel Insider Account" or log in with your existing credentials
3. After you register, follow the prompts to get an API developer key

# To compile and run
1. cd app
2. flutter run
(Or you can run/debug it through your IDE)

