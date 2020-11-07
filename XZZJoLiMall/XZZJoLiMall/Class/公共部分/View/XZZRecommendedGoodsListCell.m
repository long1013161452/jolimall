//
//  XZZRecommendedGoodsTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/16.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZRecommendedGoodsListCell.h"

#import "XZZRecommendedListShowGoods.h"

@interface XZZRecommendedGoodsListCell ()

/**
 * 商品view 数组
 */
@property (nonatomic, strong)NSMutableArray * goodsViewArray;



@end



@implementation XZZRecommendedGoodsListCell

+ (CGFloat)calculateCellHeight:(int)count
{
 
    if (ScreenWidth < 376) {
        CGFloat height = goodsList_goods_interval + (ScreenWidth - goodsList_goods_interval * (count + 1)) / (count * 1.0) * image_height_width_proportion + price_height_Two + 3 + original_price_height + 5;
        return height;
    }
    CGFloat height = goodsList_goods_interval + (ScreenWidth - goodsList_goods_interval * (count + 1)) / (count * 1.0) * image_height_width_proportion + price_height + 0;
    NSLog(@"%f", height);
    
    
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/**
 *  创建视图信息
 */
- (void)creatingViewInfor
{
//    self.backgroundColor = [UIColor whiteColor];
    self.goodsViewArray = @[].mutableCopy;
    CGFloat width = (ScreenWidth - goodsList_goods_interval * (self.count + 1)) / self.count;
    UIView * leftView = nil;
    WS(wSelf)
    for (int i = 0; i < self.count; i++) {
        weakView(WV, leftView)
        XZZRecommendedListShowGoods * goodsView = [XZZRecommendedListShowGoods allocInit];
        goodsView.delegate = self.delegate;
        [self addSubview:goodsView];
        [self.goodsViewArray addObject:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(goodsList_goods_interval));
            make.width.equalTo(@(width));
            make.bottom.equalTo(wSelf);
            if (WV) {
                make.left.equalTo(WV.mas_right).offset(goodsList_goods_interval);
            }else{
                make.left.equalTo(@(goodsList_goods_interval));
            }
        }];
        leftView = goodsView;
    }
}


- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    if (!self.goodsViewArray.count) {
        [self creatingViewInfor];
    }
    NSLog(@"%@", self);
    for (int i = 0; i < self.goodsViewArray.count; i++) {
        XZZRecommendedListShowGoods * goodsView = self.goodsViewArray[i];
        if (i < goodsArray.count) {
            goodsView.goods = goodsArray[i];
        }else{
            goodsView.goods = nil;
        }
        goodsView.cartHidden = self.cartHidden;
        goodsView.collectionHidden = self.collectionHidden;
    }
}


@end
