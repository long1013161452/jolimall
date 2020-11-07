//
//  AppDelegate.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "AppDelegate.h"

#import "XZZOrderPostageInfor.h"

#import <Crashlytics/Crashlytics.h>

#import <Fabric/Fabric.h>

#import "XZZVersionInfor.h"

#import "XZZGoodsListViewController.h"

#import "XZZSetUpInforModel.h"

#import "XZZCouponPopUpView.h"

#import "XZZLocalPushRecord.h"

#define my_iskol @"iskol"

@interface AppDelegate ()<UNUserNotificationCenterDelegate, FIRMessagingDelegate>

@property (strong, nonatomic) NSDictionary *refererAppLink;

@property(nonatomic,strong)dispatch_source_t timer;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZVersionInfor * versionInfor;

/**
 * 弹出优惠码信息
 */
@property (nonatomic, strong)UIView * couponInforView;

/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;
@end

/**
 *  存储时间信息
 */
#define storage_Time_Infor @"Storage time information"
/**
 *  间隔时间
 */
#define interval_between (24 * 60 * 60)
/***  发送时长 */
#define sending_Time 60

@implementation AppDelegate


- (void)setGoodsId:(NSString *)goodsId
{
    if (goodsId) {
        GoodsDetails(goodsId, self.currentViewController);
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
#ifdef DEBUG
    
    self.credentialProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1 identityPoolId:@"us-east-1:f9d352b1-0c7b-4e51-a569-b6270cb6917a"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:self.credentialProvider];
    
#else
    
    self.credentialProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1 identityPoolId:@"us-east-1:604e355a-de47-4bad-8a33-646dfc41d536"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:self.credentialProvider];
    
#endif
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    self.kinesisRecorder = [AWSKinesisRecorder defaultKinesisRecorder];

    
    //firebase
    [FIRApp configure];
    [Fabric with:@[[Crashlytics class]]];
     [FIRMessaging messaging].delegate = self;
    ///fb
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
//    [FBSDKSettings enableLoggingBehavior:FBSDKLoggingBehaviorAppEvents];
    
