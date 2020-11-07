//
//  XZZGoodsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/8.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZListShowGoodsView.h"



@interface XZZListShowGoodsView ()

/**
 * 商品图片
 */
@property (nonatomic, strong)FLAnimatedImageView * imageView;
/**
 * 折扣背景
 */
@property (nonatomic, strong)UIImageView * discountImageView;

/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;
/**
 * 折扣背景 活动
 */
@property (nonatomic, strong)UIImageView * activityDiscountImageView;

/**
 * 折扣 活动
 */
@property (nonatomic, strong)UILabel * activityDiscountLabel;
/**
 * 活动背景
 */
@property (nonatomic, strong)UIImageView * activityImageView;
/**
 * 活动icon背景
 */
@property (nonatomic, strong)UIImageView * activityIconImageView;
/**
 * 活动短标题
 */
@property (nonatomic, strong)UILabel * activityLabel;

/**
 * 价格
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * 虚价
 */
@property (nonatomic, strong)UILabel * nominalPriceLabel;

/**
 * 收藏按钮
 */
@property (nonatomic, strong)UIButton * collectionButton;

/**
 * 购物车
 */
@property (nonatomic, strong)UIButton *  shoppingCartButton;

/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;

/**
 * 下架
 */
@property (nonatomic, strong)UILabel * soldOutLabel;
/**
 * 图片b蒙版
 */
@property (nonatomic, strong)UIView * backImageView;

@end

@implementation XZZListShowGoodsView
#pragma mark ---- 创建视图信息
/**
 *  创建视图信息
 */
- (void)creatingViewInfor
{
    
    self.clipsToBounds = YES;
    
    WS(wSelf)
    /***  t商品图片 */
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    self.imageView = imageView;
    [self addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 4;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.width.equalTo(wSelf.imageView.mas_height).multipliedBy(image_width_height_proportion);
    }];
    

    /***  给收藏按钮加约束 */
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wSelf.imageView);
        make.width.height.equalTo(@50);
    }];
    
    self.backImageView = [UIView allocInit];
    self.backImageView.backgroundColor = kColorWithRGB(255, 255, 255, .5);
    [self addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.top.equalTo(wSelf.imageView);
    }];
    
    self.soldOutLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColorWithRGB(0, 00, 0, .1) textColor:other_Color_FFFFFF textFont:11 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.soldOutLabel.text = @"Sold out";
    self.soldOutLabel.font = font_bold_14;
//    [self.soldOutLabel cutRounded:10];
    [self addSubview:self.soldOutLabel];
    [self.soldOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.top.equalTo(wSelf.imageView);
//        make.height.equalTo(@20);
//        make.width.equalTo(@60);
    }];
    
    /***  价格 */
    UILabel * priceLabel = [UILabel allocInit];
    priceLabel.textColor = important_Color_191919;
    priceLabel.font = font_bold_14;
    self.priceLabel = priceLabel;
    [self addSubview:priceLabel];

    /***  虚价 */
    UILabel * nominalPriceLabel = [UILabel allocInit];
    nominalPriceLabel.textColor = general_Color_999999;
    nominalPriceLabel.font = font_12;
    self.nominalPriceLabel = nominalPriceLabel;
    [self addSubview:nominalPriceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.height.equalTo(@(price_height_Two));
        make.top.equalTo(wSelf.imageView.mas_bottom);
    }];
    
    [nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.priceLabel);
        make.bottom.equalTo(wSelf).offset(-5);
    }];

    /***  中划线 */
    UIView * inLineView = [UIView allocInit];
    inLineView.backgroundColor = nominalPriceLabel.textColor;
    [nominalPriceLabel addSubview:inLineView];
    [inLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.centerX.equalTo(wSelf.nominalPriceLabel);
        make.height.equalTo(@(1));
    }];
    /***  收藏按钮 */
    UIButton * collectionButton = [UIButton allocInitWithImageName:@"list_no_collected" selectedImageName:@"list_already_collected"];
    [collectionButton addTarget:self action:@selector(collectGoods) forControlEvents:(UIControlEventTouchUpInside)];
    self.collectionButton = collectionButton;
    [self addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(wSelf);
        make.height.width.equalTo(@(collection_Button_Width));
    }];
    /***  购物车按钮 */
    UIButton * shoppingCartButton = [UIButton allocInitWithImageName:@"home_cart" selectedImageName:@"home_cart"];
    [shoppingCartButton addTarget:self action:@selector(clickShoppingCart) forControlEvents:(UIControlEventTouchUpInside)];
    self.shoppingCartButton = shoppingCartButton;
    [self addSubview:shoppingCartButton];
    [shoppingCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.equalTo(wSelf);
//        make.top.equalTo(wSelf.priceLabel);
//        make.width.equalTo(wSelf.shoppingCartButton.mas_height);
        
        make.centerY.equalTo(wSelf.imageView.mas_bottom);
        if (wSelf.cartSmall) {
            make.right.equalTo(wSelf.imageView).offset(-3);
            make.width.equalTo(@24);
            make.height.equalTo(@25);
        }else{
            make.right.equalTo(wSelf.imageView).offset(-6);
        make.width.equalTo(@36);
        make.height.equalTo(@37);
        }
    }];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoods)]];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (UIImageView *)discountImageView
{
    if (!_discountImageView) {
        WS(wSelf)
        self.discountImageView = [UIImageView allocInit];
        _discountImageView.image = imageName(@"home_discount_No_rounded_corners");
        [self addSubview:_discountImageView];
        /***  折扣背景图片约束 */
        [_discountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf);
            make.left.equalTo(wSelf.imageView).offset(6);
            make.width.equalTo(@28);
            make.height.equalTo(@28);
        }];
    }
    return _discountImageView;
}

