//
//  XZZCouponListViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZMainViewController.h"


typedef void(^ChooseCoupons)(XZZCouponsInfor * couponsInfor);

NS_ASSUME_NONNULL_BEGIN

/**
 *  优惠券列表
 */
@interface XZZCouponListViewController : XZZMainViewController

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * goodsArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)ChooseCoupons chooseCoupons;

@end

NS_ASSUME_NONNULL_END
