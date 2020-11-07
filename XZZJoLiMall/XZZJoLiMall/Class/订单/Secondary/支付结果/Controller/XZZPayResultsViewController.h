//
//  XZZPayResultsViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  支付结果
 */
@interface XZZPayResultsViewController : XZZMainViewController

/**
 * 支付结果
 */
@property (nonatomic, assign)bool payResults;

/**
 * 订单id
 */
@property (nonatomic, strong)NSString * orderId;

/**
 * 1 信用卡 2PayPal支付
 */
@property (nonatomic, assign)int payType;

/**
 * 商品个数
 */
@property (nonatomic, assign)int numItems;

/**
 * 支付金额
 */
@property (nonatomic, assign)CGFloat payAmout;



@end

NS_ASSUME_NONNULL_END
