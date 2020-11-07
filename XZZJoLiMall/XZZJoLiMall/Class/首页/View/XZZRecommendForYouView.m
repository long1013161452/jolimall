//
//  XZZRecommendForYouView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZRecommendForYouView.h"

#import "XZZCountdownGoodsView.h"

#define goods_count 3

@interface XZZRecommendForYouView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * goodsViewArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong) UIView * dividerView;
@end

@implementation XZZRecommendForYouView

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.goodsViewArray = @[].mutableCopy;
    
    CGFloat interval = 8;
    
    XZZHomeTemplate * homeTemplate = [self.homeTemplateArray firstObject];

    
    UILabel * nameLabel = [UILabel allocInitWithFrame:CGRectMake(interval, 0, 200, 45)];
    nameLabel.textColor = Selling_price_color;
    nameLabel.font = textFont(15);
    nameLabel.text = homeTemplate.name;
    [self addSubview:nameLabel];
//    [nameLabel sizeToFit];

    /**
     *  创建所有的按钮
     */
    UIButton * allButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 80, 0, 80, nameLabel.height)];
    [allButton setTitle:@"View All >" forState:(UIControlStateNormal)];
    [allButton setTitle:@"View All >" forState:(UIControlStateHighlighted)];
    [allButton addTarget:self action:@selector(clickOnViewAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [allButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
    allButton.titleLabel.font = textFont(11);
    [self addSubview:allButton];
    
    
    
    CGFloat goodsWidth = (ScreenWidth - (goods_count + 1) * interval) / goods_count;
    CGFloat goodsHeight = [XZZCountdownGoodsView getHeight:goodsWidth];
    CGFloat left = interval;
    CGFloat top = nameLabel.bottom;
    
    int count = 0;
    for (int i = 0; i < homeTemplate.showNum; i++) {
        if (i > 0 && i % 3 == 0) {
            left = interval;
            top += (goodsHeight + interval);
        }
        

            XZZCountdownGoodsView * goodsView = [XZZCountdownGoodsView allocInitWithFrame:CGRectMake(left, top, goodsWidth, goodsHeight)];
            goodsView.tag = count;
            [goodsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnGoodsTap:)]];
        [self addSubview:goodsView];
        self.height = goodsView.bottom;
            left = goodsView.right + interval;
            [self.goodsViewArray addObject:goodsView];
            count++;
    }
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.height + 15, ScreenWidth, home_Template_interval)];
//    dividerView.backgroundColor = BACK_COLOR;
    dividerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dividerView];
    self.dividerView = dividerView;
    self.height = dividerView.bottom;
    
}
#pragma mark ----*  点击所有
/**
 *  点击所有
 */
- (void)clickOnViewAll:(UIButton *)button
{
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


- (NSMutableArray *)goodsViewArray
{
    if (!_goodsViewArray) {
        self.goodsViewArray = [NSMutableArray array];
    }
    return _goodsViewArray;
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    if (goodsArray.count) {
        [self addViewTwo];
    }else{
        self.height = 0;
    }
}

- (void)addViewTwo
{
    CGFloat bottom = 0;
    for (int i = 0; i < self.goodsViewArray.count; i++) {
        XZZCountdownGoodsView * goodsView = self.goodsViewArray[i];
        if (i < self.goodsArray.count) {
            goodsView.goods = self.goodsArray[i];
            bottom = goodsView.bottom;
            goodsView.hidden = NO;
            goodsView.userInteractionEnabled = YES;
            if (!goodsView.superview) {
                [self addSubview:goodsView];
            }
        }else{
            [goodsView removeFromSuperview];
            goodsView.hidden = YES;
            goodsView.userInteractionEnabled = NO;
        }
    }
    self.dividerView.top = bottom;
    self.height = self.dividerView.bottom;
}

@end
