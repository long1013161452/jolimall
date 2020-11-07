//
//  XZZCartListCouponsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCartListCouponsView.h"

@interface XZZCartListCouponsView()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;

@end

@implementation XZZCartListCouponsView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZCartListCouponsView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (void)addView
{
    self.backgroundColor = kColor(0xf8f8f8);
    self.layer.masksToBounds = YES;
    WS(wSelf)
    UIView * titleBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    [titleBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshHeight)]];
    titleBackView.backgroundColor = kColorWithRGB(254, 86, 86, .1);
    [self addSubview:titleBackView];
    [titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(@0);
        make.height.equalTo(@45);
    }];
    
    weakView(weak_titleBackView, titleBackView)
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 20, 20) imageName:@"goods_details_discount"];
    [titleBackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_titleBackView).offset(11);
        make.centerY.equalTo(weak_titleBackView);
        make.width.height.equalTo(@18);
    }];
    
    weakView(weak_imageView, imageView)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(imageView.right + 10, 0, 200, titleBackView.height) backColor:nil textColor:kColor(0xD73E3E) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.textColor = button_back_color;
//    titleLabel.text = @"Coupons for all products";
    titleLabel.text = My_Basic_Infor.cartDiscountDescriptionOne;
    titleLabel.font = textFont_bold(14);
    [titleBackView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.top.bottom.equalTo(weak_titleBackView);
        make.left.equalTo(@40);
    }];
    
    weakView(weak_titleLabel, titleLabel)
    UIImageView * arrowImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 15, 15) imageName:@"goods_details_arrow_red"];
    [titleBackView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_titleBackView).offset(-5);
        make.centerY.equalTo(weak_titleBackView);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
        make.left.equalTo(weak_titleLabel.mas_right).offset(-10);
    }];
    
    

    
    CGFloat top = titleBackView.bottom + 10;
    int i = 0;
    UIView * topView = titleBackView;
    for (NSString * str in My_Basic_Infor.cartTopRemindList) {
        if (i >= 5) {
            break;
        }
        weakView(weak_topView, topView)
        UILabel * label = [UILabel labelWithFrame:CGRectMake(10, top, ScreenWidth - 10 * 2, 35) backColor:nil textColor:kColor(0xD73E3E) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
        label.textColor = button_back_color;
        label.text = str;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(top));
            make.height.equalTo(@35);
            make.left.equalTo(weak_titleLabel);
            make.centerX.equalTo(wSelf);
        }];
        
        top = label.bottom;
    }
    self.totalHeight = top + 10;
}


- (void)refreshHeight
{
    CGFloat height = 0;
    if (!self.isAn) {
        height = self.totalHeight;
    }else{
        height = 45;
    }
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:.3 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        [self.superview layoutIfNeeded];//强制绘制
        
    }];
    self.isAn = !self.isAn;
}

- (void)setIsAn:(BOOL)isAn
{
    _isAn = isAn;
    
    if (!isAn) {
        self.titleLabel.text = My_Basic_Infor.cartDiscountDescriptionOne;
    }else{
        self.titleLabel.text = My_Basic_Infor.cartDiscountDescriptionTwo;
    }
}



@end
