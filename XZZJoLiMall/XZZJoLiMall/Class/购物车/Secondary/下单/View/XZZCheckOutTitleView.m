//
//  XZZCheckOutTitleView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutTitleView.h"

@interface XZZCheckOutTitleView ()



/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * rightView;

@end

@implementation XZZCheckOutTitleView


+ (instancetype)allocInit
{
    XZZCheckOutTitleView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    self.backgroundColor = BACK_COLOR;
    WS(wSelf)
    self.titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.bottom.equalTo(wSelf);
    }];
    
    
    self.rightView = [UIView allocInit];
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wSelf);
        make.right.equalTo(wSelf).offset(-11);
    }];
    
    UILabel * logInLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    logInLabel.attributedText = [self text:@"Already have an account?Log In" font:12 color:kColor(0x000000) underlineText:@"Log In" underlineFont:12 underlineColor:kColor(0xF41C19)];
    [self.rightView addSubview:logInLabel];
    [logInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(wSelf.rightView);
    }];
    self.rightView.hidden = YES;
    
    
    
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setIsRightViewHidden:(BOOL)isRightViewHidden
{
    _isRightViewHidden = isRightViewHidden;
    self.rightView.hidden = isRightViewHidden;
}


@end
