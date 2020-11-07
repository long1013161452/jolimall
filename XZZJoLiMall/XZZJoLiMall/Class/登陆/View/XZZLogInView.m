//
//  XZZLogInView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZLogInView.h"

@implementation XZZLogInView

+ (instancetype)allocInit
{
    XZZLogInView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    
    
    WS(wSelf)
    self.emailTextField = [self creatingViewInfor:@"Email" top:nil];
    self.passwordTextField = [self creatingViewInfor:@"Password" top:self.emailTextField.superview];
    self.passwordTextField.secureTextEntry = YES;
    weakView(weakTopView, self.passwordTextField.superview)
    UIButton * forgetPasswordButton = [UIButton allocInit];
    [forgetPasswordButton setTitle:@"Forgot your password?" forState:(UIControlStateNormal)];
    forgetPasswordButton.titleLabel.font = textFont(11);
//    [forgetPasswordButton setTitleColor:kColor(0xff563f) forState:(UIControlStateNormal)];
    [forgetPasswordButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
    [forgetPasswordButton addTarget:self action:@selector(clickOnChangePassword) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakTopView.mas_bottom);
        make.right.equalTo(weakTopView);
        make.height.equalTo(@60);
    }];
    
    weakView(weakForgetButton, forgetPasswordButton)
    UIButton * logInButton = [UIButton allocInit];
    [logInButton setTitle:@"LOG IN" forState:(UIControlStateNormal)];
    [logInButton setTitle:@"LOG IN" forState:(UIControlStateSelected)];
    [logInButton setTitleColor:kColor(0xffffff) forState:(UIControlStateNormal)];
    [logInButton setTitleColor:kColor(0xffffff) forState:(UIControlStateSelected)];
    logInButton.titleLabel.font = textFont(16);
    logInButton.backgroundColor = button_back_color;
    [logInButton addTarget:self action:@selector(clickOnLogIn) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:logInButton];
    [logInButton cutRounded:5];
    [logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakTopView);
        make.height.equalTo(@45);
        make.top.equalTo(weakForgetButton.mas_bottom);
        make.bottom.equalTo(wSelf);
    }];
    
}


- (UITextField *)creatingViewInfor:(NSString *)placeholder top:(UIView *)topView
{
    WS(wSelf)
    UIView * view = [UIView allocInit];
    view.backgroundColor = BACK_COLOR;
    [self addSubview:view];
    [view cutRounded:5];
    weakView(WV, topView)
    if (topView) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(WV.mas_bottom).offset(12);
            make.left.height.centerX.equalTo(WV);
        }];
    }else{
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@25);
            make.height.equalTo(@40);
            make.centerX.equalTo(wSelf);
        }];
    }
    
    weakView(weakView, view)
    UITextField * textField = [UITextField allocInit];
    textField.placeholder = placeholder;
    [view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.bottom.centerX.equalTo(weakView);
    }];
    
    return textField;
}

- (void)clickOnLogIn
{
    !self.logIn?:self.logIn();
}

- (void)clickOnChangePassword
{
    !self.changePassword?:self.changePassword();
}


@end
