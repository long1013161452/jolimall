//
//  XZZSecondsKillGoods.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/28.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZSecondsKillGoods : NSObject
/**
 * 原价
 */
@property (nonatomic, assign)CGFloat currentPrice;
/**
 * 折扣比
 */
@property (nonatomic, assign)CGFloat discountPercent;
/**
 * 已卖出商品
 */
@property (nonatomic, assign)NSInteger haveSale;
/**
 * 已卖出百分比
 */
@property (nonatomic, assign)CGFloat haveSalePercent;
/**
 * 秒杀价格
 */
@property (nonatomic, assign)CGFloat salePrice;
/**
 * 秒杀数量
 */
@property (nonatomic, assign)NSInteger seckillStock;
/**
 * 商品标题
 */
@property (nonatomic, strong)NSString * title;
/**
 * 商品图片
 */
@property (nonatomic, strong)NSString * pictureUrl;
/**
 * id
 */
@property (nonatomic, strong)NSString * ID;
@end

NS_ASSUME_NONNULL_END
