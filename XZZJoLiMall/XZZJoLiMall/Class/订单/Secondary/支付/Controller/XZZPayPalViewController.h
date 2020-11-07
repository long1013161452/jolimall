//
//  XZZPayPalViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  paypal 支付
 */
@interface XZZPayPalViewController : XZZMainViewController

/**
 * PayPal支付链接
 */
@property (nonatomic, strong)NSString * payPalUrlStr;

/**
 * 订单id
 */
@property (nonatomic, strong)NSString * orderId;

/**
 * 商品个数
 */
@property (nonatomic, assign)NSInteger numItems;


/**
 * 是否是第一次支付  用来标识是从哪里进来页面的    yes为下单的时候进入   no为再次支付进入
 */
@property (nonatomic, assign)BOOL firstPayment;

@end

NS_ASSUME_NONNULL_END