#ifdef DEBUG
    if (launchOptions[UIApplicationLaunchOptionsURLKey] == nil) {

        [FBSDKSettings setAppID:@"2135388343426658"];
        [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
            if (error) {
                NSLog(@"Received error while fetching deferred app link %@", error);
            }
            if (url) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }
#else

    if (launchOptions[UIApplicationLaunchOptionsURLKey] == nil) {

        [FBSDKSettings setAppID:@"382409439108877"];
        [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
            if (error) {
                NSLog(@"Received error while fetching deferred app link %@", error);
            }
            if (url) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }

#endif
    
    RPlatform* p = [RPlatform make:^(PlatformBuilder *builder) {
        [builder add:RShareSDKPinterest];
        [builder add:RShareSDKFacebook];
    }];
    
    [[RShareManager shared] registerPlatforms:p onConfiguration:^(RShareSDKPlatform platform, RRegister *obj) {
        switch (platform) {
            case RShareSDKPinterest:
                [obj connectPinterestByAppID:@"5029225042922225929" appSecret:nil];
                break;
            case RShareSDKFacebook:
#ifdef DEBUG
                [obj connectFacebookByID:@"2135388343426658" secret:nil];
#else
                [obj connectFacebookByID:@"382409439108877" secret:nil];
#endif
                break;
                
            default:
                break;
        }
    }];
    
    
    [ZDKZendesk initializeWithAppId: @"464963cd18d5b12eb4a4a3bb8bf0320d57c54113171333c7"
                           clientId: @"mobile_sdk_client_584342beaf7f95ca0a25"
                         zendeskUrl: @"https://supportjolimall.zendesk.com"];
    [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];
//    [[ZDCChatAPI instance] startChatWithAccountKey:@"7mystxxrnxaJHXsq0wMAQ2apchPXxW0S"];

    
    
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    
    if (@available(iOS 10.0, *)) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [application registerForRemoteNotifications];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    [XZZUserInfor readLocalUserInformation];
    
    [XZZEquipmentInfor shareEquipmentInfor];
    
    self.window.rootViewController = [[NSClassFromString(@"XZZTabBarViewController") alloc] init];
    
    self.openNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"openNumber"];
    self.openNumber++;
    [[NSUserDefaults standardUserDefaults] setInteger:self.openNumber forKey:@"openNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self getVersionInformation];
    
    {
#ifdef CE_SHI_TEST//开发环境
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"chooseEnvironment"];
    NSString * buttonTitle = @"";
    if (index == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self chooseEnvironment];
        });
    }else if (index == 1) {
        self.HTTPMAIN = @"http://api-portal.dev.xzzcorp.com/budgetmall/";
        self.HTTPMAINGOODSH5 = @"https://m.jolimall.com/goods/";
        self.HTTPMAINH5 = @"https://m.jolimall.com";
        buttonTitle = @"dev";
    }else if (index == 2){
        self.HTTPMAIN = @"https://api-portal.test.xzzcloud.com/budgetmall/";
        self.HTTPMAINGOODSH5 = @"https://m.jolimall.com/goods/";
        self.HTTPMAINH5 = @"http://m.jolimall.test.xzzcorp.com";
        buttonTitle = @"test";
    }else if (index == 3){
        self.HTTPMAIN = @"https://api-portal.pre-release.greatmola.com/budgetmall/";
        self.HTTPMAINGOODSH5 = @"https://jolimall.pre-release.greatmola.com/goods/";
        self.HTTPMAINH5 = @"https://jolimall.pre-release.greatmola.com";
        buttonTitle = @"预发";
    }else if (index == 4){
        self.HTTPMAIN = @"https://api-portal.greatmola.com/budgetmall/";
        self.HTTPMAINGOODSH5 = @"https://jolimall.com/goods/";
        self.HTTPMAINH5 = @"https://jolimall.com";
        buttonTitle = @"线上";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIButton * button = [UIButton allocInitWithTitle:buttonTitle color:kColor(0xFF0688) font:14];
        [button addTarget:self action:@selector(chooseEnvironment) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(0, 100, 100, 40);
        [button addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
        [self.window addSubview:button];
    });
#endif
    }
    
    
    PushRecord_getPushIds;
    
    self.iskol = [[NSUserDefaults standardUserDefaults] boolForKey:my_iskol];
    
    [self getUserAuthorization];
    [self RegularlySend];
    [self DownloadBasicInformation];
    [self downloadSetUpList];
    return YES;
}



#ifdef CE_SHI_TEST//开发环境
#pragma mark ---- 选择地址环境
/**选择地址环境*/
- (void)chooseEnvironment
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"选择环境" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addAction:[UIAlertAction actionWithTitle:@"dev" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"chooseEnvironment"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        exit(1);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"test" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"chooseEnvironment"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        exit(1);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"预发" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"chooseEnvironment"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        exit(1);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"线上" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"chooseEnvironment"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        exit(1);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

///平移手势的回调方法
- (void)panAction:(UIPanGestureRecognizer*)sender{
    //得到当前手势所在视图
    UIView *view = sender.view;
    //得到我们在视图上移动的偏移量
    CGPoint currentPoint = [sender translationInView:view.superview];
    //通过2D仿射变换函数中与位移有关的函数实现视图位置变化
    view.transform = CGAffineTransformTranslate(view.transform, currentPoint.x, currentPoint.y);
    //复原 // 每次都是从00点开始
    [sender setTranslation:CGPointZero inView:view.superview];
}
#endif



#pragma mark ----下载基础信息
/**
 *  下载基础信息
 */
- (void)DownloadBasicInformation
{
    [XZZDataDownload userGetBasedInformationHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (!successful) {
            [self DownloadBasicInformation];
        }else{
            [[NSUserDefaults standardUserDefaults] setBool:My_Basic_Infor.isKol forKey:my_iskol];
            self.iskol = My_Basic_Infor.isKol;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myiskol" object:nil];

//            [self determineWhetherShouldPromptMessage];
        }
    }];
    
}

