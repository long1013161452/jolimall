//
//  XZZReplaceCouponsStateView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZReplaceCouponsStateView.h"

@interface XZZReplaceCouponsStateView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * dividerView;

@end


@implementation XZZReplaceCouponsStateView

+ (instancetype)allocInit
{
    XZZReplaceCouponsStateView * view = [super allocInit];
    view.backgroundColor = [UIColor whiteColor];
    [view addView];
    return view;
}

- (void)addView{
    CGFloat width = ScreenWidth / 3.0;

    CGFloat height = 45;
    /***  分割线  小的 */
    self.dividerView = [UIView allocInitWithFrame:CGRectMake(0, height - 2, width - 30, 2)];
    self.dividerView.backgroundColor = kColor(0xF41C19);
    [self addSubview:self.dividerView];
    
    NSArray * titleArray = @[@"Unused", @"Already used", @"Expired"];
    
    for (int i = 0; i < titleArray.count; i++) {/***  按钮信息 */
        
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(width * i, 0, width, height)];
        [button setTitleColor:kColorWithRGB(0, 0, 0, 1) forState:(UIControlStateNormal)];
//        [button setTitleColor:kColor(0xff563f) forState:(UIControlStateSelected)];
        [button setTitleColor:button_back_color forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(clickOnButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        button.tag = i;
        if (ScreenWidth == 320) {
            button.titleLabel.font = textFont(12);
        }else{
            button.titleLabel.font = textFont(14);
        }
        [self addSubview:button];
        
        if (i == 0) {
            self.dividerView.centerX = button.centerX;
        }        
    }
}

- (void)clickOnButton:(UIButton *)button{
    self.dividerView.centerX = button.centerX;
    XZZCouponState state;
    if (button.tag == 0) {
        state = XZZCouponStateUnused;
    }else if (button.tag == 1){
        state = XZZCouponStateAlreadyUsed;
    }else{
        state = XZZCouponStateExpired;
    }
    !self.chooseCouponsState?:self.chooseCouponsState(state);
}

@end
