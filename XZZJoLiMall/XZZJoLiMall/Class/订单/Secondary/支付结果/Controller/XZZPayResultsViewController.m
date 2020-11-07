//
//  XZZPayResultsViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZPayResultsViewController.h"

#import "XZZOrderListViewController.h"
#import "XZZCheckOutViewController.h"
#import "XZZOrderDetailsViewController.h"

#import "XZZSingleSharedView.h"
#import "XZZCheckOutOrderGoodsView.h"
#import "XZZOrderGoodsView.h"

@interface XZZPayResultsViewController ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderDetail * orderDetail;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

@end

@implementation XZZPayResultsViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.fd_interactivePopDisabled = YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)back
{
    NSArray * VCs = self.navigationController.viewControllers;
    
    for (NSInteger i = VCs.count - 1; i >= 0; i--){
        
        UIViewController * vc = VCs[i];
        
        if ([vc isKindOfClass:[XZZCheckOutViewController class]]) {
            if (i > 0) {
                vc = VCs[i - 1];
                [self popToViewController:vc animated:YES];
                return;
            }
            [self popToRootViewControllerAnimated:YES];
            return;
        }
        
        if ([vc isKindOfClass:[XZZOrderListViewController class]]) {
            [self popToViewController:vc animated:YES];
            return;
        }
    }
    [self popToRootViewControllerAnimated:YES];
}


- (void)setOrderId:(NSString *)orderId
{
    _orderId = orderId;
    if (orderId.length) {
        WS(wSelf)
        [XZZDataDownload orderGetOrderDetailsOrderId:orderId httpBlock:^(id data, BOOL successful, NSError *error) {
            if (successful) {
                wSelf.orderDetail = data;
            }
        }];
    }
}

- (void)setOrderDetail:(XZZOrderDetail *)orderDetail
{
    _orderDetail = orderDetail;
    if (self.payResults) {
        [XZZBuriedPoint pay:orderDetail payType:self.payType isFB:NO];
    }
    
    if (self.scrollView) {
        WS(wSelf)
        UIView * labelBackView = [UIView allocInit];
        labelBackView.backgroundColor = BACK_COLOR;
        [self.scrollView addSubview:labelBackView];
        [labelBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.top.equalTo(@0);
            make.height.equalTo(@84);
        }];
        
        weakView(weak_labelBackView, labelBackView);

        UIImageView * imageView = [UIImageView allocInit];
        imageView.image = imageName(@"order_pay_success");
        [labelBackView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@45);
            make.centerY.equalTo(weak_labelBackView);
            make.height.width.equalTo(@40);
        }];
        
        weakView(weak_imageView, imageView)
        UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
        label.text = @"Payment successfully completed!We'll ship your package soon.";
        label.numberOfLines = 2;
        [labelBackView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weak_labelBackView);
            make.left.equalTo(weak_imageView.mas_right).offset(20);
            make.right.equalTo(weak_labelBackView).offset(-45);
        }];
        UIView * topView = labelBackView;
        
        BOOL orderComplete = self.orderDetail.status == 4;
        for (XZZOrderSku * orderSku in orderDetail.skus) {
            weakView(weak_topView, topView)
            XZZOrderGoodsView * goodsView = [XZZOrderGoodsView allocInit];
            goodsView.orderSku = orderSku;
            goodsView.hideCommentButton = !orderComplete;
            [self.scrollView addSubview:goodsView];
            [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(wSelf.view);
                if (weak_topView) {
                    make.top.equalTo(weak_topView.mas_bottom);
                }else{
                    make.top.equalTo(@0);
                }
            }];
            topView = goodsView;
        }
        self.scrollView.contentSize = CGSizeMake(0, 152 * orderDetail.skus.count + 90);
    }    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myTitle = @"Check Out";
    
    if (self.payResults) {
        self.nameVC = @"支付结果-成功";
        self.myTitle = @"Thank You!";
    }else{
        self.nameVC = @"支付结果-失败";
    }
    if (my_AppDelegate.iskol && self.payResults) {
        
        [self addisKolViewNew];
        
        
    }else{
        [self addView];
    }
    
}

