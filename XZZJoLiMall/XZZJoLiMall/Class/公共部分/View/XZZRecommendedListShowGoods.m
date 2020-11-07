//
//  XZZRecommendedListShowGoods.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/16.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZRecommendedListShowGoods.h"

@interface XZZRecommendedListShowGoods ()


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


@end

@implementation XZZRecommendedListShowGoods


/**
 *  创建视图信息
 */
- (void)creatingViewInfor
{
    WS(wSelf)
    /***  t商品图片 */
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    self.imageView = imageView;
//    imageView.layer.cornerRadius = 5;
//    imageView.layer.masksToBounds = YES;
    [self addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.width.equalTo(wSelf.imageView.mas_height).multipliedBy(image_width_height_proportion);
    }];
    


    
    self.soldOutLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColorWithRGB(0, 00, 0, 1) textColor:kColor(0xffffff) textFont:11 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.soldOutLabel.text = @"Sold out";
    [self.soldOutLabel cutRounded:10];
    [self addSubview:self.soldOutLabel];
    [self.soldOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf.imageView);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    UIView * backView = [UIView allocInit];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf);
        make.bottom.equalTo(wSelf);
        make.top.equalTo(wSelf.imageView.mas_bottom);
    }];
    weakView(weak_backView, backView)
    /***  价格 */
    UILabel * priceLabel = [UILabel allocInit];
    priceLabel.textColor = Selling_price_color;
    priceLabel.font = Selling_price_font;
    self.priceLabel = priceLabel;
    [backView addSubview:priceLabel];

    /***  虚价 */
    UILabel * nominalPriceLabel = [UILabel allocInit];
    nominalPriceLabel.textColor = original_price_color;
    nominalPriceLabel.font = original_price_font;
    self.nominalPriceLabel = nominalPriceLabel;
    [self addSubview:nominalPriceLabel];
    if (ScreenWidth > 376) {
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weak_backView);
            make.height.equalTo(@(price_height));
            make.top.equalTo(wSelf.imageView.mas_bottom);
            make.bottom.equalTo(wSelf);
        }];
        
        [nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.priceLabel.mas_right).offset(5);
            make.centerY.equalTo(wSelf.priceLabel).offset(1);
            make.right.equalTo(weak_backView);
        }];
    }else{
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf);
            make.height.equalTo(@(price_height_Two));
            make.top.equalTo(wSelf.imageView.mas_bottom);
        }];
        
        [nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.priceLabel);
            make.height.equalTo(@(original_price_height));
            make.bottom.equalTo(wSelf).offset(-5);
        }];
    }

    /***  中划线 */
    UIView * inLineView = [UIView allocInit];
    inLineView.backgroundColor = nominalPriceLabel.textColor;
    [nominalPriceLabel addSubview:inLineView];
    [inLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.centerX.equalTo(wSelf.nominalPriceLabel);
        make.height.equalTo(@(divider_view_width));
    }];
    
    /***  收藏按钮 */
    UIButton * collectionButton = [UIButton allocInitWithImageName:@"list_no_collected" selectedImageName:@"list_already_collected"];
    [collectionButton addTarget:self action:@selector(collectGoods) forControlEvents:(UIControlEventTouchUpInside)];
    self.collectionButton = collectionButton;
    [self addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wSelf);
        make.height.width.equalTo(@(collection_Button_Width));
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
        //    /***  折扣背景图片约束 */
            [_discountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(wSelf);
                make.width.equalTo(@21);
                make.height.equalTo(@24);
            }];
    }
    return _discountImageView;
}

- (UILabel *)discountLabel
{
    if (!_discountLabel) {
        WS(wSelf)
        self.discountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xbc24c3) textFont:7 textAlignment:(NSTextAlignmentCenter) tag:1];
        _discountLabel.numberOfLines = 2;
        _discountLabel.font = textFont_bold(7);
        [self.discountImageView addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(wSelf.discountImageView);
        }];
    }
    return _discountLabel;
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
        if (goodsList.cornerMark) {
            self.discountImageView.hidden = NO;
            self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
        }else{
            self.discountImageView.hidden = YES;
        }
        if (goodsList.discountPercent == 0) {
            priceText = [NSString stringWithFormat:@"$%.2f", goodsList.currentPrice];
        }else{
            priceText = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice];
        }
        self.soldOutLabel.hidden = goodsList.status.boolValue;
    }
    
    [self.imageView addImageFromUrlStr:imageUrl];
    self.priceLabel.text = priceText;
    self.nominalPriceLabel.text = nominalPrice;
    
    [self.priceLabel sizeToFit];
    self.priceLabel.height = price_height;
    [self.nominalPriceLabel sizeToFit];
    
    
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
