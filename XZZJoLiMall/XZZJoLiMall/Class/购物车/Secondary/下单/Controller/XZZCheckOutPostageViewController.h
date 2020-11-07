//
//  XZZCheckOutPostageViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCouponListViewController.h"

#import "XZZOrderPriceInfor.h"

#import "XZZCheckOutData.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  选择邮费信息  下单
 */
@interface XZZCheckOutPostageViewController : XZZMainViewController

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutData * checkOutData;

@end

NS_ASSUME_NONNULL_END