- (void)addView
{
    WS(wSelf)
    

    
    
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"order_pay_success"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(@60);
    }];
    
    weakView(weak_imageView, imageView)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:16 textAlignment:(NSTextAlignmentCenter) tag:1];
    titleLabel.font = textFont_bold(16);
    if (self.payResults) {
        titleLabel.text = @"Payment Failed";
    }else{
        titleLabel.text = @"Payment Complete";
    }
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_imageView.mas_bottom).offset(15);
        make.left.equalTo(@20);
        make.centerX.equalTo(weak_imageView);
    }];
    
    weakView(weak_titleLabel, titleLabel)
    UILabel * contentLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x9b9b9b) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_titleLabel.mas_bottom).offset(20);
        make.left.right.equalTo(weak_titleLabel);
    }];
    
    weakView(weak_contentLabel, contentLabel)
    if (self.payResults) {//支付h成功
        NSString * customerServiceEmail = [NSString stringWithFormat:@"%@\ncheck the order", My_Basic_Infor.customerServiceEmail];
            titleLabel.text = @"PAYMENT COMPLETE";
            NSString * str = [NSString stringWithFormat:@"Thank you for shopping with us.If you have any question,please do not hesitate to contact our customer service below.\n%@", customerServiceEmail];
        contentLabel.attributedText = [self text:str font:14 color:kColor(0x9b9b9b) discolorationText:customerServiceEmail discolorationFont:14 discolorationColor:kColor(0x000000)];
            
            
            UIButton * shoppingButton = [UIButton allocInitWithTitle:@"CONTINUE SHOPPING" color:kColor(0xffffff) selectedTitle:@"CONTINUE SHOPPING" selectedColor:kColor(0xffffff) font:18];
            shoppingButton.titleLabel.font = textFont_bold(18);
            shoppingButton.layer.cornerRadius = 5;
            shoppingButton.layer.masksToBounds = YES;
        shoppingButton.backgroundColor = button_back_color;
//            shoppingButton.layer.borderColor = [UIColor blackColor].CGColor;
//            shoppingButton.layer.borderWidth = 1;
            [shoppingButton addTarget:self action:@selector(clickOnReturnHomePageButton) forControlEvents:(UIControlEventTouchUpInside)];
            [self.view addSubview:shoppingButton];
            [shoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@35);
                make.height.equalTo(@45);
                make.centerX.equalTo(wSelf.view);
                make.top.equalTo(weak_contentLabel.mas_bottom).offset(30);
            }];
    }else{//支付失败
        imageView.image = imageName(@"order_pay_failure");
        titleLabel.text = @"PAYMENT FAILED";
        contentLabel.text = @"We were unable to process your payment.\nPlease try again.";
        
        UIButton * tryAgainButton = [UIButton allocInitWithTitle:@"TRY AGAIN" color:kColor(0xffffff) selectedTitle:@"TRY AGAIN" selectedColor:kColor(0xffffff) font:18];
        tryAgainButton.backgroundColor = button_back_color;
        tryAgainButton.titleLabel.font = textFont_bold(18);
        tryAgainButton.layer.cornerRadius = 5;
        tryAgainButton.layer.masksToBounds = YES;
        [tryAgainButton addTarget:self action:@selector(clickOnTryAgainButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:tryAgainButton];
        [tryAgainButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@35);
            make.height.equalTo(@45);
            make.centerX.equalTo(wSelf.view);
            make.top.equalTo(weak_contentLabel.mas_bottom).offset(30);
        }];
    }
}

- (void)addisKolViewNew
{
    WS(wSelf)

    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(@0);
    }];
    UIView * shareBackView = [UIView allocInit];
    shareBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shareBackView];
    [shareBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.scrollView.mas_bottom);
    }];
    
    
    weakView(weak_shareBackView, shareBackView)
    UIView * dividerView3 = [UIView allocInit];
    dividerView3.backgroundColor = DIVIDER_COLOR;
    [shareBackView addSubview:dividerView3];
    [dividerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weak_shareBackView);
        make.height.equalTo(@.5);
    }];
    
    
    UILabel * introductionLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x333333) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    introductionLabel.numberOfLines = 0;
