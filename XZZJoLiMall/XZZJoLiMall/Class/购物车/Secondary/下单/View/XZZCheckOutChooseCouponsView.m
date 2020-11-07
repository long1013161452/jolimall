//
//  XZZCheckOutChooseCouponsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/5.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutChooseCouponsView.h"


@implementation XZZCheckOutChooseCouponsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZCheckOutChooseCouponsView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

+ (instancetype)allocInit
{
    XZZCheckOutChooseCouponsView * view = [super allocInit];
    [view addView];
    return view;
}
    

- (void)addView
{
    WS(wSelf)
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 10, ScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOutChooseCoupons)]];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf);
        make.left.equalTo(wSelf);
        make.top.equalTo(@0);
    }];
    
    UIView * dividerView1 = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, .5)];
    dividerView1.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView1];
    
    UILabel * couponLabel = [UILabel labelWithFrame:CGRectMake(10, 0, 200, backView.height) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    couponLabel.text = @"Coupon";
    [backView addSubview:couponLabel];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(wSelf);
        make.top.equalTo(@0);
    }];
    

    
    weakView(weak_backView, backView)
    UIImageView * imageView = [UIImageView allocInit];
    imageView.image = imageName(@"address_arrow");
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView).offset(-15);
        make.centerY.equalTo(weak_backView);
        make.width.equalTo(@8);
    }];
    weakView(weak_imageView, imageView)
    self.couponCodeLabel = [UILabel labelWithFrame:CGRectMake(10, 0, 200, backView.height) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.couponCodeLabel];
    [self.couponCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.top.equalTo(@0);
        make.right.equalTo(weak_imageView.mas_left).offset(-10);
    }];
    
    UIView * dividerView2 = [UIView allocInitWithFrame:CGRectMake(0, backView.height - .5, ScreenWidth, .5)];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weak_backView);
        make.height.equalTo(@.5);
    }];
    self.height = backView.bottom;
    
}

- (void)clickOutChooseCoupons
{
    !self.chooseCouponBlock?:self.chooseCouponBlock();
}



- (void)setCouponCode:(NSString *)couponCode
{
    _couponCode = couponCode;
    self.couponCodeLabel.text = couponCode;
    
}

@end
