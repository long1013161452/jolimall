//
//  AppDelegate.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UserNotifications/UserNotifications.h>

#define my_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>


#ifdef CE_SHI_TEST

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * HTTPMAIN;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * HTTPMAINH5;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * HTTPMAINGOODSH5;

#endif




@property (strong, nonatomic) UIWindow *window;

/**
 * 记录打开次数
 */
@property (nonatomic, assign)NSInteger openNumber;

/**
 * 当前时间信息
 */
@property (nonatomic, strong)NSString * currentTime;

/**
 * 数据仓库
 */
@property (nonatomic, strong)AWSKinesisRecorder * kinesisRecorder;

/**
 * 数据仓库
 */
@property (nonatomic, strong)AWSCognitoCredentialsProvider * credentialProvider;




/**
 * 获取基本授权
 */
@property (nonatomic, strong)NSString * authorization;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL iskol;


@end








