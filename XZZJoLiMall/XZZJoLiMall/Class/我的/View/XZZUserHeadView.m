//
//  XZZUserHeadView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZUserHeadView.h"

@implementation XZZUserHeadView

+ (instancetype)allocInit
{
    XZZUserHeadView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    WS(wSelf)
    
    UIButton * setUpButton = [UIButton allocInitWithFrame:CGRectMake(0, 0, 50, 40)];
    [setUpButton setImage:imageName(@"my_set_up") forState:(UIControlStateNormal)];
    [setUpButton setImage:imageName(@"my_set_up") forState:(UIControlStateSelected)];
    setUpButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);//
    [setUpButton addTarget:self action:@selector(clickOnSetUp) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:setUpButton];
    [setUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf);
        make.height.equalTo(@40);
        make.width.equalTo(@70);
        if (StatusRect.size.height == 44) {
            make.top.equalTo(@40);
        }else{
            make.top.equalTo(@20);
        }
    }];
    
    UIButton * headPortraitButton = [UIButton allocInit];
    [headPortraitButton setImage:imageName(@"my_head_image") forState:(UIControlStateNormal)];
    [headPortraitButton setImage:imageName(@"my_head_image") forState:(UIControlStateHighlighted)];
    [headPortraitButton addTarget:self action:@selector(clickOnLogIn) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:headPortraitButton];
    [headPortraitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        if (StatusRect.size.height == 44) {
            make.top.equalTo(@84);
        }else{
            make.top.equalTo(@60);
        }
    }];
    
    weakView(weak_headPortraitButton, headPortraitButton)
    
    self.logInButton = [UIButton allocInit];
    [self.logInButton setTitle:@"Sign In / Register" forState:(UIControlStateNormal)];
    [self.logInButton setTitle:@"Sign In / Register" forState:(UIControlStateHighlighted)];
    [self.logInButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    [self.logInButton setTitleColor:kColor(0x000000) forState:(UIControlStateHighlighted)];
    self.logInButton.titleLabel.font = textFont_bold(14);
    [self.logInButton addTarget:self action:@selector(clickOnLogIn) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.logInButton];
    [self.logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weak_headPortraitButton);
        make.left.equalTo(weak_headPortraitButton.mas_right).offset(15);
    }];
    
    self.emailLabel = [UILabel allocInit];
    self.emailLabel.textColor = kColor(0x000000);
    self.emailLabel.font = textFont(14);
    [self addSubview:self.emailLabel];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_headPortraitButton.mas_right).offset(15);
        make.top.bottom.equalTo(weak_headPortraitButton);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_headPortraitButton.mas_bottom).offset(30);
        make.height.equalTo(@(divider_view_width));
    }];
    weakView(weak_dividerView, dividerView)
    UIButton * orderButton = [self imageName:@"my_order" title:@"Orders"];
    [orderButton addTarget:self action:@selector(clickOnOders) forControlEvents:(UIControlEventTouchUpInside)];
    [orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(wSelf);
        make.height.equalTo(@80);
        make.top.equalTo(weak_dividerView.mas_bottom);
    }];
    
    UIView * leftView = orderButton;
//    if (!my_AppDelegate.iskol) {
        weakView(weak_orderButton, orderButton)
        UIButton * couponsButton = [self imageName:@"my_coupons" title:@"Coupons"];
        [couponsButton addTarget:self action:@selector(clickOnCoupons) forControlEvents:(UIControlEventTouchUpInside)];
        [couponsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.bottom.equalTo(weak_orderButton);
            make.left.equalTo(weak_orderButton.mas_right);
        }];
        leftView = couponsButton;
//    }

    weakView(weak_leftView, leftView)
    UIButton * addressButton = [self imageName:@"my_address" title:@"Addresses"];
    [addressButton addTarget:self action:@selector(clickOnAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.bottom.equalTo(weak_leftView);
        make.left.equalTo(weak_leftView.mas_right);
        make.right.equalTo(wSelf);
    }];
//    weakView(weak_addressButton, addressButton)
//    UIButton * supportButton = [self imageName:@"my_support" title:@"Support"];
//    [supportButton addTarget:self action:@selector(clickOnSupport) forControlEvents:(UIControlEventTouchUpInside)];
//    [supportButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.width.bottom.equalTo(weak_addressButton);
//        make.left.equalTo(weak_addressButton.mas_right);
//        make.right.equalTo(wSelf);
//    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.height.equalTo(@(divider_view_width));
    }];
    
}

- (UIButton *)imageName:(NSString *)name title:(NSString *)title
{
    UIButton * button = [UIButton allocInit];
    [self addSubview:button];
    weakView(weak_button, button)
    UIView * view = [UIView allocInit];
    view.userInteractionEnabled = NO;
    [button addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.equalTo(weak_button);
    }];
    weakView(weak_view, view)
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    imageView.image = imageName(name);
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(weak_view);
    }];
    weakView(weak_imageView, imageView)
    UILabel * label = [UILabel allocInit];
    label.textColor = kColor(0x000000);
    label.font = textFont(13);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_view);
        make.top.equalTo(weak_imageView.mas_bottom).offset(5);
        make.bottom.equalTo(weak_view);
    }];
    
    return button;
}

- (void)clickOnSetUp
{
    !self.setUp?:self.setUp();
}

- (void)clickOnLogIn
{
    !self.logIn?:self.logIn();
}

- (void)clickOnOders
{
    !self.orderList?:self.orderList();
}

- (void)clickOnCoupons
{
    !self.couponsList?:self.couponsList();
}

- (void)clickOnAddress
{
    !self.addressList?:self.addressList();
}

- (void)clickOnSupport
{
    !self.support?:self.support();
}


@end
