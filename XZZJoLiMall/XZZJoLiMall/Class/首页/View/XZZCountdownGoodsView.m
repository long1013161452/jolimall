//
//  XZZCountdownGoodsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCountdownGoodsView.h"

#import "XZZSecondsKillGoods.h"


@interface XZZCountdownGoodsView ()

/**
 * 商品图片
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;



/**
 * 虚价
 */
@property (nonatomic, strong)UILabel * nominalPriceLabel;


/**
 * 折扣背景
 */
@property (nonatomic, strong)UIImageView * discountImageView;

/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;



@end
/**
 *  价格高度
 */
#define price_label_height 20

@implementation XZZCountdownGoodsView

/**
 *  计算高度信息
 */
+ (CGFloat)getHeight:(CGFloat)width
{
    CGFloat imageHeight = width * image_height_width_proportion;
    return imageHeight + price_label_height * 2;
}

+ (CGFloat)getWidth:(CGFloat)height
{
    CGFloat imageHeight = height - price_label_height * 2;
    return imageHeight / image_height_width_proportion;
}

- (void)setGoods:(id)goods
{
    _goods = goods;
    if (!self.goodsImageView) {
        [self addViewTwo];
    }
    
    if ([goods isKindOfClass:[XZZGoodsList class]]) {
        XZZGoodsList * goodsList = goods;
        [self.goodsImageView addImageFromUrlStr:goodsList.pictureUrl];
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice > 0 ? goodsList.discountPrice : goodsList.currentPrice];
        if (goodsList.nominalPrice > 0) {
            self.nominalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.nominalPrice];
        }else{
            self.nominalPriceLabel.text = @"";
        }
        
        if (goodsList.cornerMark) {
            self.discountImageView.hidden = NO;
            self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
        }else{
            self.discountImageView.hidden = YES;
        }
        
    }else if ([goods isKindOfClass:[XZZSecondsKillGoods class]]){
        XZZSecondsKillGoods * goodsList = goods;
        [self.goodsImageView addImageFromUrlStr:goodsList.pictureUrl];
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.salePrice];
        if (goodsList.currentPrice > 0) {
            self.nominalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.currentPrice];
        }else{
            self.nominalPriceLabel.text = @"";
        }
            self.discountImageView.hidden = YES;
    }
    
}

- (void)addViewTwo{
    WS(wSelf)
    self.goodsImageView = [FLAnimatedImageView allocInit];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsImageView.clipsToBounds = YES;
    [self.goodsImageView cutRounded:4];
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(wSelf.goodsImageView.mas_width).multipliedBy(image_height_width_proportion);
    }];
    
    self.priceLabel = [UILabel allocInit];
    self.priceLabel.font = Selling_price_font;
    self.priceLabel.textColor = Selling_price_color;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf.goodsImageView.mas_bottom).offset(5);
        make.height.equalTo(@(15));
    }];
    
    self.nominalPriceLabel = [UILabel allocInit];
    self.nominalPriceLabel.font = original_price_font;
    self.nominalPriceLabel.textColor = original_price_color;
    [self addSubview:self.nominalPriceLabel];
    [self.nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(wSelf.priceLabel);
        make.top.equalTo(wSelf.priceLabel.mas_bottom);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = original_price_color;
    [self.nominalPriceLabel addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.centerY.equalTo(wSelf.nominalPriceLabel);
        make.height.equalTo(@1);
    }];
    
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
            make.left.equalTo(@5);
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
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.numberOfLines = 2;
        _discountLabel.font = textFont_bold(7);
        [self.discountImageView addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(wSelf.discountImageView);
        }];
    }
    return _discountLabel;
}

@end


/**
 * 秒杀
 */
@interface XZZSecKillGoodsView ()

/**
 * 商品图片
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;



/**
 * 虚价
 */
@property (nonatomic, strong)UILabel * nominalPriceLabel;


/**
 * 折扣背景
 */
@property (nonatomic, strong)UIImageView * discountImageView;

/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;



@end
/**
 *  价格高度
 */
#define price_label_height_two 35

@implementation XZZSecKillGoodsView

/**
 *  计算高度信息
 */
+ (CGFloat)getHeight:(CGFloat)width
{
    CGFloat imageHeight = width * image_height_width_proportion;
    return imageHeight + price_label_height_two;
}

+ (CGFloat)getWidth:(CGFloat)height
{
    CGFloat imageHeight = height - price_label_height_two;
    return imageHeight / image_height_width_proportion;
}

- (void)setGoods:(id)goods
{
    _goods = goods;
    if (!self.goodsImageView) {
        [self addViewTwo];
    }
    
    if ([goods isKindOfClass:[XZZGoodsList class]]) {
        XZZGoodsList * goodsList = goods;
        [self.goodsImageView addImageFromUrlStr:goodsList.pictureUrl];
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice > 0 ? goodsList.discountPrice : goodsList.currentPrice];
        if (goodsList.nominalPrice > 0) {
            self.nominalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.nominalPrice];
        }else{
            self.nominalPriceLabel.text = @"";
        }
        
        if (goodsList.cornerMark) {
            self.discountImageView.hidden = NO;
            self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
        }else{
            self.discountImageView.hidden = YES;
        }
        
    }else if ([goods isKindOfClass:[XZZSecondsKillGoods class]]){
        XZZSecondsKillGoods * goodsList = goods;
        [self.goodsImageView addImageFromUrlStr:goodsList.pictureUrl];
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.salePrice];
        if (goodsList.currentPrice > 0) {
            self.nominalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.currentPrice];
        }else{
            self.nominalPriceLabel.text = @"";
        }
        self.discountImageView.hidden = YES;
    }
    
}

- (void)addViewTwo{
    WS(wSelf)
    self.goodsImageView = [FLAnimatedImageView allocInit];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsImageView.clipsToBounds = YES;
    [self.goodsImageView cutRounded:4];
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(wSelf.goodsImageView.mas_width).multipliedBy(image_height_width_proportion);
    }];
    
    self.priceLabel = [UILabel allocInit];
    self.priceLabel.font = Selling_price_font;
    self.priceLabel.textColor = button_back_color;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf);
        make.top.equalTo(wSelf.goodsImageView.mas_bottom);
        make.height.equalTo(@(price_label_height_two));
    }];
    
    self.nominalPriceLabel = [UILabel allocInit];
    self.nominalPriceLabel.font = original_price_font;
    self.nominalPriceLabel.textColor = original_price_color;
    [self addSubview:self.nominalPriceLabel];
    [self.nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.priceLabel.mas_right).offset(4);
        make.height.equalTo(wSelf.priceLabel);
        make.top.equalTo(wSelf.priceLabel);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = original_price_color;
    [self.nominalPriceLabel addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.centerY.equalTo(wSelf.nominalPriceLabel);
        make.height.equalTo(@1);
    }];
    
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
            make.left.equalTo(@5);
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
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.numberOfLines = 2;
        _discountLabel.font = textFont_bold(7);
        [self.discountImageView addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(wSelf.discountImageView);
        }];
    }
    return _discountLabel;
}

@end