//    introductionLabel.text = @"Thanks for shopping with Jolimall,refer us to friends and earn COMMISSION: share these awesome items to inspire more!";
    introductionLabel.attributedText = [self text:@"Thanks for shopping with Jolimall,refer us to friends and earn COMMISSION: Join Now share these awesome items to inspire more!" font:14 color:kColor(0x333333) underlineText:@"Join Now " underlineFont:14 underlineColor:button_back_color];
    introductionLabel.userInteractionEnabled = YES;
    [introductionLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnJoinNow)]];
    
    
    [shareBackView addSubview:introductionLabel];
    [introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@30);
        make.centerX.equalTo(weak_shareBackView);
    }];
    weakView(weak_introductionLabel, introductionLabel)
    
    
    
    UIButton * shoppingButton = [UIButton allocInitWithTitle:@"CONTINUE SHOPPING" color:kColor(0xffffff) selectedTitle:@"CONTINUE SHOPPING" selectedColor:kColor(0xffffff) font:18];
    shoppingButton.titleLabel.font = textFont_bold(18);
    shoppingButton.layer.cornerRadius = 23;
    shoppingButton.layer.masksToBounds = YES;
    shoppingButton.backgroundColor = button_back_color;
    //            shoppingButton.layer.borderColor = [UIColor blackColor].CGColor;
    //            shoppingButton.layer.borderWidth = 1;
    [shoppingButton addTarget:self action:@selector(clickOnReturnHomePageButton) forControlEvents:(UIControlEventTouchUpInside)];
    [shareBackView addSubview:shoppingButton];
    [shoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.height.equalTo(@46);
        make.centerX.equalTo(wSelf.view);
        make.bottom.equalTo(weak_shareBackView.mas_bottom).offset(-44);
    }];
    
    
    if ([RFBMessenger shared].whetherInstall && [RWhatsAppManager shared].whetherInstall && [RPinterestManager shared].whetherInstall) {
        UIScrollView * scrollView = [UIScrollView allocInit];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [shareBackView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.top.equalTo(weak_introductionLabel.mas_bottom).offset(10);
            make.bottom.equalTo(shoppingButton.mas_top).offset(-20);
            make.height.equalTo(@100);
        }];
        
        CGFloat width = ScreenWidth / 4.5;
        if (ScreenWidth <= 320) {
            width = ScreenWidth / 3.5;
        }else if (ScreenWidth <= 375){
            width = ScreenWidth / 4.0;
        }
        
        XZZSingleSharedView * FBShareView = [self shareTitle:@"FaceBook" imageName:@"goods_details_FB" tag:1];
        [FBShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        [scrollView addSubview:FBShareView];
        [FBShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weak_introductionLabel.mas_bottom).offset(10);
            make.bottom.equalTo(shoppingButton.mas_top).offset(-20);
            make.width.equalTo(@(width));
            make.height.equalTo(@100);
        }];
        
        UIView * leftView = FBShareView;
        
            XZZSingleSharedView * FBMShareView = [self shareTitle:@"Message" imageName:@"goods_details_Messenger" tag:2];
            [FBMShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
            [scrollView addSubview:FBMShareView];
            [FBMShareView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftView.mas_right);
                make.top.bottom.width.equalTo(leftView);
            }];
            leftView = FBMShareView;
        
        
        
            XZZSingleSharedView * WHAPPShareView = [self shareTitle:@"WhatsApp" imageName:@"goods_details_whatsapp" tag:3];
            [WHAPPShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
            [scrollView addSubview:WHAPPShareView];
            [WHAPPShareView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftView.mas_right);
                make.top.bottom.width.equalTo(leftView);
                
            }];
            leftView = WHAPPShareView;
        
        
            XZZSingleSharedView * PShareView = [self shareTitle:@"Pinterest" imageName:@"goods_details_pinterest" tag:4];
            [PShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
            [scrollView addSubview:PShareView];
            [PShareView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftView.mas_right);
                make.top.bottom.width.equalTo(leftView);
            }];
            leftView = PShareView;
        
        
            XZZSingleSharedView * copyShareView = [self shareTitle:@"Copy link" imageName:@"goods_details_copylink" tag:5];
            [copyShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
            [scrollView addSubview:copyShareView];
            [copyShareView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftView.mas_right);
                make.top.bottom.width.equalTo(leftView);
            }];
            leftView = copyShareView;
        
        scrollView.contentSize = CGSizeMake(width * 5, 0);
        
        return;
    }
    
    
    
    
    XZZSingleSharedView * FBShareView = [XZZSingleSharedView allocInit];
    FBShareView.imageView.image = imageName(@"goods_details_FB");
    FBShareView.nameLabel.text = @"FaceBook";
    [FBShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
    FBShareView.tag = 1;
    [shareBackView addSubview:FBShareView];
    [FBShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(weak_introductionLabel.mas_bottom).offset(10);
        make.bottom.equalTo(shoppingButton.mas_top).offset(-20);
        make.height.equalTo(@100);
    }];
    
    UIView * leftView = FBShareView;
    
    if ([RFBMessenger shared].whetherInstall) {
        XZZSingleSharedView * FBMShareView = [XZZSingleSharedView allocInit];
        FBMShareView.imageView.image = imageName(@"goods_details_Messenger");
        FBMShareView.nameLabel.text = @"Message";
        [FBMShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        FBMShareView.tag = 2;
        [shareBackView addSubview:FBMShareView];
        [FBMShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = FBMShareView;
    }
    
    
    if ([RWhatsAppManager shared].whetherInstall) {
        XZZSingleSharedView * WHAPPShareView = [XZZSingleSharedView allocInit];
        WHAPPShareView.imageView.image = imageName(@"goods_details_whatsapp");
        WHAPPShareView.nameLabel.text = @"WhatsApp";
        [WHAPPShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        WHAPPShareView.tag = 3;
        [shareBackView addSubview:WHAPPShareView];
        [WHAPPShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
            
        }];
        leftView = WHAPPShareView;
    }
    
    if ([RPinterestManager shared].whetherInstall) {
        XZZSingleSharedView * PShareView = [XZZSingleSharedView allocInit];
        PShareView.imageView.image = imageName(@"goods_details_pinterest");
        PShareView.nameLabel.text = @"pinterest";
        [PShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        PShareView.tag = 4;
        [shareBackView addSubview:PShareView];
        [PShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = PShareView;
    }
    
        XZZSingleSharedView * copyShareView = [XZZSingleSharedView allocInit];
        copyShareView.imageView.image = imageName(@"goods_details_copylink");
        copyShareView.nameLabel.text = @"Copy link";
        [copyShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        copyShareView.tag = 5;
        [shareBackView addSubview:copyShareView];
        [copyShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = copyShareView;
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view);
    }];
    
    
    

}

- (void)addisKolView
{
    WS(wSelf)
    UIView * labelBackView = [UIView allocInit];
    labelBackView.backgroundColor = kColor(0xffffff);
    [self.view addSubview:labelBackView];
    [labelBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(@10);
        make.height.equalTo(@57);
    }];
    
    weakView(weak_labelBackView, labelBackView);
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [labelBackView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weak_labelBackView);
        make.height.equalTo(@.5);
    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [labelBackView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(weak_labelBackView);
        make.height.equalTo(@.5);
    }];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.text = @"Thanks! Enjoy shopping with Jolimall?\nClick share button to refer more friends!";
    label.numberOfLines = 2;
    [labelBackView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weak_labelBackView);
        make.left.equalTo(@15);
    }];
    
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(labelBackView.mas_bottom).offset(10);
    }];
    
    UIView * shareBackView = [UIView allocInit];
    shareBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shareBackView];
    [shareBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.scrollView.mas_bottom);
    }];
    
    weakView(weak_shareBackView, shareBackView)
    UIView * dividerView3 = [UIView allocInit];
    dividerView3.backgroundColor = DIVIDER_COLOR;
    [shareBackView addSubview:dividerView3];
    [dividerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weak_shareBackView);
        make.height.equalTo(@.5);
    }];
    
    UIButton * shoppingButton = [UIButton allocInitWithTitle:@"CONTINUE SHOPPING" color:kColor(0xffffff) selectedTitle:@"CONTINUE SHOPPING" selectedColor:kColor(0xffffff) font:18];
    shoppingButton.titleLabel.font = textFont_bold(18);
    shoppingButton.layer.cornerRadius = 5;
    shoppingButton.layer.masksToBounds = YES;
    shoppingButton.backgroundColor = button_back_color;
    //            shoppingButton.layer.borderColor = [UIColor blackColor].CGColor;
    //            shoppingButton.layer.borderWidth = 1;
    [shoppingButton addTarget:self action:@selector(clickOnReturnHomePageButton) forControlEvents:(UIControlEventTouchUpInside)];
    [shareBackView addSubview:shoppingButton];
    [shoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@35);
        make.height.equalTo(@45);
        make.centerX.equalTo(wSelf.view);
        make.bottom.equalTo(weak_shareBackView.mas_bottom).offset(-44);
    }];
    
    
    XZZSingleSharedView * FBShareView = [XZZSingleSharedView allocInit];
    FBShareView.imageView.image = imageName(@"goods_details_FB");
    FBShareView.nameLabel.text = @"FaceBook";
    [FBShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
    FBShareView.tag = 1;
    [shareBackView addSubview:FBShareView];
    [FBShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@0);
        make.bottom.equalTo(shoppingButton.mas_top).offset(-20);
        make.height.equalTo(@100);
    }];
    
    UIView * leftView = FBShareView;
    
    if ([RFBMessenger shared].whetherInstall) {
        XZZSingleSharedView * FBMShareView = [XZZSingleSharedView allocInit];
        FBMShareView.imageView.image = imageName(@"goods_details_Messenger");
        FBMShareView.nameLabel.text = @"Message";
        [FBMShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        FBMShareView.tag = 2;
        [shareBackView addSubview:FBMShareView];
        [FBMShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = FBMShareView;
    }
    
    
    if ([RWhatsAppManager shared].whetherInstall) {
        XZZSingleSharedView * WHAPPShareView = [XZZSingleSharedView allocInit];
        WHAPPShareView.imageView.image = imageName(@"goods_details_whatsapp");
        WHAPPShareView.nameLabel.text = @"WhatsApp";
        [WHAPPShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        WHAPPShareView.tag = 3;
        [shareBackView addSubview:WHAPPShareView];
        [WHAPPShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
            
        }];
        leftView = WHAPPShareView;
    }
    
    if ([RPinterestManager shared].whetherInstall) {
        XZZSingleSharedView * PShareView = [XZZSingleSharedView allocInit];
        PShareView.imageView.image = imageName(@"goods_details_pinterest");
        PShareView.nameLabel.text = @"pinterest";
        [PShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        PShareView.tag = 4;
        [shareBackView addSubview:PShareView];
        [PShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = PShareView;
    }
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view).offset(-15);
    }];
    
    
    
}

