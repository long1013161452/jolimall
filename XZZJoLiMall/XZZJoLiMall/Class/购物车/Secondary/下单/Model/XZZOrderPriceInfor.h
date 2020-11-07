//
//  XZZOrderPriceInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/1.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  订单价格信息
 */
@interface XZZOrderPriceInfor : NSObject
/**
 * 折扣金额
 */
@property (nonatomic, assign)CGFloat discount;// (number, optional),
/**
 *  原始金额   商品总价
 */
@property (nonatomic, assign)CGFloat skuTotal;// (number, optional),
/**
 * 折扣后的价格
 */
@property (nonatomic, assign)CGFloat total;// (number, optional),
/**
 * 运费
 */
@property (nonatomic, assign)CGFloat postFeePrice;// (number, optional)
/**
 * 支付金额  实际付款金额
 */
@property (nonatomic, assign)CGFloat payTotal;
/**
 * 利润
 */
@property (nonatomic, assign)CGFloat profit;

@end







NS_ASSUME_NONNULL_END
