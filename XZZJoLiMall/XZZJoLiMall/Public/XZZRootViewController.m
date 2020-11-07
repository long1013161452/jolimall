//
//  XZZRootViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRootViewController.h"

#import "XZZGIFActivitiesViewController.h"
#import "XZZChatViewController.h"

@interface XZZRootViewController ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * animatedImageView;

@end

@implementation XZZRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BACK_COLOR;
}

- (void)setMyTitle:(NSString *)myTitle
{
    _myTitle = myTitle;
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        wSelf.navigationItem.title = myTitle;
    });    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    [self setNavigationUI];
    
}

#pragma mark ----   设置导航栏
- (void)setNavigationUI{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:kColor(0x010101)}];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.nameVC.length) {
        self.nameVC = NSStringFromClass(self.class);
    }
    if (my_AppDelegate.iskol) {
        self.animatedImageView.hidden = NO;;
    }else{
        self.animatedImageView.hidden = YES;
    }
    [XZZBuriedPoint page:self.nameVC className:NSStringFromClass(self.class)];
}

#pragma mark ----/***  添加活动图标   GIF */
/***  添加活动图标   GIF */
- (void)addChatAndActivityFloatWindow
{
    WS(wSelf)
    return;
    if (!self.chatImageView) {
        UIImageView * imageView = [UIImageView allocInit];
        self.chatImageView = imageView;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToChatPage)]];
        imageView.image = imageName(@"home_char_float_window");
        [self.view addSubview:imageView];
        [imageView startAnimating];
        CGFloat bottom = 0;
        if (self.navigationController.viewControllers.count > 2 && [self isKindOfClass:NSClassFromString(@"XZZGoodsDetailsViewController")]) {
            UIViewController * vc = self.navigationController.viewControllers[1];
            if (![vc isKindOfClass:NSClassFromString(@"XZZGoodsDetailsViewController")]) {
                bottom += 49;
            }
        }
        if (self.navigationController.viewControllers.count > 1 && StatusRect.size.height > 20) {
            
            bottom += bottomHeight;
        }

        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.view).offset(-14);
            make.bottom.equalTo(wSelf.view).offset(-bottom);
            make.width.height.equalTo(@60);
        }];
    }

    
    if (!self.animatedImageView) {
        static NSData * data = nil;
        if (!data) {
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"activity_gift" ofType:@"gif"];
            data = [NSData dataWithContentsOfFile:imagePath];
        }
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToGIFActivitiesPage)]];
        //        imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
        imageView.image = imageName(@"home_float_window_activity_gift");
        [self.view addSubview:imageView];
        self.animatedImageView = imageView;
        [imageView startAnimating];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.chatImageView);
            make.bottom.equalTo(wSelf.chatImageView.mas_top).offset(-10);
            make.width.height.equalTo(@60);
        }];
    }
    
    
    if (my_AppDelegate.iskol) {
        self.animatedImageView.hidden = NO;;
    }else{
        self.animatedImageView.hidden = YES;
    }
}

- (void)goToChatPage
{
    return;
    NSString * email = @"";
    if (User_Infor.isLogin) {
        email = User_Infor.email;
    }
    ZDCVisitorInfo * infor = [[ZDCVisitorInfo alloc] init];
    infor.email = email;
    infor.name = email;
    [ZDCChatAPI instance].visitorInfo = infor;
    
    XZZChatViewController * chatVC = [XZZChatViewController allocInit];
    chatVC.email = email;
    [self pushViewController:chatVC animated:YES];
}







#pragma mark ----/***  进入GIF活动页面 */
/***  进入GIF活动页面 */
- (void)goToGIFActivitiesPage
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    XZZGIFActivitiesViewController * gifActivitiesVC = [XZZGIFActivitiesViewController allocInit];
    [self pushViewController:gifActivitiesVC animated:YES];
    
    
}


@end
