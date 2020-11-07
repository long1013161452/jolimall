//
//  XZZGoodsDetailsCouponInforView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/7.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsDetailsCouponInforView.h"

@implementation XZZGoodsDetailsCouponInforView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZGoodsDetailsCouponInforView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

+ (instancetype)allocInit
{
    XZZGoodsDetailsCouponInforView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView
{
    WS(wSelf)
    UIView * titleBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    titleBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleBackView];
    [titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(@0);
        make.height.equalTo(@60);
    }];
    
    weakView(weak_titleBackView, titleBackView)
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 20, 20) imageName:@"goods_details_discount"];
    [titleBackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.width.height.equalTo(@18);
    }];
    
    weakView(weak_imageView, imageView)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(imageView.right + 10, 0, 200, titleBackView.height) backColor:nil textColor:kColor(0xD73E3E) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.textColor = button_back_color;
    titleLabel.text = @"Coupons for all products";
    titleLabel.font = textFont_bold(16);
    [titleBackView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weak_titleBackView);
        make.top.equalTo(@10);
        make.left.equalTo(weak_imageView.mas_right).offset(10);
        make.centerY.equalTo(weak_imageView);
        make.right.equalTo(wSelf).offset(-16);
    }];

    
    CGFloat top = titleBackView.bottom;
    int i = 0;
    for (NSString * str in My_Basic_Infor.detailsPageOfferList) {
        if (i >= 5) {
            break;
        }
        UILabel * label = [UILabel labelWithFrame:CGRectMake(16, top, ScreenWidth - 10 * 2, 35) backColor:nil textColor:kColor(0xd73e3e) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
        label.textColor = button_back_color;
        label.text = str;
        [self addSubview:label];
        top = label.bottom;
    }
    self.height = top + 3;
}

@end
