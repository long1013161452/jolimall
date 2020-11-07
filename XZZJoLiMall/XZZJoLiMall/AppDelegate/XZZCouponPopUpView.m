//
//  XZZCouponPopUpView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/5.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponPopUpView.h"

@implementation XZZCouponPopUpView

- (void)setCouponArray:(NSArray *)couponArray
{
    _couponArray = couponArray;
    [self addView];
}

- (void)addView
{
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backView.backgroundColor = kColorWithRGB(0, 0, 0, .5);
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCouponInformation)]];
    [self addSubview:backView];
    
    UIView * couponsBackView = [UIView allocInitWithFrame:CGRectMake(296, 0, 296, 336)];
    couponsBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:couponsBackView];
    couponsBackView.center = CGPointMake(ScreenWidth / 2.0, ScreenHeight / 2.0);
    
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 0, 296, 275)];
    [couponsBackView addSubview:scrollView];
    
    CGFloat top = 10;
    CGFloat height = 115;
    CGFloat width = couponsBackView.width;
    for (XZZCouponsInfor * couponsInfor in self.couponArray) {
        UIView * view = [self createCouponViewFrome:CGRectMake(0, top, width, height) couponsInfor:couponsInfor];
        [scrollView addSubview:view];
        top = view.bottom;
    }
    scrollView.contentSize = CGSizeMake(width, top + 10);
    
    
    UIButton * getButton = [UIButton allocInitWithTitle:@"COLLECT ALL" color:kColor(0xffffff) selectedTitle:@"COLLECT ALL" selectedColor:kColor(0xffffff) font:16];
    getButton.backgroundColor = button_back_color;
    getButton.frame = CGRectMake(13.5, scrollView.bottom + 9, couponsBackView.width - 13.5 * 2, couponsBackView.height - scrollView.height - 9 * 2);
    [getButton addTarget:self action:@selector(clickOutButton) forControlEvents:(UIControlEventTouchUpInside)];
    [couponsBackView addSubview:getButton];
    
    UIImageView * shutDownImageView = [UIImageView allocInitWithFrame:CGRectMake(0, couponsBackView.bottom + 20, 32, 32)];
    shutDownImageView.centerX = couponsBackView.centerX;
    shutDownImageView.image = imageName(@"window_shut_Down");
    [backView addSubview:shutDownImageView];
    
}

- (UIView *)createCouponViewFrome:(CGRect)frome couponsInfor:(XZZCouponsInfor *)couponsInfor
{
    UIView * view = [UIView allocInitWithFrame:frome];
    
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(11, 10, view.width - 11 * 2, view.height - 10) imageName:@"coupons_bounced"];
    [view addSubview:imageView];
    
    weakView(weak_imageView, imageView)
    
    UILabel * discountAmountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xf41c19) textFont:24 textAlignment:(NSTextAlignmentLeft) tag:1];
    [imageView addSubview:discountAmountLabel];
    [discountAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@17);
    }];
    
    weakView(weak_discountAmountLabel, discountAmountLabel)
    UILabel * detailsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    [imageView addSubview:detailsLabel];
    [detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_discountAmountLabel);
        make.top.equalTo(weak_discountAmountLabel.mas_bottom).offset(4);
    }];
    
    weakView(weak_detailsLabel, detailsLabel)
    UILabel * expiresTimeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x666666) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    [imageView addSubview:expiresTimeLabel];
    [expiresTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_detailsLabel);
        make.bottom.equalTo(@(-12.5));
    }];
    
    
    
    weakView(weak_expiresTimeLabel, expiresTimeLabel)
    UILabel * couponsCodeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:10 textAlignment:(NSTextAlignmentRight) tag:1];
    [imageView addSubview:couponsCodeLabel];
    [couponsCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_expiresTimeLabel);
        make.right.equalTo(weak_imageView).offset(-20);
    }];
    
    if (couponsInfor.discountPercent) {
        discountAmountLabel.text =  couponsInfor.discountPercent;
    }else{
        discountAmountLabel.text =  couponsInfor.discountMoney;
    }
    detailsLabel.text = couponsInfor.prompt;
    if (couponsInfor.endTime) {
        expiresTimeLabel.text = [NSString stringWithFormat:@"Expires %@", [self timeFormat:@"yyyy-MM-dd" conversionDate:couponsInfor.endTime]];
    }else{
        expiresTimeLabel.text = [NSString stringWithFormat:@"Expires %@", couponsInfor.expireDays];
    }
    couponsCodeLabel.text = [NSString stringWithFormat:@"Code:%@", couponsInfor.code];
    
    return view;
}

- (void)clickOutButton
{
    !self.getAllCoupons?:self.getAllCoupons(self.couponArray);
}

- (void)removeCouponInformation
{
    [self removeFromSuperview];
}

@end
