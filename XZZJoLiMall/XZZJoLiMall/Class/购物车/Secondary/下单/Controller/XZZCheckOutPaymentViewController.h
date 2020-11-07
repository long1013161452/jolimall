//
//  XZZCheckOutPaymentViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCouponListViewController.h"


#import "XZZOrderPostageInfor.h"
#import "XZZOrderPriceInfor.h"

#import "XZZCheckOutData.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  选择支付方式  下单
 */
@interface XZZCheckOutPaymentViewController : XZZMainViewController
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutData * checkOutData;

@end

NS_ASSUME_NONNULL_END
