//
//  XZZCheckOutSecureCheckOutView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/7.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutSecureCheckOutView.h"

@implementation XZZCheckOutSecureCheckOutView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZCheckOutSecureCheckOutView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

+ (instancetype)allocInit
{
    XZZCheckOutSecureCheckOutView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    self.backgroundColor = kColor(0xf2f2f2);
    WS(wSelf)
    UIView * backView = [UIView allocInit];
    [self addSubview: backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf);
    }];
    weakView(weak_baekView, backView)
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"order_check_out_lock"];
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(weak_baekView);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    weakView(weak_imageView, imageView)
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    label.text = @"SECURE CHECKOUT";
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(weak_baekView);
        make.left.equalTo(weak_imageView.mas_right).offset(3);
    }];
    
}

@end
