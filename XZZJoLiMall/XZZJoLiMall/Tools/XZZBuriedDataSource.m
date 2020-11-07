//
//  XZZBuriedDataSource.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZBuriedDataSource.h"

@implementation XZZBuriedDataSource

+ (instancetype)allocInit
{
    XZZBuriedDataSource * dataSource = [super allocInit];
     NSLog(@"!!!!!!!!!   %@", NSStringFromClass([dataSource presentingVC].class));
    return dataSource;
}








//获取到当前所在的视图
- (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

@end
