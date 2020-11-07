//
//  XZZCheckOutContactInforView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutContactInforView.h"

@interface XZZCheckOutContactInforView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * emailLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * switchButton;

@end


@implementation XZZCheckOutContactInforView

+ (instancetype)allocInit
{
    XZZCheckOutContactInforView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    XZZCheckOutTitleView * titleView = [XZZCheckOutTitleView allocInit];
    titleView.title = @"Contact information";
    titleView.isRightViewHidden = NO;
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@30);
    }];
    weakView(weak_titleView, titleView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_titleView.mas_bottom);
        make.height.equalTo(@.5);
    }];
    weakView(weak_dividerView, dividerView)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_dividerView.mas_bottom);
    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    weakView(weak_backView, backView)
    UIColor * textColor = kColor(0x727272);
    UILabel * emailLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    emailLabel.text = @"E-mail";
    [backView addSubview:emailLabel];
    self.emailLabel = emailLabel;
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(@15);
        make.height.equalTo(@15);
    }];
    weakView(weak_emailLabel, emailLabel)
    UIView * textBackView = [UIView allocInit];
    textBackView.layer.borderColor = kColor(0x000000).CGColor;
    textBackView.layer.borderWidth = .5;
    [backView addSubview:textBackView];
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_emailLabel);
        make.top.equalTo(weak_emailLabel.mas_bottom);
        make.height.equalTo(@35);
        make.centerX.equalTo(wSelf);
    }];
    weakView(weak_textBackView, textBackView)
    self.textField = [UITextField allocInit];
    self.textField.textColor = textColor;
    [textBackView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.bottom.centerX.equalTo(weak_textBackView);
    }];
    
    UIButton * switchButton = [UIButton allocInitWithTitle:@"Switch to phone number" color:textColor selectedTitle:@"Switch to E-mail" selectedColor:textColor font:10];
    [switchButton addTarget:self action:@selector(switchButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:switchButton];
    self.switchButton = switchButton;
    [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_textBackView.mas_bottom);
        make.right.equalTo(weak_textBackView.mas_right);
    }];
    weakView(weak_switchButton, switchButton)
    UIView * dividerView3 = [UIView allocInit];
    dividerView3.backgroundColor = textColor;
    [switchButton addSubview:dividerView3];
    [dividerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_switchButton);
        make.centerY.equalTo(weak_switchButton).offset(5);
        make.height.equalTo(@.5);
    }];
    
    
}

- (void)switchButton:(UIButton *)button
{
    button.selected = !button.selected;
    self.emailLabel.text = button.selected ? @"Phone" : @"E-mail";
    self.isEmail = !button.selected;
}

- (void)setIsEmail:(BOOL)isEmail
{
    _isEmail = isEmail;
    
    self.switchButton.selected = !isEmail;
    self.emailLabel.text = self.switchButton.selected ? @"Phone" : @"E-mail";
}


@end