- (void)downloadSetUpList
{
    [XZZDataDownload userGetSetUpListInforHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [XZZALLSetUpInfor shareAllSetUpInfor].setUpInforArray = data;
        }else{
            [self downloadSetUpList];
        }
    }];
}

#pragma mark ----定时发送
/***  定时发送 */
- (void)RegularlySend{
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(sending_Time * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        //定时器需要执行的操作
        
        [weakSelf.kinesisRecorder submitAllRecords];
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
    
}

- (NSString *)authorization
{
    if (!_authorization) {
        self.authorization = [[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"];
        if (_authorization.length <= 0) {
            self.authorization = @"Basic am9saW1hbGw6cG9ydGFs";
        }
    }
    return _authorization;
}

- (void)getUserAuthorization
{
    [XZZDataDownload logInGetAuthorizationHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            if ([data isKindOfClass:[NSString class]]) {
                self.authorization = data;
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"authorization"];
            }else{
                self.authorization = [[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"];
                if (self.authorization.length <= 0) {
                 [self getUserAuthorization];
                }
                
            }
        }else{
            self.authorization = [[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"];
            if (self.authorization.length <= 0) {
             [self getUserAuthorization];
            }
        }
    }];
}

#pragma mark ----获取所有的邮费信息
/**
 *  获取所有的邮费信息
 */
- (void)getPostageInforList
{
    WS(wSelf)
    [[XZZAllOrderPostageInfor shareAllOrderPostageInfor] getAllPostageInformation:^(id data, BOOL successful, NSError *error) {
        if (!successful) {
            [wSelf getPostageInforList];
        }
    }];
}

#pragma mark ----*  获取版本信息
/**
 *  获取版本信息
 */
- (void)getVersionInformation
{
    
    if (!self.versionInfor) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [XZZNetWork POST:user_version_get parameters:@{@"deviceType" : @2, @"version" : app_Version} success:^(id data) {
            
            XZZVersionInfor * versionInfor = [XZZVersionInfor yy_modelWithJSON:data[@"result"]];
            self.versionInfor = versionInfor;
            [self processVersionInformation:versionInfor];
        } failure:^(NSError *error) {
            
        }];
    }else{
        if (self.versionInfor.isForce == 1) {
            [self processVersionInformation:self.versionInfor];
        }
    }
    
    
}

#pragma mark ----*  提示版本更新
/**
 *  提示版本更新
 */
- (void)processVersionInformation:(XZZVersionInfor *)versionInfor
{
    if (versionInfor.version.length) {//存在数据
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        if ([self isItLatestVersion:versionInfor.version app_Version:app_Version]) {
            NSLog(@"%s %d 行", __func__, __LINE__);
            return;
        }
        
        NSString * updateContent = versionInfor.content.length ? versionInfor.content : @"";
        NSString * title = versionInfor.title.length ? versionInfor.title : @"Whether or not to update?";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:updateContent preferredStyle:UIAlertControllerStyleAlert];
        
        if (versionInfor.isForce != 1) {
            [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }]];
        }
        
        [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url          = [NSURL URLWithString:versionInfor.url];
//            url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1467717066?mt=8"];
            
            [[UIApplication sharedApplication] openURL:url];
        }]];
        
        if([XZZEquipmentInfor deviceIsPhone]){
            
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
            
        }else{
            
            UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
            popPresenter.sourceView = self.window; // 这就是挂靠的对象
            popPresenter.sourceRect = self.window.bounds;
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
        
    }
}

- (BOOL)isItLatestVersion:(NSString *)version app_Version:(NSString *)app_Version
{
    NSArray * versionArray = [version componentsSeparatedByString:@"."];
    NSArray * app_VersionArray = [app_Version componentsSeparatedByString:@"."];
    
    
    for (int i = 0; i < versionArray.count ; i++) {
        NSString * versionOne = versionArray[i];
        NSString * app_VersionOne = app_VersionArray[i];
        if (versionOne.intValue > app_VersionOne.intValue) {
            return NO;
        }else if (versionOne.intValue < app_VersionOne.intValue){
            return YES;
        }
    }
    
    return YES;
}