- (UILabel *)discountLabel
{
    if (!_discountLabel) {
        WS(wSelf)
        self.discountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:other_Color_FFFFFF textFont:7 textAlignment:(NSTextAlignmentCenter) tag:1];
        _discountLabel.numberOfLines = 2;
        _discountLabel.font = font_8;
        [self.discountImageView addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(wSelf.discountImageView);
            make.bottom.equalTo(wSelf.discountImageView).offset(-3);
        }];
    }
    return _discountLabel;
}

- (UIImageView *)activityDiscountImageView
{
    if (!_activityDiscountImageView) {
        WS(wSelf)
        self.activityDiscountImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 16, 38, 28)];
        _activityDiscountImageView.backgroundColor = main_Color_d73e3e_100;//kColor(0xD73E3E);
        [_activityDiscountImageView cutRounded:14];
        [self addSubview:_activityDiscountImageView];
        
        
        /***  折扣背景图片约束 */
        [_activityDiscountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@16);
            make.left.equalTo(wSelf).offset(-14);
            make.width.equalTo(@54);
            make.height.equalTo(@28);
        }];
    }
    return _activityDiscountImageView;
}

- (UILabel *)activityDiscountLabel
{
    if (!_activityDiscountLabel) {
        WS(wSelf)
        self.activityDiscountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:other_Color_FFFFFF textFont:11 textAlignment:(NSTextAlignmentCenter) tag:1];
        _activityDiscountLabel.font = font_10;
        _activityDiscountLabel.numberOfLines = 2;
        [self.activityDiscountImageView addSubview:_activityDiscountLabel];
        [_activityDiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(wSelf.activityDiscountImageView);
            make.left.equalTo(wSelf);
            make.right.equalTo(wSelf.activityDiscountImageView).offset(-2);
        }];
    }
    return _activityDiscountLabel;
}

- (UIImageView *)activityImageView
{
    if (!_activityImageView) {
        WS(wSelf)
        self.activityImageView = [UIImageView allocInit];
        _activityImageView.backgroundColor = main_Color_d73e3e_100;//kColor(0xD73E3E);
        [_activityImageView cutRounded:14];
        [self addSubview:_activityImageView];
        [_activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@16);
            make.right.equalTo(wSelf.imageView).offset(14);
            make.left.greaterThanOrEqualTo(wSelf.mas_centerX);
            make.height.equalTo(@28);
        }];
    }
    return _activityImageView;
}

- (UIImageView *)activityIconImageView
{
    if (!_activityIconImageView) {
        WS(wSelf)
        self.activityIconImageView = [FLAnimatedImageView allocInit];
        [_activityIconImageView cutRounded:10];
        [self.activityImageView addSubview:_activityIconImageView];
        [_activityIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.activityImageView);
            make.left.equalTo(@4);
            make.width.height.equalTo(@20);
        }];
    }
    return _activityIconImageView;
}

