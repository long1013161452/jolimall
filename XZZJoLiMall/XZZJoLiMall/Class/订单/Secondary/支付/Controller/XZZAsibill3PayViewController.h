//
//  XZZAsibill3PayViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZAsiaBillPay.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZZAsibill3PayViewController : XZZMainViewController

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAsiaBillPay * asiaBillPay;

/**
 * 订单号
 */
@property (nonatomic, strong)NSString * orderId;

@end

NS_ASSUME_NONNULL_END
