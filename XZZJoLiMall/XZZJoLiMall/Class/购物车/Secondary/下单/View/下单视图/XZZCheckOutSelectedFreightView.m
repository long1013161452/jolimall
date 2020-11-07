//
//  XZZCheckOutSelectedFreightView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutSelectedFreightView.h"

@interface XZZCheckOutSelectedFreightView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * postageLabel;

@end

@implementation XZZCheckOutSelectedFreightView

- (void)setPostage:(CGFloat)postage name:(nonnull NSString *)name
{
    _postage = postage;
    if (!self.postageLabel) {
        [self addView];
    }
    self.postageLabel.text = [NSString stringWithFormat:@"%@    $%.2f", name, postage];
}

- (void)addView
{
    WS(wSelf)
    UIView * dividerView1 = [UIView allocInit];
    dividerView1.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView1];
    [dividerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.text = @"Method";
    label.font = textFont_bold(13);
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(@0);
        make.height.equalTo(@35);
    }];
    
    weakView(weak_label, label)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_label.mas_bottom);
        make.height.equalTo(@45);
    }];
    weakView(weak_backView, backView)
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(@0);
        make.height.equalTo(@.5);
    }];
    
    UIView * dividerView3 = [UIView allocInit];
    dividerView3.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView3];
    [dividerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.bottom.equalTo(weak_backView);
        make.height.equalTo(@.5);
    }];
    
    self.postageLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.postageLabel];
    [self.postageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_backView);
        make.left.equalTo(@11);
    }];
    
    UIButton * button = [UIButton allocInitWithTitle:@"Change" color:button_back_color selectedTitle:@"Change" selectedColor:button_back_color font:12];
    [button addTarget:self action:@selector(clickOnChangeButton) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView).offset(-10);
        make.centerY.equalTo(wSelf.postageLabel);
    }];
    
}

- (void)clickOnChangeButton
{
    !self.changePostage?:self.changePostage();
}

@end
