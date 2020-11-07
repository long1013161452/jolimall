//
//  XZZCreditCardViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"
#import "XZZOrderDetail.h"

#import "XZZOrderPriceInfor.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  信用卡支付
 */
@interface XZZCreditCardViewController : XZZMainViewController

/**
 * 订单详情
 */
@property (nonatomic, strong)XZZOrderDetail * orderDetail;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderPriceInfor * priceInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZRequestCheckOut * requestCheckOut;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddressInfor * addressInfor;

/**
 * 支付类型
 */
@property (nonatomic, assign)NSInteger payType;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * orderId;

@end

NS_ASSUME_NONNULL_END