- (XZZSingleSharedView *)shareTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag
{
    XZZSingleSharedView * shareView = [XZZSingleSharedView allocInit];
    shareView.imageView.image = imageName(imageName);
    shareView.nameLabel.text = title;
    shareView.tag = tag;
    return shareView;
}

- (void)shareTap:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/orderShare/%@", h5_prefix, self.orderId];
    
//    [XZZBuriedPoint shareProductInfor:self.goodsInfor platform:type];
    
    NSString * title = @"I just shopped my faves on Jolimall.com - a trending site with factory price and cut out the middleman. View my cute items >";
    
    XZZOrderSku * orderSku = [self.orderDetail.skus firstObject];
    
    NSString * pictureUrl = orderSku.image;
    
    switch (tag) {
        case 1:{
            RFacebookManager* manager = [RFacebookManager shared];
            [manager shareWebpageWithURL:urlStr
                                   quote:title
                                 hashTag:@"JoLiMall"
                                    from:self
                                    mode:ShareModeSheet//ShareModeAutomatic
                              completion:^(RShareSDKPlatform platform, ShareResult result, NSString *errorInfo) {
                                  if (result == RShareResultSuccess) {
                                      NSLog(@"分享成功");
                                  } else if (result == RShareResultCancel){
                                      NSLog(@"分享取消");
                                  } else {
                                      NSLog(@"分享失败%@", errorInfo);
                                      
                                  }
                              }];
        }
            break;
        case 2:{
            [[RFBMessenger shared] shareTitle:title
                                          url:urlStr
                                 elementTitle:title
                                     subtitle:title
                                     imageUrl:pictureUrl
                                   completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
                                       if (result == RShareResultSuccess) {
                                           NSLog(@"分享成功");
                                       } else if (result == RShareResultCancel){
                                           NSLog(@"分享取消");
                                       } else {
                                           NSLog(@"分享失败%@", errorInfo);
                                           
                                       }
                                   }];
        }
            break;
        case 3:{
            [[RWhatsAppManager shared] shareText:[NSString stringWithFormat:@"%@\n%@", title, urlStr]];
        }
            break;
        case 4:{
            RPinterestManager* manager = [RPinterestManager shared];
            [manager shareImageWithURL:pictureUrl
                            webpageURL:urlStr
                               onBoard:@"JoLiMall"
                           description:title
                                  from:self
                            completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
                                if (result == RShareResultSuccess) {
                                    NSLog(@"分享成功");
                                } else if (result == RShareResultCancel){
                                    NSLog(@"分享取消");
                                } else {
                                    NSLog(@"分享失败%@", errorInfo);
                                    
                                }
                            }];
        }
            break;
            
        case 5:{
            UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
            
            pastboard.string = urlStr;
            
            
            SVProgressSuccess(@"Link copy successful")
        }
            
        default:
            break;
    }
}

