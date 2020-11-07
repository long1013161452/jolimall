//
//  XZZCouponsGoodsListHeaderView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/13.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponsGoodsListHeaderView.h"

#define Aspect_ratio (100.0 / 375.0)

@interface XZZCouponsGoodsListHeaderView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * imageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * shareButton;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * buttonBackView;
/**
 * 选中的按钮
 */
@property (nonatomic, strong)UIButton * selectedButton;

/**
 * 下面划线
 */
@property (nonatomic, strong)UIView * dividerView;

/**
 * 点击位置信息   记录点击按钮的tag
 */
@property (nonatomic, assign)NSInteger selectedIndex;

@end

@implementation XZZCouponsGoodsListHeaderView

- (void)setCouponsInfor:(XZZCouponsInfor *)couponsInfor
{
    _couponsInfor = couponsInfor;
    [self addView];
}

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self removeAllSubviews];
    WS(wSelf)
    self.imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * Aspect_ratio)];
    [self addSubview:self.imageView];
    NSString * imageUrl = self.couponsInfor.bannerImage;
   
    if (imageUrl.length > 0) {
         [self.imageView addImageFromUrlStr:imageUrl];
    }else{
        self.imageView.height = 0;
    }
    
    UIButton * shareButton = [UIButton allocInitWithImageName:@"list_icon_share" selectedImageName:@"list_icon_share"];
    [shareButton addTarget:self action:@selector(clickOnShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(wSelf.imageView);
    }];
    self.shareButton = shareButton;
    
    
    self.buttonBackView = [UIView allocInitWithFrame:CGRectMake(0, self.imageView.bottom, self.width, 40)];
    self.buttonBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttonBackView];
    NSArray * titleArray = [NSArray arrayWithObjects:self.couponsInfor.limitTitle, self.couponsInfor.recommendTitle, nil];
    
    CGFloat width = self.width / titleArray.count;
    
    CGFloat height = self.buttonBackView.height;
    /***  分割线  小的 */
    self.dividerView = [UIView allocInitWithFrame:CGRectMake(0, height - 2, 100, 2)];
    self.dividerView.backgroundColor = button_back_color;//kColor(0xff563f);
    [self.buttonBackView addSubview:self.dividerView];
    
    
    for (int i = 0; i < titleArray.count; i++) {/***  按钮信息 */
        
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(width * i, 0, width, height)];
        [button setTitleColor:kColorWithRGB(0, 0, 0, 1) forState:(UIControlStateNormal)];
//        [button setTitleColor:kColor(0xff563f) forState:(UIControlStateSelected)];
        [button setTitleColor:button_back_color forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(clickOnButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        button.tag = i + 1;
        if (ScreenWidth == 320) {
            button.titleLabel.font = textFont(12);
        }else{
            button.titleLabel.font = textFont(14);
        }
        [self.buttonBackView addSubview:button];
        
        if (i == 0) {
            [self setSelectedButton:button];
        }
    }
    
    self.height = self.buttonBackView.bottom;
}


- (void)clickOnButton:(UIButton *)button
{
    if (![self.selectedButton isEqual:button]) {
        
        self.selectedButton = button;
        
        !self.selectCouponGoodsType?:self.selectCouponGoodsType(button.tag);
        
    }
}

#pragma mark ----*  选中按钮
/**
 *  选中按钮
 */
- (void)setSelectedButton:(UIButton *)selectedButton
{
    self.selectedButton.selected = NO;
    selectedButton.selected = YES;
    _selectedButton = selectedButton;
    self.dividerView.centerX = selectedButton.centerX;
    self.selectedIndex = selectedButton.tag;
}

- (void)clickOnShare
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsShare)]) {
        [self.delegate clickOnGoodsShare];
    }
}

@end