- (UILabel *)activityLabel
{
    if (!_activityLabel) {
        WS(wSelf)
        self.activityLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:other_Color_FFFFFF textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
        _activityLabel.font = font_10;
        _activityLabel.numberOfLines = 2;
        [self.activityImageView addSubview:_activityLabel];
        [_activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.activityIconImageView.mas_right).offset(3);
            make.top.bottom.equalTo(wSelf.activityImageView);
            make.right.equalTo(wSelf).offset(-2);
        }];
    }
    return _activityLabel;
}



- (void)setCartHidden:(BOOL)cartHidden
{
    self.shoppingCartButton.hidden = cartHidden;
}

- (void)setCollectionHidden:(BOOL)collectionHidden
{
    self.collectionButton.hidden = collectionHidden;
}

- (void)setGoods:(id)goods
{
    _goods = goods;
    if (goods) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
    if (!self.imageView) {
        [self creatingViewInfor];
    }
    
    NSString * imageUrl = nil;
    NSString * priceText = nil;
    NSString * nominalPrice = nil;
    
    NSLog(@"%@", self);
    /***  下面进行赋值 */
    
    
    if ([goods isKindOfClass:[XZZGoodsList class]]) {
        XZZGoodsList * goodsList = goods;
        self.goodsId = goodsList.goodsId;
        self.collectionButton.selected = StateCollectionGoodsId(goodsList.goodsId);
        priceText = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice > 0 ? goodsList.discountPrice : goodsList.currentPrice];
        if (goodsList.nominalPrice > 0) {
            nominalPrice = [NSString stringWithFormat:@"$%.2f", goodsList.nominalPrice];
        }else{
            nominalPrice = @"";
        }
        imageUrl = goodsList.pictureUrl;
        switch (self.goodsViewDisplay) {
            case XZZGoodsViewDisplayRecommendedGoodsList:{//
                _activityDiscountImageView.hidden = YES;
                _activityImageView.hidden = YES;
                if (goodsList.cornerMark) {
                    self.discountImageView.hidden = NO;
                    self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
                }else{
                    self.discountImageView.hidden = YES;
                }
            }
                break;
            case XZZGoodsViewDisplayGoodsList:{
                NSLog(@"%s %d 行", __func__, __LINE__);
                _activityDiscountImageView.hidden = YES;
                if (goodsList.cornerMark) {
                    self.discountImageView.hidden = NO;
                    self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
                }else{
                    self.discountImageView.hidden = YES;
                }
                
                if (goodsList.activityVo.isShow) {
                    self.activityImageView.hidden = NO;
                    self.activityLabel.text = goodsList.activityVo.shortTitle;
                    if (goodsList.activityVo.iconPictureTwo.length) {
                        [self.activityIconImageView addImageFromUrlStr:goodsList.activityVo.iconPictureTwo];
                    }else{
                        self.activityIconImageView.image = imageName(@"list_sale");
                    }
                }else{
                    self.activityImageView.hidden = YES;
                }
            }
                break;
            case XZZGoodsViewDisplayActivityGoodsList:{
                _activityImageView.hidden = YES;
                _discountImageView.hidden = YES;
                self.activityDiscountImageView.hidden = NO;
                self.activityDiscountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];

            }
                break;
                
            default:
                break;
        }
        
        
        if (goodsList.discountPercent == 0) {
            priceText = [NSString stringWithFormat:@"$%.2f", goodsList.currentPrice];
        }else{
            
            priceText = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice];
        }
        self.soldOutLabel.hidden = goodsList.status.boolValue;
        self.backImageView.hidden = goodsList.status.boolValue;
        NSString * imageName = goodsList.status.boolValue ? @"home_cart" : @"home_cart_Put_ash";
        [self.shoppingCartButton imageName:imageName selectedImageName:imageName];
    }
    
    [self.imageView addImageFromUrlStr:imageUrl];
    self.priceLabel.text = priceText;
    self.nominalPriceLabel.text = nominalPrice;
    
}



- (void)collectGoods
{
    if ([self.delegate respondsToSelector:@selector(collectGoodsAccordingId:)]) {
        [self.delegate collectGoodsAccordingId:self.goodsId];
    }
}

- (void)clickShoppingCart
{
    if ([self.delegate respondsToSelector:@selector(goodsViewShopCartAccordingId:state:)]) {
        [self.delegate goodsViewShopCartAccordingId:self.goodsId state:self.soldOutLabel.hidden];
    }
}

- (void)clickGoods
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsAccordingId:state:)]) {
        [self.delegate clickOnGoodsAccordingId:self.goodsId state:self.soldOutLabel.hidden];
    }
}


@end