#pragma mark ----*  返回首页
/**
 *  返回首页
 */
- (void)clickOnReturnHomePageButton
{
    NSLog(@"%@", self.navigationController);
    self.tabBarController.selectedIndex = 0;

    
    
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf popToRootViewControllerAnimated:YES];
        });
        
    });
    
}

- (void)clickOnJoinNow
{
    XZZWebViewController * webVC = [XZZWebViewController allocInit];
    webVC.webUrl = @"https://m.jolimall.com/dynamicPage?titleName=Get%20Reward&id=5";
    webVC.myTitle = @"Get Reward";
    [self pushViewController:webVC animated:YES];
}




#pragma mark ----*  引导注册
/**
 *  引导注册
 */
- (void)clickOnGuideRegistrationButton
{
    WS(wSelf)
    XZZLoginViewController * logInVC = [XZZLoginViewController allocInit];
    XZZMyNavViewController * navVC = [[XZZMyNavViewController alloc] initWithRootViewController:logInVC];
    [self.navigationController presentViewController:navVC animated:YES completion:^{
        [wSelf clickOnReturnHomePageButton];
    }];
    
}
#pragma mark ----
/**
 *  try again
 */
- (void)clickOnTryAgainButton
{
    if (!User_Infor.isLogin) {
        XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
        orderDetailsVC.orderID = self.orderId;
        [self pushViewController:orderDetailsVC animated:YES];
    }else{
        XZZOrderListViewController * orderListVC = [XZZOrderListViewController allocInit];
        [self pushViewController:orderListVC animated:YES];
    }
}



@end
