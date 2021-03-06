//
//  RPinterestManager.m
//  sharekit
//
//  Created by valenti on 2018/7/25.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RPinterestManager.h"
#import <PinterestSDK/PinterestSDK.h>
#import <PinterestSDK/PDKPin.h>
#import "RRegister.h"

@implementation RPinterestManager

static RPinterestManager* _instance = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
        
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

/***  判断是否安装 */
- (BOOL)whetherInstall
{
    return [RPlatform isInstalled:RShareSDKPinterest];
}


- (void)connect:(RConfiguration)c {
    c(RShareSDKPinterest, [RRegister shared]);
}

- (void)sdkInitializeByAppID:(NSString *)appID appSecret:(NSString *)secret {
    [PDKClient configureSharedInstanceWithAppId:appID];
}

#pragma mark - 分享逻辑 -

- (void)shareImageWithURL:(NSString *)imageURL
               webpageURL:(NSString *)webpageURL
                  onBoard:(NSString *)boardName
              description:(NSString *)description
                     from:(UIViewController*)from
               completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKPinterest]) {
        NSLog(@"Pinterest 未安装");
        return;
    }
    
//    [[PDKClient sharedInstance] createPinWithImageURL:[NSURL URLWithString:imageURL]  link:[NSURL URLWithString:webpageURL] onBoard:@"1234" description:description withSuccess:^(PDKResponseObject *responseObject) {
//        if (share) {
//            share(RShareSDKPinterest, RShareResultSuccess, nil);
//        }
//    } andFailure:^(NSError *error) {
//        if (share) {
//            if ((long)error.code == 1) {
//                share(RShareSDKPinterest, RShareResultCancel, nil);
//            } else {
//                share(RShareSDKPinterest, RShareResultFailure, error.localizedDescription);
//            }
//        }
//    }];
//
//    return;
    
    
    
    [PDKPin pinWithImageURL:[NSURL URLWithString:imageURL] link:[NSURL URLWithString:webpageURL] suggestedBoardName:boardName note:description withSuccess:^{
        if (share) {
            share(RShareSDKPinterest, RShareResultSuccess, nil);
        }
    } andFailure:^(NSError *error) {
        if (share) {
            if ((long)error.code == 1) {
                share(RShareSDKPinterest, RShareResultCancel, nil);
            } else {
                share(RShareSDKPinterest, RShareResultFailure, error.localizedDescription);
            }
        }
    }];
    
}

#pragma mark - 应用回转 -
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[PDKClient sharedInstance] handleCallbackURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[PDKClient sharedInstance] handleCallbackURL:url];
}

@end
