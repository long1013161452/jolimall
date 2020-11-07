//
//  RFBMessenger.m
//  MaiDianCeShi
//
//  Created by 龙少 on 2018/10/31.
//  Copyright © 2018年 龙少. All rights reserved.
//

#import "RFBMessenger.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface RFBMessenger()<FBSDKSharingDelegate>

@property (nonatomic, copy) RShareCompletion shareCompletion;
@property (nonatomic, strong) FBSDKShareDialog* dialog;
@end

@implementation RFBMessenger

static RFBMessenger* _instance = nil;

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

- (void)connect:(RConfiguration)c {
    c(RShareSDKFBMessenger, [RRegister shared]);
}

/***  判断是否安装 */
- (BOOL)whetherInstall
{
    return [RPlatform isInstalled:RShareSDKFBMessenger];
}
/**
 *  分享  share
 *  tiele ： Chellysun Fashion Circle Fan-Shaped Silk Cotton Pendant Tassel Earrings
 *  url ：  https://m.chellysun.com/productDetails.html?id=1314
 *  elementTitle ：  Chellysun Fashion Circle Fan-Shaped Silk Cotton Pendant Tassel Earrings
 *  subtitle ： Chellysun Fashion Circle Fan-Shaped Silk Cotton Pendant Tassel Earrings
 *  imageUrl ：  http://s3.chellysun.com/shop/e19f7234-1a5e-4f16-8390-7e051334cd01_jpg
 */
- (void)shareTitle:(NSString *)title url:(NSString *)url elementTitle:(NSString *)elementTitle subtitle:(NSString *)subtitle imageUrl:(NSString *)imageUrl completion:(RShareCompletion)share
{
    
    if (![RPlatform isInstalled:RShareSDKFBMessenger]) {
        NSLog(@"Messenger 未安装");
        return;
    }
    _shareCompletion = share;
    
//    imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
//
//    imageUrl = @"http://ronneo.com/test/e19f7234-1a5e-4f16-8390-7e051334cd01.jpg";

    FBSDKShareMessengerURLActionButton *urlButton = [[FBSDKShareMessengerURLActionButton alloc] init];
    urlButton.title = title;
    urlButton.url = [NSURL URLWithString:url];
    
    FBSDKShareMessengerGenericTemplateElement *element = [[FBSDKShareMessengerGenericTemplateElement alloc] init];
    element.title = elementTitle;
    element.subtitle = subtitle;
    element.imageURL = [NSURL URLWithString:imageUrl];
    element.button = urlButton;
    
    FBSDKShareMessengerGenericTemplateContent *content = [[FBSDKShareMessengerGenericTemplateContent alloc] init];
#ifdef DEBUG
    content.pageID = @"2135388343426658";// Your page ID, required for attribution
#else
    content.pageID = @"382409439108877";// Your page ID, required for attribution
#endif
    content.element = element;
    

    FBSDKShareLinkContent * contentTwo = [[FBSDKShareLinkContent alloc] init];
    contentTwo.contentURL = [NSURL URLWithString: url];

    
    
    FBSDKMessageDialog *messageDialog = [FBSDKMessageDialog showWithContent:contentTwo delegate:self];
    
    if ([messageDialog canShow]) {
        [messageDialog show];
    }else{
        if (_shareCompletion) {
            _shareCompletion(RShareSDKFBMessenger, RShareResultFailure, @"Facebook 分享失败");
        }
    }
}



#pragma mark - 应用跳转 -

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    
    return handled;
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                          options:options];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
}

#pragma mark - 其他配置 -

- (void)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}
#pragma mark - FBSDKShareingDelegate -

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    if (_shareCompletion) {
        _shareCompletion(RShareSDKFBMessenger, RShareResultCancel, nil);
    }
    
}
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    if (_shareCompletion) {
        _shareCompletion(RShareSDKFBMessenger, RShareResultFailure, error.localizedDescription);
    }
}
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    if (_shareCompletion) {
        _shareCompletion(RShareSDKFBMessenger, RShareResultSuccess, nil);
    }
    
}


@end
