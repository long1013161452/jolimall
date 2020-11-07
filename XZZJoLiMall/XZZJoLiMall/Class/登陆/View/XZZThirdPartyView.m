//
//  XZZThirdPartyView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZThirdPartyView.h"

@implementation XZZThirdPartyView

+ (instancetype)allocInit
{
    XZZThirdPartyView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@.5);
        make.width.equalTo(@150);
    }];
    
    UILabel * promptLabel = [UILabel allocInit];
    promptLabel.text = @"  Or join with  ";
    promptLabel.textColor = kColorWithRGB(146, 146, 146, 1);
    promptLabel.font = textFont(15);
    promptLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dividerView);
        make.top.equalTo(wSelf);
    }];
    
    UIButton * fbButton = [UIButton allocInit];
    [fbButton setImage:imageName(@"login_FB") forState:(UIControlStateNormal)];
    [fbButton setImage:imageName(@"login_FB") forState:(UIControlStateHighlighted)];
    [fbButton addTarget:self action:@selector(fbLogIn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:fbButton];
    [fbButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel.mas_bottom).offset(20);
        make.width.height.equalTo(@44);
        make.bottom.equalTo(wSelf).offset(-40);
    }];
    
    weakView(weak_fbButton, fbButton);
    if (@available(iOS 13.0, *)) {

//        ASAuthorizationAppleIDButton * appleIdButton = [[ASAuthorizationAppleIDButton alloc]initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
        
        [fbButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.mas_centerX).offset(-20);
        }];
        
        UIButton * appleIdButton = [UIButton allocInitWithImageName:@"logIn_apple_button" selectedImageName:@"logIn_apple_button"];
        
        [appleIdButton addTarget:self action:@selector(appleIdLogIn:) forControlEvents:(UIControlEventTouchUpInside)];
        [appleIdButton cutRounded:22];
        [self addSubview:appleIdButton];
        [appleIdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.mas_centerX).offset(20);
            make.centerY.equalTo(weak_fbButton);
            make.height.width.equalTo(@44);
        }];
    }else{
        [fbButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
        }];
    }
    
        
    UILabel * agreementPolicyLabel = [UILabel allocInit];
    agreementPolicyLabel.text = @"By joining you agree to our Privacy Policy";
    agreementPolicyLabel.font = textFont(11);
    agreementPolicyLabel.textColor = kColor(0x505050);
    agreementPolicyLabel.textAlignment = NSTextAlignmentCenter;
    agreementPolicyLabel.userInteractionEnabled = YES;
    [agreementPolicyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnViewPrivacyPolicy)]];
    agreementPolicyLabel.attributedText = [self text:agreementPolicyLabel.text font:11 color:kColor(0x999999) discolorationText:@"Privacy Policy" discolorationFont:11 discolorationColor:button_back_color];

    [self addSubview:agreementPolicyLabel];
    [agreementPolicyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(fbButton.mas_bottom);
        make.bottom.equalTo(wSelf);
        make.centerX.equalTo(wSelf);
        
    }];
}

- (void)fbLogIn:(UIButton *)button{
    NSLog(@"%s %d 行", __func__, __LINE__);
    !self.fbThirdPartyLogin?:self.fbThirdPartyLogin();
}

- (void)appleIdLogIn:(UIButton *)button
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    !self.appleThirdPartyLogin?:self.appleThirdPartyLogin();
}

- (void)clickOnViewPrivacyPolicy
{
    !self.viewPrivacyPolicy?:self.viewPrivacyPolicy();
}

@end