#pragma mark ----判断是否应该提示信息
/**
 *  判断是否应该提示信息
 */
- (void)determineWhetherShouldPromptMessage
{
    if (self.iskol) {
        return;
    }
    NSLog(@"%s %d 行", __func__, __LINE__);
    //弹窗时间
    NSInteger dateInterval = [[NSUserDefaults standardUserDefaults] integerForKey:storage_Time_Infor];
    NSInteger currentTime = [NSDate date].timeIntervalSince1970;
    
    if (currentTime - dateInterval >= interval_between) {
        
        if (User_Infor.isLogin) {
            WS(wSelf)
            [XZZDataDownload logInGetUserIsNewHttpBlock:^(id data, BOOL successful, NSError *error) {
                if (successful) {
                    [wSelf DelayPop_up];
                }
            }];
        }else{
            [self DelayPop_up];
        }
    }
}
#pragma mark ----*  延迟调用
/**
 *  延迟调用
 */
- (void)DelayPop_up
{
    NSInteger currentTime = [NSDate date].timeIntervalSince1970;
    [[NSUserDefaults standardUserDefaults] setInteger:currentTime forKey:storage_Time_Infor];
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf popUpDiscountCodeInformation];
    });
}



#pragma mark ----弹出优惠码信息
/**
 *  弹出优惠码信息
 */
- (void)popUpDiscountCodeInformation
{
    
    XZZCouponPopUpView * couponPopUpView = [XZZCouponPopUpView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.window addSubview:couponPopUpView];
    [couponPopUpView bringSubviewToFront:self.window];
    
    return;
    [self.couponInforView removeFromSuperview];
    
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backView.backgroundColor = kColorWithRGB(0, 0, 0, .5);
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCouponInformation)]];
    [self.window addSubview:backView];
    [backView bringSubviewToFront:self.window];
    self.couponInforView = backView;
    
    UIImageView * imageView = [UIImageView allocInit];
    imageView.image = imageName(@"window_coupon");
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnCoupons)]];
    [imageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(clickOnCoupons)]];
    [backView addSubview:imageView];
    WS(wSelf)
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf.couponInforView);
        if (ScreenWidth == 320) {
            make.width.equalTo(@280);
            make.height.equalTo(@295);
        }else{
            make.width.equalTo(@348);
            make.height.equalTo(@367);
        }
    }];
    
    UIImageView * shutDownImageView = [UIImageView allocInit];
    shutDownImageView.image = imageName(@"window_shut_Down");
    [backView addSubview:shutDownImageView];
    [shutDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView);
        make.bottom.equalTo(imageView.mas_top).offset(-20);
    }];
    
    
    
    
}
#pragma mark ----*  移除优惠码弹框
/**
 *  移除优惠码弹框
 */
- (void)removeCouponInformation
{
    [self.couponInforView removeFromSuperview];
}

#pragma mark ----*  复制优惠码
/**
 *  复制优惠码
 */
- (void)clickOnCoupons
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    
    pastboard.string = @"NEW10";
    
    
    SVProgressSuccess(@"Coupon code copied")
    
}




- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSString * urlStr = url.absoluteString;
    
    
    if ([urlStr hasPrefix:@"jolimallgoodsdetails"]) {
        NSArray * array = [urlStr componentsSeparatedByString:@"?"];
        array = [array.firstObject componentsSeparatedByString:@"/"];
        self.goodsId = [array lastObject];
        
        return YES;
    }
    
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    // Add any custom logic here.
    return handled;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    FBSDKURL * parsedUrl = [FBSDKURL URLWithInboundURL:url sourceApplication:sourceApplication];
    
    NSDictionary *appLinkData = [parsedUrl appLinkData];
    FBSDKAppLink * appLink = parsedUrl.appLinkReferer;
    if (appLinkData) {
        self.refererAppLink = appLinkData[@"referer_app_link"];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self getPostageInforList];
    [self getVersionInformation];
    [FBSDKAppEvents activateApp];
    
