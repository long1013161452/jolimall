//
//  XZZActivitiesGoodsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZActivitiesGoodsView.h"



@interface XZZActivitiesGoodsView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView
;

@end

#define activity_Commodity_width (ScreenWidth / 4.1)

@implementation XZZActivitiesGoodsView

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    if (goodsArray.count) {
        [self addViewTwo];
    }else{
        self.height = 0;
    }
}


- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat goodsWidth = activity_Commodity_width;
    CGFloat goodsHeight = goodsWidth * image_height_width_proportion + price_height;
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 3, ScreenWidth, goodsHeight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    self.height = scrollView.bottom;

}



- (void)addViewTwo{
    CGFloat goodsWidth = activity_Commodity_width;
    CGFloat goodsHeight = self.scrollView.height;
    
    CGFloat spacing = 10;
    CGFloat left = goodsList_goods_interval;
    int i = 0;
    for (id goods in self.goodsArray) {
        XZZAdvertisingGoodsView * goodsView = [XZZAdvertisingGoodsView allocInitWithFrame:CGRectMake(left, 0, goodsWidth, goodsHeight)];
        goodsView.goods = goods;
        [goodsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnGoodsTap:)]];
        goodsView.tag = i;
        [self.scrollView addSubview:goodsView];
        left += (goodsWidth + spacing);
        i++;
    }
    
    /**
     *  创建所有的按钮
     */
    UIButton * allButtonTwo = [UIButton allocInitWithFrame:CGRectMake(left, 0, goodsWidth, goodsWidth * 4 / 3)];
    [allButtonTwo setImage:imageName(@"home_all_activity") forState:(UIControlStateNormal)];
    [allButtonTwo setImage:imageName(@"home_all_activity") forState:(UIControlStateHighlighted)];
    [allButtonTwo addTarget:self action:@selector(clickOnViewAll) forControlEvents:(UIControlEventTouchUpInside)];
    [allButtonTwo setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    allButtonTwo.titleLabel.font = textFont(11);
    [self.scrollView addSubview:allButtonTwo];
    
    self.scrollView.contentSize = CGSizeMake(allButtonTwo.right + goodsList_goods_interval, 0);
}

#pragma mark ----查看所有活动信息
/**
 *  查看所有活动信息
 */
- (void)clickOnViewAll
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:[self.homeTemplateArray firstObject]];
    }
    
}

#pragma mark ----*  点击商品
/**
 *  点击商品
 */
- (void)clickOnGoodsTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsAccordingId:state:)]) {
        NSLog(@"%s %d 行 点击了商品  ", __func__, __LINE__);
        
        id goods = self.goodsArray[tap.view.tag];
        NSString * goodsId = @"";
        BOOL state = false ;
        if ([goods isKindOfClass:[XZZGoodsList class]]) {
            XZZGoodsList * goodsList = goods;
            goodsId = goodsList.goodsId;
            state = YES;
        }
        [self.delegate clickOnGoodsAccordingId:goodsId state:state];
    }
}

@end

@interface XZZAdvertisingGoodsView ()

/**
 * 商品图片
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;

/**
 * 价格
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * 折扣背景
 */
@property (nonatomic, strong)UIImageView * discountImageView;

/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;


@end

@implementation XZZAdvertisingGoodsView

- (void)setGoods:(id)goods
{
    _goods = goods;
    [self addView];
    if ([goods isKindOfClass:[XZZGoodsList class]]) {
        XZZGoodsList * goodsList = goods;
        if (goodsList.cornerMark) {
            self.discountImageView.hidden = NO;
            self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
        }else{
            self.discountImageView.hidden = YES;
        }
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice > 0 ? goodsList.discountPrice : goodsList.currentPrice];
        [self.goodsImageView addImageFromUrlStr:goodsList.pictureUrl];
    }
}

- (void)addView{
    WS(wSelf)
    self.goodsImageView = [FLAnimatedImageView allocInit];
    self.goodsImageView.layer.cornerRadius = 5;
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.goodsImageView cutRounded:4];
    self.goodsImageView.clipsToBounds = YES;
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(wSelf.goodsImageView.mas_width).multipliedBy(image_height_width_proportion);
    }];
    
    self.priceLabel = [UILabel allocInit];
    self.priceLabel.font = Selling_price_font;
    self.priceLabel.textColor = Selling_price_color;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf.goodsImageView.mas_bottom);
        make.height.equalTo(@(20));
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
        _discountLabel.textColor = kColor(0xffffff);
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
