//
//  XZZRequestOrder.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/12.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XZZSkuNum;
NS_ASSUME_NONNULL_BEGIN
/**
 *  下单
 */
@interface XZZRequestCheckOut : NSObject
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * email;
/**
 * 联系方式
 */
@property (nonatomic, strong)NSString * contact;
/**
 * 账单地址id
 */
@property (nonatomic, strong)NSString * billingId;
/**
 * 优惠码
 */
@property (nonatomic, strong)NSString * couponCode;
/**
 * 支付方式  0 payPal支付 1.stripe信用卡 2.iplinks支付 3 wordpay支付
 */
@property (nonatomic, assign)int payType;
/**
 * 邮费
 */
@property (nonatomic, strong)NSString * postFeePrice;
/**
 * 收货地址id
 */
@property (nonatomic, strong)NSString * shippingId;
/**
 * 物流方式 物流方式(平邮:1,商业邮:2)
 */
@property (nonatomic, strong)NSString * transportId;
/**
 * sku信息
 */
@property (nonatomic, strong)NSArray<XZZSkuNum *> * skus;
/**
 * 订单来源 登录状态且订单商品来自购物车传 1
 */
@property (nonatomic, strong)NSString * sourceType;
/**
 * 默认是1
 */
@property (nonatomic, strong)NSString * clientType;
/**
 * 支付金额
 */
@property (nonatomic, strong)NSString * total;
/**
 * userCouponId
 */
@property (nonatomic, strong)NSString * userCouponId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * profit;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int profitChoose;

/**
 * <#expression#>
 */
//@property (nonatomic, assign)int weight;

@end


/**
 *  支付
 */
@interface XZZRequestOrderPay : NSObject

/**
 * 支付类型 0.payPal支付1.stripe支付 2.iPaylink支付 3.wordPay支付
 */
@property (nonatomic, assign)NSInteger payType;
/**
 * 来源
 */
@property (nonatomic, strong)NSString * paySource;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * stripeToken;
/**
 * 金额
 */
@property (nonatomic, strong)NSString * payAmount;
/**
 * 订单id
 */
@property (nonatomic, strong)NSString * orderId;
/**
 * 失效年份
 */
@property (nonatomic, strong)NSString * expirationYear;
/**
 * 失效月份
 */
@property (nonatomic, strong)NSString * expirationMonth;
/**
 * cvv
 */
@property (nonatomic, strong)NSString * cvv;

/**
 * 信用卡卡号
 */
@property (nonatomic, strong)NSString * cardNo;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * currency;

/**
 * 联系方式
 */
@property (nonatomic, strong)NSString * contact;
/**
 * 邮箱
 */
@property (nonatomic, strong)NSString * email;
/**
 * 姓名
 */
@property (nonatomic, strong)NSString * firstName;
/**
 * 姓名
 */
@property (nonatomic, strong)NSString * lastName;

@end





NS_ASSUME_NONNULL_END
