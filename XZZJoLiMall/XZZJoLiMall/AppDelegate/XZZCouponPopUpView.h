//
//  XZZCouponPopUpView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/5.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetAllCoupons)(NSArray * couponsArray);

NS_ASSUME_NONNULL_BEGIN

@interface XZZCouponPopUpView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * couponArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GetAllCoupons getAllCoupons;

@end

NS_ASSUME_NONNULL_END
