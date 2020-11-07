//
//  XZZCheckOutData.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/21.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZOrderPostageInfor.h"

#import "XZZOrderPriceInfor.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZZCheckOutData : NSObject


/**
 * 要下单商品数组
 */
@property (nonatomic, strong)NSArray<XZZCartInfor *> * cartInforArray;
/**
 * 是否是立即购买
 */
@property (nonatomic, assign)BOOL isBuyNow;

/**
 * 下单地址信息
 */
@property (nonatomic, strong)XZZAddressInfor * addressInfor;
/**
 * 配送方式
 */
@property (nonatomic, strong)XZZOrderPostageInfor * postageInfor;
/**
 * 优惠券信息
 */
@property (nonatomic, strong)XZZCouponsInfor * couponsInfor;

/**
 * 费用信息
 */
@property (nonatomic, strong)XZZOrderPriceInfor * priceInfor;

/**
 * 选中利润   0 未选中  1 选中
 */
@property (nonatomic, strong)NSString * selectedProfit;

@end

NS_ASSUME_NONNULL_END
