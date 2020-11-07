//
//  XZZAddCartAndBuyNewButtonView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/27.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddCartAndBuyNewButtonView.h"

@implementation XZZAddCartAndBuyNewButtonView


+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZAddCartAndBuyNewButtonView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    self.backgroundColor = [UIColor whiteColor];
    CGFloat buttonBottom = (StatusRect.size.height > 20 ? bottomHeight : 0) + 5;
    
//    self.cartButton = [UIButton allocInitWithImageName:@"list_nav_cart" selectedImageName:@"list_nav_cart"];
//    self.cartButton.frame = CGRectMake(0, 0, 60, 50);
//    [self.cartButton setTitle:@"Cart" forState:(UIControlStateNormal)];
//    [self.cartButton setTitleColor:kColor(0x505050) forState:(UIControlStateNormal)];
//    self.cartButton.titleLabel.font = textFont(11);
//    [self.cartButton addTarget:self action:@selector(clickOnCart) forControlEvents:(UIControlEventTouchUpInside)];
//    [self initButton:self.cartButton];
//    [self addSubview:self.cartButton];
//    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(wSelf);
//        make.bottom.equalTo(wSelf).offset(-buttonBottom);
//        make.height.equalTo(@50);
//        make.width.equalTo(@60);
//    }];
    
//    self.cartNumLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:button_back_color textColor:kColor(0xffffff) textFont:8 textAlignment:(NSTextAlignmentCenter) tag:1];
//    self.cartNumLabel.layer.cornerRadius = 8;
//    self.cartNumLabel.layer.masksToBounds = YES;
//    [self addSubview:self.cartNumLabel];
//    self.cartNumLabel.hidden = YES;
//    [self.cartNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.equalTo(@16);
//        make.right.equalTo(wSelf.cartButton).offset(-10);
//        make.top.equalTo(wSelf).offset(7);
//    }];
    
    self.addToCartButton = [UIButton allocInitWithTitle:@"Add To Cart" color:button_back_color selectedTitle:@"Add To Cart" selectedColor:button_back_color font:19];
    self.addToCartButton.titleLabel.font = textFont_bold(19);
    [self.addToCartButton addTarget:self action:@selector(clickOnAddToCart) forControlEvents:(UIControlEventTouchUpInside)];
    self.addToCartButton.layer.borderWidth = 1;
    self.addToCartButton.layer.borderColor = button_back_color.CGColor;
    self.addToCartButton.layer.cornerRadius = 45 / 2.0;
    self.addToCartButton.layer.masksToBounds = YES;
    [self addSubview:self.addToCartButton];
    [self.addToCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@5);
        make.height.equalTo(@45);
        make.bottom.equalTo(wSelf).offset(-buttonBottom);
    }];
    
    self.buyNewButton = [UIButton allocInitWithTitle:@"Buy Now" color:kColor(0xffffff) selectedTitle:@"Buy Now" selectedColor:kColor(0xffffff) font:19];
    self.buyNewButton.titleLabel.font = textFont_bold(19);
    self.buyNewButton.layer.cornerRadius = 45 / 2.0;
    self.buyNewButton.layer.masksToBounds = YES;
    self.buyNewButton.backgroundColor = button_back_color;
    [self.buyNewButton addTarget:self action:@selector(clickOnBuyNewButton) forControlEvents:(UIControlEventTouchUpInside)];

    [self addSubview:self.buyNewButton];
    [self.buyNewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.addToCartButton.mas_right).offset(16);
        make.top.bottom.equalTo(wSelf.addToCartButton);
        make.right.equalTo(wSelf).offset(-16);
        make.width.equalTo(wSelf.addToCartButton);
    }];
    
    return;
    self.addToCartTwoButton = [UIButton allocInitWithTitle:@"Add To Cart" color:kColor(0xffffff) selectedTitle:@"Add To Cart" selectedColor:kColor(0xffffff) font:19];
    self.addToCartTwoButton.backgroundColor = kColor(0xFF8A00);
    [self.addToCartTwoButton addTarget:self action:@selector(clickOnAddToCart) forControlEvents:(UIControlEventTouchUpInside)];

    [self addSubview:self.addToCartTwoButton];
    [self.addToCartTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.bottom.equalTo(wSelf.cartButton);
    }];
    
    self.buyNewTwoButton = [UIButton allocInitWithTitle:@"Buy Now" color:kColor(0xffffff) selectedTitle:@"Buy Now" selectedColor:kColor(0xffffff) font:19];
    self.buyNewTwoButton.backgroundColor = button_back_color;
    [self.buyNewTwoButton addTarget:self action:@selector(clickOnBuyNewButton) forControlEvents:(UIControlEventTouchUpInside)];

    [self addSubview:self.buyNewTwoButton];
    [self.buyNewTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.bottom.equalTo(wSelf.cartButton);
    }];
    
}

- (void)clickOnBuyNewButton
{
    !self.buyNew?:self.buyNew();
}

- (void)clickOnAddToCart
{
    !self.addToCart?:self.addToCart();
}

- (void)clickOnCart
{
    !self.goShopingCart?:self.goShopingCart();
}






- (void)setButtonType:(XZZAddCartAndBuyNewButtonType)buttonType
{
    self.addToCartTwoButton.hidden = YES;
    self.buyNewTwoButton.hidden = YES;
    
    switch (buttonType) {
        case XZZAddCartAndBuyNewButtonTypeNone:{
            
        }
            break;
        case XZZAddCartAndBuyNewButtonTypeAddToCart:{
            self.addToCartTwoButton.hidden = NO;
        }
            break;
        case XZZAddCartAndBuyNewButtonTypeBuyNow:{
            self.buyNewTwoButton.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

/**
 *  加购和购买  用于修改y按钮颜色
 */
- (void)whetherCanAddShoppingCartAndBuy:(BOOL)is
{
    if (is) {
        self.addToCartButton.backgroundColor = kColor(0xffffff);
        self.addToCartTwoButton.backgroundColor = kColor(0xffffff);
        self.buyNewButton.backgroundColor = button_back_color;
        self.buyNewTwoButton.backgroundColor = button_back_color;
    }else{
        self.addToCartButton.backgroundColor = kColor(0xc4c4c4);
        self.addToCartTwoButton.backgroundColor = kColor(0xc4c4c4);
        self.buyNewButton.backgroundColor = kColor(0x989898);
        self.buyNewTwoButton.backgroundColor = kColor(0x989898);
    }
}


#pragma mark ----    设置按钮上图下文的编辑
-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height + 3 ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}


@end
