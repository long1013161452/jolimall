//
//  XZZOrderList.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZOrderSku.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  订单列表数据
 */
@interface XZZOrderList : NSObject

/**
 * //    string($date-time)下单时间
 */
@property (nonatomic, strong)NSString * createTime;

/**
 * //    integer($int64)订单号
 */
@property (nonatomic, strong)NSString * orderId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<XZZOrderSku *> * skus;//    [...]
/**
 * //    integer($int32)订单状态
 */
@property (nonatomic, assign)int status;

/**
 * //    number总金额
 */
@property (nonatomic, assign)CGFloat totalAmount;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int itmes;

/**
 * 是否所有商品已评价
 */
@property (nonatomic, assign)BOOL isComment;

@end


NS_ASSUME_NONNULL_END