//    [[RShareManager shared] applicationDidBecomeActive:application];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
#ifdef DEBUG
    [FBSDKSettings setAppID:@"2135388343426658"];
    //    [FBSDKSettings setClientToken:@"5dc5dff5e8fcd16afe9646cbcabe9179"];
#else
    [FBSDKSettings setAppID:@"382409439108877"];
    //    [FBSDKSettings setClientToken:@"3b7964ed71a83c9e5dfb613174a028c4"];
#endif
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [FIRMessaging messaging].APNSToken = deviceToken;
}

/// This method will be called once a token is available, or has been refreshed. Typically it
/// will be called once per app start, but may be called more often, if token is invalidated or
/// updated. In this method, you should perform operations such as:
///
/// * Uploading the FCM token to your application server, so targeted notifications can be sent.
///
/// * Subscribing to any topics.
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken
{
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    
    [[FIRInstanceID instanceID] instanceIDWithHandler:^(FIRInstanceIDResult * _Nullable result,
                                                        NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching remote instance ID: %@", error);
        } else {
            NSLog(@"Remote instance ID token: %@", result.token);
            NSString* message =
            [NSString stringWithFormat:@"Remote InstanceID token: %@", result.token];
            //            self.instanceIDTokenMessage.text = message;
            
            NSLog(@"%@", message);
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"%@", userInfo);
    [self  noticeClickDealWithUserInfo:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@", userInfo);
    
    //    [self  noticeClickDealWithUserInfo:userInfo];
    
    
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
        completionHandler(UIBackgroundFetchResultNewData);
    }
    
    
    //    completionHandler(UIBackgroundFetchResultNewData);
}


// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // Print full message.
    NSLog(@"%@", userInfo);
//        [self  noticeClickDealWithUserInfo:userInfo];
    
    PushRecord_getPushIds;
    

    
    // Change this to your preferred presentation option
//        completionHandler(UNNotificationPresentationOptionNone);
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
    
    
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    NSLog(@"%@", userInfo);
    [self  noticeClickDealWithUserInfo:userInfo];
    
    completionHandler();
}
#pragma mark ---- 处理推送信息
/**
 *  处理推送信息
 */
// private method
- (void)noticeClickDealWithUserInfo:(NSDictionary *)userInfo{// 推送跳转处理
    NSLog(@"%s %d 行", __func__, __LINE__);
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSString * goods = userInfo[@"goods"];
    NSString * category = userInfo[@"category"];
    NSString * activity = userInfo[@"activity"];
    NSString * url = userInfo[@"url"];
    NSString * cardName = userInfo[@"aps"][@"alert"][@"title"];
    
    
    
    [XZZBuriedPoint pushBuriedPointTitle:cardName];
    
    UIViewController * vc = nil;
    
    if (goods.length) {
        self.goodsId = goods;
        return;
    }else if (category.length){//分类
        XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
        XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
        categoryGoods.categoryId = category;
        goodsListVC.myTitle = cardName;
        goodsListVC.categoryGoods = categoryGoods;
        vc = goodsListVC;
        
    }else if (activity.length){//活动
        
        XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
        goodsListVC.myTitle = cardName;
        goodsListVC.activityId = activity;
        [[self currentViewController] pushViewController:goodsListVC animated:YES];
        
        
        return;
        
    }else if (url.length){//url
        XZZWebViewController * webVC = [XZZWebViewController allocInit];
        webVC.urlStr = url;
        webVC.myTitle = cardName;
        vc = webVC;
    }else{
        return;
    }
    
    [[self currentViewController] pushViewController:vc animated:YES];
    
    
    
    
    
}






- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//通过控制器的布局视图可以获取到控制器实例对象    modal的展现方式需要取到控制器的根视图
- (UIViewController *)currentViewController
{
    
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

    UIViewController * vc = window.rootViewController;

    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}


@end
