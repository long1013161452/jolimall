//
//  XZZOrderDetail.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZZOrderSku.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  z订单详情
 */
@interface XZZOrderDetail : NSObject


/**
 *   string城市
 */
@property (nonatomic, strong)NSString * cityName ;

/**
 *  string国家
 */
@property (nonatomic, strong)NSString * countryName ;

/**
 * string($date-time)下单时间
 */
@property (nonatomic, strong)NSString * createTime ;
/**
 * 订单取消时间
 */
@property (nonatomic, strong)NSString * orderCancelTime;
/**
 * 当前时间
 */
@property (nonatomic, strong)NSString * currentTime;
/**
 * string详细地址1
 */
@property (nonatomic, strong)NSString * detailAddress1 ;

/**
 *  string详细地址2
 */
@property (nonatomic, strong)NSString * detailAddress2;

/**
 *  string姓
 */
@property (nonatomic, strong)NSString * firstName ;

/**
 *  string名
 */
@property (nonatomic, strong)NSString * lastName ;

/**
 *  integer($int64)订单号
 */
@property (nonatomic, strong)NSString * orderId ;
/**
 * 物流单号
 */
@property (nonatomic, strong)NSString * transportCode;
/**
 * 订单使用的优惠码
 */
@property (nonatomic, strong)NSString * couponCode;
/**
 *   string联系方式
 */
@property (nonatomic, strong)NSString * phone ;

/**
 * vstring省
 */
@property (nonatomic, strong)NSString * provinceName;

/**
 * number邮费
 */
@property (nonatomic, assign)CGFloat shipping;
/**
 * 商品总价
 */
@property (nonatomic, assign)CGFloat subTotal;
/**
 * 优惠jin'金额e
 */
@property (nonatomic, assign)CGFloat discount;
/**
 * 利润
 */
@property (nonatomic, assign)CGFloat profit;
/**
 * integer($int64)收获地址id
 */
@property (nonatomic, strong)NSString * shippingId;

/**
 * [...]
 */
@property (nonatomic, strong)NSArray<XZZOrderSku *> * skus    ;
/**
 *  integer($int32)订单状态
 */
@property (nonatomic, assign)int status ;

/**
 *  number总金额
 */
@property (nonatomic, assign)CGFloat total;

/**
 *     string邮编
 */
@property (nonatomic, strong)NSString * zipCode;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddressInfor * shippingAddress;

@end

NS_ASSUME_NONNULL_END
