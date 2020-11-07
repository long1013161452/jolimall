//
//  XZZRegisteredView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRegisteredView.h"

@implementation XZZRegisteredView

+ (instancetype)allocInit
{
    XZZRegisteredView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    
    WS(wSelf)
    self.emailTextField = [self creatingViewInfor:@"Email" top:nil];
    self.passwordTextField = [self creatingViewInfor:@"Password" top:self.emailTextField.superview];
    self.passwordTextField.secureTextEntry = YES;
    self.twoPasswordTextField = [self creatingViewInfor:@"Comfirm Password" top:self.passwordTextField.superview];
    self.twoPasswordTextField.secureTextEntry = YES;
    weakView(weakTopView, self.twoPasswordTextField.superview)
    
    UIButton * selectedButton = [UIButton allocInit];
    [selectedButton setImage:imageName(@"login_no_selected") forState:(UIControlStateNormal)];
    [selectedButton setImage:imageName(@"login_selected") forState:(UIControlStateSelected)];
    [selectedButton addTarget:self action:@selector(clickOnSelectProtocolInforButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:selectedButton];
    [self clickOnSelectProtocolInforButton:selectedButton];
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakTopView);
        make.top.equalTo(weakTopView.mas_bottom).offset(12);
    }];
    
    UILabel * agreementLabel = [UILabel allocInit];
    agreementLabel.text = @"I agree to Jolimall.com Terms and Conditions";
    agreementLabel.font = textFont(11);
    agreementLabel.textColor = kColor(0x505050);
    agreementLabel.userInteractionEnabled = YES;
    agreementLabel.attributedText = [self text:agreementLabel.text font:11 color:kColor(0x999999) discolorationText:@"Terms and Conditions" discolorationFont:11 discolorationColor:button_back_color];
    [agreementLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnViewRegistrationTerms)]];
    [self addSubview:agreementLabel];
    [agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectedButton.mas_right).offset(3);
        make.right.equalTo(weakTopView);
        make.centerY.equalTo(selectedButton);
        make.height.equalTo(@60);
    }];

    weakView(weakAgreementLabel, agreementLabel)
    UIButton * singUPButton = [UIButton allocInit];
    [singUPButton setTitle:@"SIGN UP" forState:(UIControlStateNormal)];
    [singUPButton setTitle:@"SIGN UP" forState:(UIControlStateSelected)];
    [singUPButton setTitleColor:kColor(0xffffff) forState:(UIControlStateNormal)];
    [singUPButton setTitleColor:kColor(0xffffff) forState:(UIControlStateSelected)];
    singUPButton.titleLabel.font = textFont(16);
    singUPButton.backgroundColor = button_back_color;
    [singUPButton addTarget:self action:@selector(clickOnSingUpButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:singUPButton];
    [singUPButton cutRounded:5];
    [singUPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakTopView);
        make.height.equalTo(@45);
        make.top.equalTo(weakAgreementLabel.mas_bottom);
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

- (void)clickOnSingUpButton
{
    !self.singUp?:self.singUp();
}

- (void)clickOnViewRegistrationTerms
{
    !self.viewRegistrationTerms?:self.viewRegistrationTerms();
}

- (void)clickOnSelectProtocolInforButton:(UIButton *)button{
    button.selected = !button.selected;
    self.selectionState = button.selected;
}

@end
