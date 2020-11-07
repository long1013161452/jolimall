//
//  XZZGoodsDiscount.h
//  ZBYElectricity
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 long. All rights reserved.
//

#import <Foundation/Foundation.h>


#define All_Goods_Discount [XZZGoodsDiscount sharedGoodsDiscount]

/**
 *  所有商品的折扣信息
 */
@interface XZZGoodsDiscount : NSObject


+ (XZZGoodsDiscount *)sharedGoodsDiscount;

/**
 * 所有折扣率
 */
@property (nonatomic, strong)NSMutableDictionary * discountDict;

/**
 *  获取折扣率
 */
- (CGFloat)getDiscountGoodsId:(NSString *)goodsId;

@end



