//
//  XZZCouponsRecommendedGoodsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/12.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponsRecommendedGoodsView.h"

@implementation XZZCouponsRecommendedGoodsView

- (void)setGoodsList:(NSArray *)goodsList
{
    _goodsList = goodsList;
    [self addView];
}

- (void)clickOutTitle
{
    !self.checkCoupons?:self.checkCoupons();
}

- (void)addView{
    
    [self removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(10, 0, ScreenWidth, 50) backColor:nil textColor:kColor(0x191919) textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.font = textFont_bold(16);
    titleLabel.text = @"Frequently Bought Together";
    titleLabel.userInteractionEnabled = YES;
    [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOutTitle)]];
    [self addSubview:titleLabel];
    
    weakView(weak_titleLabel, titleLabel)
    UIImageView * arrowImageView = [UIImageView allocInit];
    arrowImageView.image = imageName(@"address_arrow");
    [self addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_titleLabel);
        make.right.equalTo(wSelf).offset(-16);
    }];
    
    UIView * leftView = nil;
    CGFloat width = (ScreenWidth - goodsList_goods_interval * 4.0) / 3.0;
    CGFloat goodsHeight = [XZZGoodsListCell calculateCellHeight:3];
    for (int i = 0; i < 3; i++) {
        if (i < self.goodsList.count) {
            
            weakView(weak_leftView, leftView)
            XZZListShowGoodsView * goodsView = [XZZListShowGoodsView allocInitWithFrame:CGRectMake(goodsList_goods_interval + leftView.right, titleLabel.bottom, width, goodsHeight)];
            goodsView.delegate = self.delegate;
            goodsView.cartSmall = 3 > 2;
            goodsView.goodsViewDisplay = XZZGoodsViewDisplayRecommendedGoodsList;
            [self addSubview:goodsView];
            goodsView.goods = self.goodsList[i];
            goodsView.collectionHidden = YES;
//            [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(weak_titleLabel.mas_bottom);
//                make.width.equalTo(@(width));
//                if (weak_leftView) {
//                    make.left.equalTo(weak_leftView.mas_right).offset(goodsList_goods_interval);
//                }else{
//                    make.left.equalTo(@(goodsList_goods_interval));
//                }
//            }];
            leftView = goodsView;
            
        }
    }
    weakView(weak_leftView, leftView)
    UILabel * promptLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:button_back_color textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    promptLabel.text = self.prompt;
    [self addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_titleLabel);
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@30);
        make.top.equalTo(weak_leftView.mas_bottom).offset(10);
    }];
    
    weakView(weak_promptLabel, promptLabel)
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_promptLabel.mas_bottom).offset(10);
        make.height.equalTo(@8);
    }];
    
    self.height = titleLabel.bottom + goodsHeight + 10 + 30 + 10 + 8;
}

@end
