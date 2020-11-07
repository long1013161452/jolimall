//
//  XZZCartCheckOutButtonView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCartCheckOutButtonView.h"

@implementation XZZCartCheckOutButtonView

+ (instancetype)allocInit
{
    XZZCartCheckOutButtonView * view = [super allocInit];
    [view addViewNew];
    return view;
}

- (void)addViewNew
{
//    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    
    self.selectAllButton = [UIButton allocInitWithTitle:@"   All" color:kColor(0x999999) selectedTitle:@"   All" selectedColor:kColor(0x999999) font:14];
    [self.selectAllButton setImage:imageName(@"cart_goods_no_selected") forState:(UIControlStateNormal)];
    [self.selectAllButton setImage:imageName(@"cart_goods_selected") forState:(UIControlStateSelected)];
    [self.selectAllButton addTarget:self action:@selector(clickOnSelectAllButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.selectAllButton];
    [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wSelf);
        make.width.equalTo(@60);
    }];
    
    UIButton * checkOutButton = [UIButton allocInitWithTitle:@"Check Out" color:kColor(0xffffff) selectedTitle:@"Check Out" selectedColor:kColor(0xffffff) font:18];
    checkOutButton.backgroundColor = button_back_color;
    checkOutButton.layer.cornerRadius = 20;
//    checkOutButton.layer.masksToBounds = YES;
    checkOutButton.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:68/255.0 alpha:0.2].CGColor;
    checkOutButton.layer.shadowOffset = CGSizeMake(0,8);
    checkOutButton.layer.shadowOpacity = 1;
    checkOutButton.layer.shadowRadius = 8;
    [checkOutButton addTarget:self action:@selector(clickOnCheckOutButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:checkOutButton];
    CGFloat right = ScreenWidth > 320 ? -90 : -75;
    [checkOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.right.equalTo(wSelf).offset(right);
        make.height.equalTo(@40);
        make.width.equalTo(@120);
        make.centerY.equalTo(wSelf.selectAllButton);
    }];
    
    weakView(weak_checkOutButton, checkOutButton)
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.priceLabel.font = Selling_price_font;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.selectAllButton.mas_right);
        make.centerY.equalTo(weak_checkOutButton);
    }];
    
    
}


- (void)addView{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    
    self.selectAllButton = [UIButton allocInitWithTitle:@"  Select All" color:kColor(0x000000) selectedTitle:@"  Select All" selectedColor:kColor(0x000000) font:12];
    [self.selectAllButton setImage:imageName(@"cart_goods_no_selected") forState:(UIControlStateNormal)];
    [self.selectAllButton setImage:imageName(@"cart_goods_selected") forState:(UIControlStateSelected)];
    [self.selectAllButton addTarget:self action:@selector(clickOnSelectAllButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.selectAllButton];
    [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wSelf);
        make.width.equalTo(@90);
    }];
    
    UIButton * checkOutButton = [UIButton allocInitWithTitle:@"Check Out" color:kColor(0xffffff) selectedTitle:@"Check Out" selectedColor:kColor(0xffffff) font:18];
    checkOutButton.backgroundColor = button_back_color;
    [checkOutButton addTarget:self action:@selector(clickOnCheckOutButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:checkOutButton];
    [checkOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(wSelf);
        make.height.equalTo(@45);
        make.left.equalTo(wSelf.mas_centerX).offset(40);
        make.bottom.equalTo(wSelf.selectAllButton);
    }];
    
    weakView(weak_checkOutButton, checkOutButton)
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:button_back_color textFont:14 textAlignment:(NSTextAlignmentRight) tag:1];
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_checkOutButton.mas_left).offset(-10);
        make.centerY.equalTo(weak_checkOutButton);
    }];
    
    
}

- (void)clickOnSelectAllButton:(UIButton *)button{
    !self.selectAll?:self.selectAll();
}

- (void)clickOnCheckOutButton:(UIButton *)button{
    !self.checkOnt?:self.checkOnt();
}

@end
