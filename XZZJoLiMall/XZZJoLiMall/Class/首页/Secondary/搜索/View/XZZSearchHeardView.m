//
//  XZZSearchHeardView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/25.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSearchHeardView.h"


@interface XZZSearchHeardView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedButton;

@end


@implementation XZZSearchHeardView

+ (instancetype)allocInit
{
    XZZSearchHeardView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    UIView * priceView = [UIView allocInit];
    [self addSubview:priceView];
    [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.bottom.equalTo(wSelf);
    }];
    weakView(weak_priceView, priceView)
    UIButton * priceButton = [UIButton allocInitWithTitle:@"Price" color:kColor(0x000000) selectedTitle:@"Price" selectedColor:kColor(0x000000) font:12];
    [priceView addSubview:priceButton];
    [priceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(weak_priceView);
    }];
    
    
    
    
    
    UIView * newArrivalsView = [UIView allocInit];
    [self addSubview:newArrivalsView];
    [newArrivalsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_priceView.mas_right);
        make.top.bottom.width.equalTo(weak_priceView);
    }];
    weakView(weak_newArrivalsView, newArrivalsView)
    
    UIButton * newArrivalsButton = [UIButton allocInitWithTitle:@"New Arrivals" color:kColor(0x000000) selectedTitle:@"New Arrivals" selectedColor:kColor(0x000000) font:12];
    [newArrivalsView addSubview:newArrivalsButton];
    [newArrivalsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(weak_newArrivalsView);
    }];
    
    
    UIView * reviewsView = [UIView allocInit];
    [self addSubview:reviewsView];
    [reviewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_newArrivalsView.mas_right);
        make.top.bottom.width.equalTo(weak_newArrivalsView);
        make.right.equalTo(wSelf).offset(-11);
    }];
    weakView(weak_reviewsView, reviewsView)
    UIButton * reviewsButton = [UIButton allocInitWithTitle:@"Reviews" color:kColor(0x000000) selectedTitle:@"Reviews" selectedColor:kColor(0x000000) font:12];
    [reviewsView addSubview:reviewsButton];
    [reviewsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(weak_reviewsView);
    }];
    
    
}






@end
